-- 5. otázka: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste 
--výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím 
--roce výraznějším růstem?

with base as (
	select 
		p.year,
		p.avg_wage,
		(p.price_milk + p.price_bread) / 2 as avg_food_price,
		e.gdp
	from t_karolina_hynkova_project_sql_primary_final p
	join economies e 
		on p.year = e.year 
		and (e.country = 'Czech Republic' or e.country ilike '%Czech%')
),
yoy as (
	select 
		year,
		avg_wage,
		gdp,
		avg_food_price,
		round(((avg_wage - lag(avg_wage) over(order by year))
			/ nullif(lag(avg_wage) over(order by year), 0))::numeric, 2) as wage_yoy,
		round(((gdp - lag(gdp) over(order by year))
			/ nullif(lag(gdp) over(order by year), 0))::numeric, 2) as gdp_yoy,
		round(((avg_food_price -lag(avg_food_price) over(order by year))
			/ nullif(lag(avg_food_price) over(order by year), 0))::numeric, 2) as food_yoy
	from base
),
with_leads as (
	select
		year,
		gdp_yoy,
		wage_yoy,
		food_yoy,
		lead(wage_yoy) over (order by year) as wage_yoy_next,
		lead(food_yoy) over (order by year) as food_yoy_next
	from yoy
)
select *
from with_leads
order by year;

--výpočty pro meziroční změny DGP, mzdy, potravin(průměr všech položek)
-- na základě výsledků nelze potvrdit, ale ani vyvrátit, že by tyto faktory měly přímý vliv na cenu potravin
-- u mezd se souvislost objevuje. Pokud HDP v jednom roce výrazně vzroste další rok je i růst mezd