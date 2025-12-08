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
drop table if exists t_karolina_hynkova_project_sql_secondary_final;
create table t_karolina_hynkova_project_SQL_secondary_final ( 
	year integer primary key,
	avg_wage numeric(10,2),
	price_milk numeric(10,2),
	price_bread numeric(10,2),
	litres_milk numeric(10,2),
	kg_bread numeric(10,2),
	wage_yoy numeric(10,2),
	milk_yoy numeric(10,2),
	bread_yoy numeric(10,2),
	gdp numeric(15,2),
	gini numeric(10,2),
	population numeric(15,2)
);

-- propojení obou tabulek
insert into t_karolina_hynkova_project_sql_secondary_final (
    year, avg_wage, price_milk, price_bread,
    litres_milk, kg_bread,
    wage_yoy, milk_yoy, bread_yoy,
    gdp, gini, population
)
select
	p.year,
	p.avg_wage,
	p.price_milk,
	p.price_bread,
-- kolik l mléka a kg chleba lze koupit za prům. mzdu
	case when p.price_milk > 0 then round(p.avg_wage / p.price_milk, 2) end as litres_milk,
	case when p.price_bread > 0 then round(p.avg_wage / p.price_bread, 2) end as kg_bread,
--meziroční procentuální změna mezd
	round((p.avg_wage - lag(p.avg_wage) over (order by p.year))
		/ lag(p.avg_wage) over (order by p.year) * 100, 2) as wage_yoy,
-- meziroční procentuální změna mléka
	round((p.price_milk - lag(p.price_milk) over (order by p.year))
		/ lag(p.price_milk) over (order by p.year) * 100, 2) as milk_yoy,	
--meziroční procentuální změna chleba
	round((p.price_bread - lag(p.price_bread) over (order by p.year))
		/ lag(p.price_bread) over (order by p.year) * 100, 2) as bread_yoy,
-- HDP, GINI, populace
	e.gdp,
	e.gini,
	e.population	
from t_karolina_hynkova_project_SQL_primary_final p
left join economies e 
	on p.year = e.year
	and e.country = 'Czech Republic'
order by p.year;