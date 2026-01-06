-- 2. otázka: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

WITH milk_bread AS (
    SELECT
        year,
        food_category_name,
        AVG(avg_wage) AS avg_wage,
        AVG(avg_price) AS avg_price
    FROM t_karolina_hynkova_project_sql_primary_final
    WHERE food_category_name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
    GROUP BY year, food_category_name
),
bounds AS (
    SELECT
        MIN(year) AS first_year,
        MAX(year) AS last_year
    FROM milk_bread
)
SELECT
    mb.year,
    mb.food_category_name,
    mb.avg_wage,
    mb.avg_price,
    ROUND(mb.avg_wage / mb.avg_price, 2) AS purchasable_amount
FROM milk_bread mb
JOIN bounds b
    ON mb.year IN (b.first_year, b.last_year)
ORDER BY
    mb.year,
    mb.food_category_name;
-- vybrání dat jen pro mléko a chléb. Pomocí fce MIN a MAX vybrané první a poslední srov. obd.