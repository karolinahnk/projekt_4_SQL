SQL projekt: Analýza mezd a cen potravin v ČR a vliv HDP
Autor: Karolína Hynková

Cílem projektu bylo zanalyzovat vývoj mezd a cen potravin v ČR a porovnat je s ekonomickými ukazateli HDP. Projekt odpovídá na 5 výzkumných otázek a využívá veřejná data: 
czechia_payroll - mzdy
czechia_price - ceny potravin
economies - makroekonomická data
a další

Výsledkem jsou 2 vytvořené tabulky:

Primární tabulka: t_karolina_hynkova_project_sql_primary_final
-Pro data mezd a cen potravin pro ČR sjednocených na společné roky

Sekundární tabulka: t_karolina_hynkova_project_sql_secondary_final
- Pro dodatečná data o dalších evropských státech

Odpovědi na zadané otazky:
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
- Ve většině odvětví mzdy dlouhodobě a stabilně rostou
- Existují roky s poklesem, hlavně kolem roku 2009 (ekonomická krize)
- Po roce 2013 nastává vytrvalý růst napříč skoro všemi odvětvími
- Mzdy nerostou rovnoměrně ve všech odvětví, ale dlouhodobý trend je růstový
- Odvětví nejsou vyplněna všude, vyskutuje se hodnota NULL

2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelný rok?
- V prvním srovnatelném období si šlo koupit výrazně méně l mléka a kg chleba než v posledním srovnatelném roce
- Za 1. srovnatelné obd. rok 2006 si lze koupit 1.431,93 litrů mléka a 1.282,69 kg chleba
- Za poslední srovnatelné obd. rok 20018 si lze koupit 1.639,01 litrů mléka a 1.340,14 kg chleba
- Z toho plyne, že růst mezd překonal růst potravin

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
- Nejpomaleji zdražuje cukr krystal tempem -1.92%
- Cukr je tedy dlouhodobě nejstabilnější a dokonce meziročně zlevňoval

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
- Existují dokonce 2 roky, kdy potraviny zdražily výrazně více než mzdy a v obou případech to zapříčinil silný ekonomický tlak
- 2008 nárůst způsobila vysoká cena ropy, rostoucí poptávka po biopalivech, špatná úroda
- 2011 nárůst způsobilo nepříznivé počasí a pokles produkce, nízké světové zásoby, rostoucí poptávka, vysoká cena energií

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
- některé hodnoty nejsou vyplněny a obsahují NULL
- I přesto růst HDP se velmi dobře shoduje s růstem mezd
- U cen potravin toto tvrzení nelze potvrdit, ale ani vyvrátit. Křivku HDP kopírují slaběji a spíše následují obecnou inflaci než růst ekonomiky
- HDP má hlavně vliv na růst mezd. U potravin je slabší až nestabilní

Závěr projektu:
- Mzdy v ČR mají dlouhodobě rostoucí trend, přestože některá odvětví zažila krátkodobé propady.
- Dostupnost mléka a chleba se výrazně zlepšila, peorože mzdy rostly rychleji než ceny.
- Nejstabilnější položkou je cukr krystal, který v průměru dokonce zlevňoval. Smutné zjištění.
- V 2008 a 2011 došlo k mimořádnému růstu cen potravin.
- HDP silně koreluje s růstem mezd, ale né s cenami potravin
- Česká ekonomika tedy dlouhodobě posiluje a růst životní úrovně se promítá hlavně do rostoucích mezd a lepší dostupnosti potravin. 