// Ricardo Bautista Huerta

cd "Stata Enaho\Bases"
clear all
set more off

*Traducir a unicode
unicode analyze *
unicode encoding set ISO-8859-1
unicode translate *

// 1
*Base 300, 2019 y 2018*
use "enaho01a-2019-300.dta",clear

append using "enaho01a-2018-300.dta"

drop if p203==0

save "Personas.dta"

// Según el INEI (2019), para considerar una persona analfabeta tiene que tener 
// más de 15 años y no saber leer ni escribir. Se considerará solo
// a los miembros del hogar por tratarse de un indicador social

gen 	analfabet = 0 if p208 >= 15 & p204 == 1
replace analfabet = 1 if p208 >= 15 & p302 == 2 & p204 == 1

label define analfabet 1 "Sí" 0 "No"
label variable analfabet "Es analfabeto"
label values analfabet analfabet

tab aÑo analfabet [iweight=factora07], nofreq row
// En el 2019 el 5.55% de la población fue analfabeta y en el 2018, el 5,59%


//2
egen fecha = concat(mes aÑo), punct(-)
egen llave_persona = concat(aÑo conglome vivienda hogar codperso), punct(-)


// 3
clear all
use "enaho01a-2019-500.dta"
drop if p203==0
drop if codinfor=="00" 
gen factor2=round(factor,2)
keep if p204==1

egen ingtrabajo_año=rsum(i524a1 d529t i530a d536 i538a1 d540t i541a d543)
gen ingtrabajo_mens=ingtrabajo_año/12
keep if ingtrabajo_mens > 0

gen ubigeo_1=substr(ubigeo,1,2)
gen dpto=real(ubigeo_1)
drop ubigeo_1

lab def dpto 1 "Amazonas" 2 "Áncash" 3 "Apurímac" 4 "Arequipa" 5 "Ayacucho" 6 "Cajamarca" 7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" 11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima" 16 "Loreto" 17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San Martin" 23 "Tacna" 24 "Tumbes" 25 "Ucayali"
label val dpto dpto
label variable dpto "departamento"

gen factor2=round(fac500a,2)
svyset [pweight = factor2], psu(conglome) strata(estrato)
svy: mean ingtrabajo_mens, over(dpto)
lincom ingtrabajo_mens@1.dpto - ingtrabajo_mens@9.dpto
// Con un 95% de confianza podemos concluir que la diferencia, en promedio, del
// ingreso total por trabajo al mes de cada persona ocupada entre Amazonas y
// Huancavelica sí es estadísticamente significativa.


// 4
clear all
use "enaho01a-2019-300.dta"
drop if p203==0
drop if codinfor=="00" 
gen residente=((p204==1 & p205==2) | (p204==2 & p206==1))
gen dependientes = 0
replace dependientes = 1 if p208 < 14 | p208 > 65


// 5
gen no_dependientes=(dependientes==0)

collapse (sum) dependientes no_dependientes, by(aÑo conglome vivienda hogar)
save "cap300_new.dta", replace

// 6
merge 1:1 aÑo conglome vivienda hogar using enaho01-2019-100.dta, keep(match) keepusing(factor07) nogenerate


// 7
gen tasa_dependencia = (dependientes/no_dependientes)*100


// 8
svyset [pweight = factor07], psu(conglome)
svy: mean tasa_dependencia
// 47.55724%


// 9
clear all
use "sumaria-2019.dta"
gen facpob=factor07*mieperho
gen gast_per_mens=(gashog2d/mieperho)/12
svyset [pweight = facpob], psu(conglome) strata(estrato)
svy: mean gast_per_mens
// [682.1201    706.8615]


// 10
svyset [pweight = factor07], psu(conglome) strata(estrato)
svy: mean gashog2d, over(dominio)
lincom gashog2d@1.dominio - gashog2d@3.dominio
// Para un 95% de confianza podemos afirmar que la diferencia de gasto, en 
// promedio, entre la costa norte y la costa sur no es estadísticamente significativa.
