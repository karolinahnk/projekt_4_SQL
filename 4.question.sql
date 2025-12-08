-- 4. otázka: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

with food_prices as ( 
	select 
		year,
		(price_milk + price_bread) / 2 as avg_food_price
	from t_karolina_hynkova_project_sql_primary_final 
),
yearly_changes as ( 
	select 
		p.year,
		p.avg_food_price,
		t.avg_wage,
		round(
			(p.avg_food_price - lag(p.avg_food_price) over (order by p.year))
			/ nullif(lag(p.avg_food_price) over (order by p.year), 0) * 100, 2) as food_yoy,
		round(
			(t.avg_wage - lag(t.avg_wage) over (order by t.year))
			/ nullif(lag(t.avg_wage) over (order by t.year), 0) * 100, 2) as wage_yoy			
	from food_prices p
	join t_karolina_hynkova_project_sql_primary_final t
		on p.year = t.year
)	
select
	year,
	food_yoy,
	wage_yoy,
	(food_yoy - wage_yoy) as diff
from yearly_changes 
where (food_yoy - wage_yoy) >= 10;

-- vytvořili jsme nový sloupec s prům. cenou reprezentativních potravin
--výpočet procentuálního růstu cen potravin a mzdy pro každý rok
-- vyfitrování roků kde je rozdíl >= 10%
-- odpovědí je, že jsou dva roky 2008 a 2011, kde je výšší růst cen potravin než mezd o více než 10%