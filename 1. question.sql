-- 1. otázka: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

select 
	industry_branch_code as industry,
	ib.name as industry_name,
	payroll_year as year,
	round(avg(value), 2) as avg_wage
from czechia_payroll cp
left join czechia_payroll_industry_branch ib 
    on cp.industry_branch_code = ib.code
where value_type_code = 5958
group by cp.industry_branch_code, ib.name, cp.payroll_year
order by cp.industry_branch_code, cp.payroll_year;
--zjištění průměrné mzdy podle odvětví a roku, odvětví není všude přiřazeno (hodnota null)

select 
	industry,
	industry_name,
	year,
	avg_wage,
	avg_wage - lag(avg_wage) over (partition by industry order by year) as yoy_change
from (
	select 
		cp.industry_branch_code as industry,
		ib.name as industry_name,
		cp.payroll_year as year,
		round(avg(cp.value), 2) as avg_wage
	from czechia_payroll cp
	left join czechia_payroll_industry_branch ib 
        on cp.industry_branch_code = ib.code
	where cp.value_type_code = 5958
	group by cp.industry_branch_code, ib.name, cp.payroll_year 
) as wages_table
order by industry, year;
--výpočet mezročních změn, mzdy za každý rok
-- mzdy rostou ve všech odvětví, ale ne rovnoměrně. v některých odvětví dochází i k poklesu.