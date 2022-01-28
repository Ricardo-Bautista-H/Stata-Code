*********Pregunta 2.a)***********
* Probando los modelos
*Pool
reg FDI GDPpc_log GDPg Openness Inflation VE
outreg2 using Pregunta_2a.doc, ctitle(Pool Data) 

*EF
xtreg FDI GDPpc_log GDPg Openness Inflation VE, fe
outreg2 using Pregunta_2a.doc, append ctitle(Fixed Effects) 
estimates store fixed

*EA
xtreg FDI GDPpc_log GDPg Openness Inflation VE, re
outreg2 using Pregunta_22a.doc,append ctitle(Random Effects) 
estimates store random

*Hausman test
hausman fixed random

*Breusch-Pagan
xttest0

**************************Pregunta 2.c)******************************
recode year (1996/1998=1) (1999/2002=2) (2003/2006=3) (2007/2009=4), generate(TIEMP)

xtreg FDI GDPpc_log GDPg Openness Inflation VE if TIEMP ==1, fe
outreg2 using Pregunta_c.doc, ctitle(Model 1 - 1996/1998) addtext(Fixed Effects, Yes, Time Trend, No, Number of countries, 65)

xtreg FDI GDPpc_log GDPg Openness Inflation VE if TIEMP ==2, fe
outreg2 using Pregunta_c.doc, append ctitle(Model 1 - 1999/2002) addtext(Fixed Effects, Yes, Time Trend, No, Number of countries, 65)

xtreg FDI GDPpc_log GDPg Openness Inflation VE if TIEMP ==3, fe
outreg2 using Pregunta_c.doc, append ctitle(Model 1 - 2003/2006) addtext(Fixed Effects, Yes, Time Trend, No, Number of countries, 65)

xtreg FDI GDPpc_log GDPg Openness Inflation VE if TIEMP ==4, fe
outreg2 using Pregunta_c.doc, append ctitle(Model 1 - 2007/2009) addtext(Fixed Effects, Yes, Time Trend, No, Number of countries, 65)