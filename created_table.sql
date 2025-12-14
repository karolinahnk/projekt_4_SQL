-- primární tabulka pro ČR
CREATE TABLE t_karolina_hynkova_project_SQL_primary_final AS
WITH common_years AS (
    SELECT DISTINCT payroll_year AS year
    FROM czechia_payroll
    WHERE value_type_code = 5958
    INTERSECT
    SELECT DISTINCT EXTRACT(YEAR FROM date_from)::int
    FROM czechia_price
),
wages AS (
    SELECT
        p.payroll_year AS year,
        p.industry_branch_code AS industry_code,
        ib.name AS industry_name,
        ROUND(AVG(p.value)::numeric, 2) AS avg_wage
    FROM czechia_payroll p
    JOIN czechia_payroll_industry_branch ib
        ON p.industry_branch_code = ib.code
    JOIN common_years y
        ON p.payroll_year = y.year
    WHERE p.value_type_code = 5958
    GROUP BY
        p.payroll_year,
        p.industry_branch_code,
        ib.name
),
prices AS (
    SELECT
        EXTRACT(YEAR FROM cp.date_from)::int AS year,
        pc.code AS food_category_code,
        pc.name AS food_category_name,
        ROUND(AVG(cp.value)::numeric, 2) AS avg_price
    FROM czechia_price cp
    JOIN czechia_price_category pc
        ON cp.category_code = pc.code
    JOIN common_years y
        ON EXTRACT(YEAR FROM cp.date_from)::int = y.year
    GROUP BY
        EXTRACT(YEAR FROM cp.date_from),
        pc.code,
        pc.name
)
SELECT
    w.year,
    w.industry_code,
    w.industry_name,
    p.food_category_code,
    p.food_category_name,
    w.avg_wage,
    p.avg_price
FROM wages w
JOIN prices p
    ON w.year = p.year
ORDER BY
    w.year,
    w.industry_name,
    p.food_category_name;


-- sekundární tabulka pro Evropu
CREATE TABLE t_karolina_hynkova_project_SQL_secondary_final AS
SELECT
    e.year,
    c.country,
    e.gdp,
    e.gini,
    e.population
FROM economies e
JOIN countries c 
    ON e.country = c.country
WHERE c.continent = 'Europe'
  AND e.year IN ( SELECT DISTINCT YEAR t_karolina_hynkova_project_SQL_primary_final)
ORDER BY e.year, c.country;
