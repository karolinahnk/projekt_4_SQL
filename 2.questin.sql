--Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
select 
	year,
	avg_wage,
	price_milk,
	price_bread,
	round(avg_wage / price_milk, 2) as litres_of_milk,
	round(avg_wage / price_bread, 2) as kg_of_bread
from t_karolina_hynkova_project_sql_primary_final
where price_milk is not null and price_bread is not null 
order by year asc 
limit 1;
-- za 1. srovnatelné obd. rok 2006 si lze koupit 1.431,93 litrů mléka a 1.282,69 kg chleba

select 
	year,
	avg_wage,
	price_milk,
	price_bread,
	round(avg_wage / price_milk, 2) as litres_of_milk,
	round(avg_wage / price_bread, 2) as kg_of_bread
from t_karolina_hynkova_project_sql_primary_final
where price_milk is not null and price_bread is not null 
order by year desc 
limit 1;
-- za poslední srovnatelné obd. rok 20018 si lze koupit 1.639,01 litrů mléka a 1.340,14 kg chleba
-- lze si tedy koupit více l mléka a více kg chleba než na začátku srovnatelného obd.