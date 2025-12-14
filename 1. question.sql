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

SELECT
    industry_name,
    year,
    avg_wage,
    avg_wage
      - LAG(avg_wage) OVER (PARTITION BY industry_name ORDER BY year) AS yoy_change
FROM t_karolina_hynkova_project_sql_primary_final
ORDER BY industry_name, year;
--výpočet meziročních změn mezd za každý rok
