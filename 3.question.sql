--Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 

with yearly_prices as (
	select
		pc.name as category,
		extract(year from cp.date_from) as year,
		round(avg(cp.value)::numeric, 2) as avg_price
	from czechia_price cp 
	join czechia_price_category pc
		on cp.category_code = pc.code 
	group by pc.name, extract(year from cp.date_from) --spočítání průměrné ceny pro každou kategorii v každém roce
),
yearly_pct_change as (
	select 
		category,
		year,
		avg_price,
		lag(avg_price) over (partition by category order by year) as prev_price,
		round( 
			(avg_price - lag(avg_price) over (partition by category order by year))
			/ nullif(lag(avg_price) over (partition by category order by year), 0) * 100,
			2
		) as pct_change
	from yearly_prices
)
--procentuální vývoj ceny potravin pro každý rok
select 
	category,
	round(avg(pct_change), 2) as avg_yearly_pct_growth
from yearly_pct_change
where pct_change is not null
group by category
order by avg_yearly_pct_growth asc
limit 1;

-- pomocí dvou pomocných tabulek jedna pro průměrné ceny potravin pro každý rok a druhá pro procentuální změny
-- mezi roky. Jsme zjistili, že cena cukru krystal se každý rok snižovala tempem -1,92%