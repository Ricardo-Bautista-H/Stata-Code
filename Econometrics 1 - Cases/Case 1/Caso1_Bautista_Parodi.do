// Pregunta 3
// La aleatorización se realizó en 214 ciudades fueron 109 en grupo de control y 105 de tratamiento
// todos los niños de una misma ciudad seleccionada reciben el tratamiento
//ahora con el uso de balance tables comprobare la aleatoridad comparando medias del
//grupo de control y el de tratamiento
collapse treatment diarrhea_sick malaria_sick malaria_treatednet SES anthro_female village_distance_road village_distance_electricity village_distance_HF village_HF_within5km, by(villageid)

label variable treatment "treatment"
label variable diarrhea_sick "% of diarrhea_sick"
label variable malaria_sick "% of  malaria_sick"
label variable malaria_treatednet "% of malaria_treatednet"
label variable SES "SES"
label variable anthro_female "% of female"

replace diarrhea_sick = diarrhea_sick *100
replace malaria_sick = malaria_sick *100
replace malaria_treatednet = malaria_treatednet *100
replace anthro_female = anthro_female *100

replace malaria_sick = round(malaria_sick,0.01)
replace diarrhea_sick = round(diarrhea_sick,0.01)
replace malaria_treatednet = round(malaria_treatednet,0.01)
replace anthro_female = round(anthro_female,0.01)

format %9.0g anthro_female
format %9.0g diarrhea_sick
format %9.0g malaria_sick

balancetable treatment diarrhea_sick-village_HF_within5km using PRG1.xls

// // Pregunta 4
collapse treatment diarrhea_sick malaria_sick , by(villageid)
replace diarrhea_sick=diarrhea_sick*100
replace malaria_sick=malaria_sick*100
regress malaria_sick treatment
outreg2 using Preg4_1, word dec(3)
regress diarrhea_sick treatment
outreg2 using Preg4_1,append word dec(3)

// Pregunta 5b
scatter diarrhea_sick treatment , msize(1) jitter(0.5) || lfit diarrhea_sick treatment
scatter malaria_sick treatment , msize(1) jitter(0.5) || lfit malaria_sick treatment

pwcorr treatment-village_HF_within5km

// Pregunta 5c
collapse treatment diarrhea_sick malaria_sick village_distance_electricity village_distance_HF village_distance_road , by(villageid)
replace diarrhea_sick=diarrhea_sick*100
replace malaria_sick=malaria_sick*100
regress malaria_sick treatment village_distance_electricity village_distance_HF village_distance_road
outreg2 using Preg5_c, word dec(3)
regress diarrhea_sick treatment village_distance_electricity village_distance_HF village_distance_road

pwcorr treatment-village_distance_road ,sig star(.05)

// Pregunta 5d
// _1
regress treatment village_distance_electricity village_distance_HF village_distance_road
predict resid_treatment, res

*para enfermos por malaria
regress malaria_sick village_distance_electricity village_distance_HF village_distance_road
predict resid_malaria_sick , res
regress resid_malaria_sick resid_treatment , noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)
outreg2 using Preg5_d1, word dec(3)


*para enfermos por diarrea
regress diarrhea_sick village_distance_electricity village_distance_HF village_distance_road
predict resid_diarrhea_sick , res
regress resid_diarrhea_sick resid_treatment , noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)
outreg2 using Preg5_d1, word dec(3)


// _2
regress treatment village_distance_electricity village_distance_HF
predict resid_treatment2, res

*para enfermos por malaria
regress malaria_sick village_distance_electricity village_distance_HF 
predict resid_malaria_sick2, res
regress resid_malaria_sick2 resid_treatment2, noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)
outreg2 using Preg5_d2, word dec(3)

*para enfermos por diarrea
regress diarrhea_sick village_distance_electricity village_distance_HF
predict resid_diarrhea_sick2, res
regress resid_diarrhea_sick2 resid_treatment2, noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)
outreg2 using Preg5_d2, word dec(3)

//Pregunta 6
// Parte A
save

sort villageid
collapse treatment (mean) diarrhea_sick village_distance_HF , by(villageid)

gen village_distance_u15 = 0
replace village_distance_u15 = 1 if village_distance_HF<=1.5
replace diarrhea_sick = diarrhea_sick*100

preserve

drop if village_distance_u15 == 0

reg diarrhea_sick treatment
outreg2 using Preg6_1, word dec(3)

// Parte B

restore

drop if village_distance_u15 == 1

reg diarrhea_sick treatment
outreg2 using Preg6_1,append word dec(3)
