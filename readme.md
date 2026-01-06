**SQL projekt: Analýza mezd a cen potravin v ČR a vliv HDP**

**Autor: Karolína Hynková**

Cílem projektu bylo zanalyzovat vývoj mezd a cen potravin v ČR a porovnat je s ekonomickými ukazateli HDP. Projekt odpovídá na 5 výzkumných otázek a využívá veřejná data: 
czechia_payroll - mzdy
czechia_price - ceny potravin
economies - makroekonomická data
a další

Výsledkem jsou 2 vytvořené tabulky:

Primární tabulka: t_karolina_hynkova_project_sql_primary_final
- Pro data mezd a cen potravin pro ČR sjednocených na společné roky

Sekundární tabulka: t_karolina_hynkova_project_sql_secondary_final
- Pro dodatečná data o dalších evropských státech

Odpovědi na zadané otazky:

**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**
- Mzdy nerostou ve všech odvětví nepřetržitě
- Existují roky s poklesem, hlavně v letech 2009 - 2011 a 2013 (ekonomická krize)

**2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelný rok?**
- V prvním srovnatelném období si šlo koupit výrazně méně l mléka nebo kg chleba než v posledním srovnatelném roce
- Za 1. srovnatelné obd. rok 2006 si lze koupit 1.431,93 litrů mléka nebo 1.282,69 kg chleba
- Za poslední srovnatelné obd. rok 2018 si lze koupit 1.639,01 litrů mléka nebo 1.340,14 kg chleba

**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
- Nejpomaleji zdražuje cukr krystal tempem -1,92%
- Cukr je tedy dlouhodobě nejstabilnější a dokonce meziročně zlevňoval

**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10%)?**
- Neexistuje rok, kde by byl meziroční růst cen potravin výrazně vyšší než 10%
- Nejvyšší rozdíl je v roce 2013 +6,66%
- Ještě rok 2009 byl krizový -9,57%, kdy potraviny výrazně zlevnily a mzdy stále rostly

**5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**
- Některé hodnoty nejsou vyplněny a obsahují NULL 
- Meziročního růstu HDP, mezd a cen potravin ukazuje, že růst HDP má slabý až žádný přímý vliv na ceny potravin. Naopak mzdy reagují stabilněji a částečně se projevuje i zpožděná vazba v následujícím roce. Ceny potravin nejsou tak stabilní jako mzdy a jejich meziroční změny jsou ovlivněny řadou dalších faktorů.
- HDP má hlavně vliv na růst mezd. U potravin je slabší až nestabilní

**Závěr projektu:**
- Mzdy v ČR mají dlouhodobě rostoucí trend, přestože některá odvětví zažila krátkodobé propady.
- Dostupnost mléka nebo chleba se výrazně zlepšila, protože mzdy rostly rychleji než ceny.
- Nejstabilnější položkou je cukr krystal, který v průměru dokonce zlevňoval. Smutné zjištění.
- Neexistuje výrazně větší odchylka než 10%, kde by byl výrazný rozdíl růst cen potravin a mezd
- HDP silně koreluje s růstem mezd, ale né s cenami potravin
- Česká ekonomika tedy dlouhodobě posiluje a růst životní úrovně se promítá hlavně do rostoucích mezd a lepší dostupnosti potravin. 