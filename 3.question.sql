--- 3. otázka: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 

WITH yearly_prices AS (
	SELECT
        food_category_name AS category,
        year,
        ROUND(AVG(avg_price), 2) AS avg_price
    FROM t_karolina_hynkova_project_sql_primary_final
    GROUP BY food_category_name, year
),
yearly_pct_change AS (
    SELECT
        category,
        year,
        avg_price,
        LAG(avg_price) OVER (PARTITION BY category ORDER BY year) AS prev_price,
        ROUND((avg_price - LAG(avg_price) OVER (PARTITION BY category
        ORDER BY year))
        / NULLIF(LAG(avg_price) OVER (PARTITION BY category ORDER BY year), 0) * 100, 2) AS pct_change
    FROM yearly_prices
)
SELECT
    category,
    ROUND(AVG(pct_change), 2) AS avg_yearly_pct_growth
FROM yearly_pct_change
WHERE pct_change IS NOT NULL
GROUP BY category
ORDER BY avg_yearly_pct_growth ASC
LIMIT 1;
-- sjednocení cen za rok AVG(avg_price), zjištění procentuálního vývoje potravin pro každý rok
-- vybrýní kategorie potravin, která zdražuje nejpomaleji