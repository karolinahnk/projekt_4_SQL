-- 1. otázka: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT
    t.industry_code AS industry,
    t.industry_name,
    t.year,
    t.avg_wage
FROM t_karolina_hynkova_project_sql_primary_final t
ORDER BY
    t.industry_name,
    t.year;
--zjištění průměrné mzdy podle odvětví a roku, odvětví není všude přiřazeno (hodnota null)

WITH wage_changes AS (
    SELECT
        industry_name,
        year,
        avg_wage,
        avg_wage
            - LAG(avg_wage) OVER (PARTITION BY industry_name ORDER BY year) AS yoy_change
    FROM t_karolina_hynkova_project_sql_primary_final
)
SELECT
    industry_name,
    year,
    avg_wage,
    yoy_change,
    CASE
        WHEN yoy_change < 0 THEN 'Pokles mezd'
        ELSE 'Růst / beze změny'
    END AS wage_trend
FROM wage_changes
WHERE yoy_change < 0
ORDER BY industry_name, year;
--porovnání mzdy s předchozím rokem, vybrání odvětví s poklesem mzdy
--odstranění duplicitních řádků