-- primární tabulka pro ČR
create table t_karolina_hynkova_project_SQL_primary_final as 
select
	w.year,
	w.avg_wage,
	c.price_milk,
	c.price_bread
from ( 
	select
		payroll_year as year,
		round(avg(value)::numeric, 2) as avg_wage
	from czechia_payroll p
	where value_type_code = 5958
	group by payroll_year
) w
left join ( 
	select
		extract(year from date_from) as year,
		round(avg(case when pc.name = 'Mléko polotučné pasterované' then cp.value end)::numeric, 2) as price_milk,
		round(avg(case when pc.name = 'Chléb konzumní kmínový' then cp.value end)::numeric, 2) as price_bread
	from czechia_price cp
	join czechia_price_category pc on cp.category_code = pc.code
	group by extract(year from date_from)
) c using(year)
order by year;


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
  AND e.year IN (SELECT year FROM t_karolina_hynkova_project_SQL_primary_final)
ORDER BY e.year, c.country;
