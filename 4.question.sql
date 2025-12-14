-- 4. otázka: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH yearly_food_prices AS (
    SELECT
        year,
        ROUND(AVG(avg_price), 2) AS avg_food_price
    FROM t_karolina_hynkova_project_sql_primary_final
    GROUP BY year
),
yearly_wages AS (
    SELECT
        year,
        ROUND(AVG(avg_wage), 2) AS avg_wage
    FROM t_karolina_hynkova_project_sql_primary_final
    GROUP BY year
),
yearly_changes AS (
    SELECT
        f.year,
        f.avg_food_price,
        w.avg_wage,
        ROUND(
            (f.avg_food_price - LAG(f.avg_food_price) OVER (ORDER BY f.year))
            / NULLIF(LAG(f.avg_food_price) OVER (ORDER BY f.year), 0) * 100, 2) AS food_yoy,
        ROUND(
            (w.avg_wage - LAG(w.avg_wage) OVER (ORDER BY w.year))
            / NULLIF(LAG(w.avg_wage) OVER (ORDER BY w.year), 0) * 100, 2) AS wage_yoy
    FROM yearly_food_prices f
    JOIN yearly_wages w
        ON f.year = w.year
)
SELECT
    year,
    food_yoy,
    wage_yoy,
    ROUND(food_yoy - wage_yoy, 2) AS diff
FROM yearly_changes
WHERE food_yoy - wage_yoy >= 10
ORDER BY year;

-- nový sloupec s prům. cenou potravin za rok
-- spočítání meziročního růstu potravin a mezd
-- vyfitrování roků kde je rozdíl >= 10% (neni žádný)
-- kontrola bez WHERE food_yoy - wage_yoy >= 10 