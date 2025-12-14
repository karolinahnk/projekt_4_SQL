-- 5. otázka: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste 
--výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím 
--roce výraznějším růstem?

WITH food_avg_per_year AS (
    SELECT
        year,
        AVG(avg_price) AS avg_food_price
    FROM t_karolina_hynkova_project_sql_primary_final
    GROUP BY year
),
base AS (
    SELECT
        f.year,
        f.avg_food_price,
        w.avg_wage,
        s.gdp
    FROM food_avg_per_year f
    JOIN (
        SELECT
            year,
            AVG(avg_wage) AS avg_wage
        FROM t_karolina_hynkova_project_sql_primary_final
        GROUP BY year
    ) w USING (year)
    JOIN t_karolina_hynkova_project_sql_secondary_final s
        ON f.year = s.year
       AND s.country = 'Czech Republic'
),
yoy AS (
    SELECT
        year,
        ROUND(((avg_food_price - LAG(avg_food_price) OVER (ORDER BY year))
        / NULLIF(LAG(avg_food_price) OVER (ORDER BY year), 0))::numeric, 2) AS food_yoy,
        ROUND(((avg_wage - LAG(avg_wage) OVER (ORDER BY year))
        / NULLIF(LAG(avg_wage) OVER (ORDER BY year), 0))::numeric, 2) AS wage_yoy,
        ROUND(((gdp - LAG(gdp) OVER (ORDER BY year))
        / NULLIF(LAG(gdp) OVER (ORDER BY year), 0))::numeric, 2) AS gdp_yoy
    FROM base
),
final AS (
    SELECT
        year,
        gdp_yoy,
        wage_yoy,
        food_yoy,
        LEAD(wage_yoy) OVER (ORDER BY year) AS wage_yoy_next_year,
        LEAD(food_yoy) OVER (ORDER BY year) AS food_yoy_next_year
    FROM yoy
)
SELECT *
FROM final
ORDER BY year;

-- výpočet průměrné ceny všech potravin za rok
-- následný výpočet meziročních změn 
