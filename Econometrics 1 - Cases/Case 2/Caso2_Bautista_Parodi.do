// limpiando base de datos, creando highincome y ldrugexp
gen ldrugexp = log(drugexp)

replace fair = 0 if poor == 1
replace good = 0 if poor == 1 | fair == 1
replace vegood = 0 if poor == 1 | fair == 1 | good == 1

replace income =. if income<0

gen  highincome=0
replace highincome = 1 if lowincome==0 & midincome==0
replace highincome = 0 if highincome==0

//Pregunta 3, 4 y 5
regress ldrugexp comp_insurance
// efecto de tener seguro complementario en los gastos en medicamentos anuales
// de una persona. Sin controles
*outreg2 using Preg3, word dec(3)
regress ldrugexp comp_insurance age female educyr income msa totchr
*outreg2 using Preg3,append word dec(3)
// efecto de tener seguro complementario en los gastos en medicamentos anuales
// de una persona. Controles: edad, sexo, educación, ingresos, zona geográfica y
// N° de condiciones crónicas
ovtest
// test de variable omitida

pwcorr ldrugexp comp_insurance private hisp marry poor fair good vegood poverty lowincome midincome highincome firmsz multlc priolist black, sig star(.05)
// analizamos correlaciones para seleccionar instrumento
// corremos regresiones de 2 etapas con los instrumentos elegidos


// para vegood
reg comp_insurance vegood age female educyr income msa totchr, robust
*outreg2 using VI1, word dec(3)
ivregress 2sls ldrugexp (comp_insurance = vegood ) age female educyr income msa totchr, vce(robust) first
*outreg2 using VI1,append word dec(3)
estat endogenous
estat firststage

// para multlc
reg comp_insurance multlc age female educyr income msa totchr, robust
*outreg2 using VI2, word dec(3)
ivregress 2sls ldrugexp (comp_insurance = multlc ) age female educyr income msa totchr,vce(robust) first
*outreg2 using VI2,append word dec(3)
estat endogenous
estat firststage

// Preg 6
// comparamos diferencias promedio entre grupos con y sin seguro comp
balancetable comp_insurance ldrugexp using prg6.xls
