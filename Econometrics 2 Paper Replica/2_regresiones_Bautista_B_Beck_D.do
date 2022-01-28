
************************ Tabla 6 ********************************************
// Modelo 1
xtreg FDI GDPpc_log GDPg Openness Inflation VE, fe
outreg2 using Tabla1.doc, ctitle(Model 1) addtext(Fixed Effects, Yes, Time Trend, No, Number of countries, 65)
 
// Modelo 2 
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE, fe
outreg2 using Tabla1.doc, append ctitle(Model 2) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 65)

// Modelo 3
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE VE2, fe
outreg2 using Tabla1.doc, append ctitle(Model 3) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 65)

// Modelo 4
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE VE2 c.year, fe
outreg2 using Tabla1.doc, append ctitle(Model 4) addtext(Fixed Effects, -, Time Trend, Yes, Number of countries, 65)

// Modelo 5
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE VE2 Corruption LaborFlexibility c.year, fe
outreg2 using Tabla1.doc, append ctitle(Model 5) addtext(Fixed Effects, -, Time Trend, Yes, Number of countries, 65)

************************ Tabla 7 ********************************************
global Developed "Australia Austria Belgium Cyprus Czechia Denmark Estonia Finland France Germany Greece Iceland Ireland Israel Italy Japan Latvia Lithuania Malta Netherlands NewZealand Norway Poland Portugal Romania Singapore Slovakia Slovenia Spain Sweden Switzerland,Liechtenstein UnitedKingdom" //32
global Develoing "Argentina Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Ecuador Egypt ElSalvador Honduras Hungary Indonesia Jamaica Mexico Moldova,Republicof Morocco Nicaragua NorthMacedonia Pakistan Panama Peru Paraguay Philippines SriLanka Thailand Turkey Uruguay Venezuela(BolivarianRep.of) RussianFederation Georgia Korea,Dem.People'sRep.of Malaysia"// 33

// Modelo 2.1
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE if DEV ==1, fe
outreg2 using Tabla2.doc, ctitle(Model 2) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 32)

// Modelo 3.1
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE VE2 if DEV ==1, fe
outreg2 using Tabla2.doc, append ctitle(Model 3) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 32)

// Modelo 4.1
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE VE2 c.year if DEV ==1, fe
outreg2 using Tabla2.doc, append ctitle(Model 4) addtext(Fixed Effects, -, Time Trend, Yes, Number of countries, 32)

// Modelo 2.2
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE if DEV ==0, fe
outreg2 using Tabla2.doc, append ctitle(Model 2) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 32)

// Modelo 3.2
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE VE2 if DEV ==0, fe
outreg2 using Tabla2.doc, append ctitle(Model 3) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 32)

// Modelo 4.2
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE VE2 c.year if DEV ==0, fe
outreg2 using Tabla2.doc, append ctitle(Model 4) addtext(Fixed Effects, -, Time Trend, Yes, Number of countries, 32)

************************ Tabla 8 ********************************************
// Modelo 2 
xtreg FDI L.FDI GDPpc GDPg Openness Inflation LCosts VE, fe
outreg2 using Tabla3.doc, ctitle(Model 2) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 29)

// Modelo 3
xtreg FDI L.FDI GDPpc GDPg Openness Inflation LCosts VE VE2, fe
outreg2 using Tabla3.doc, append ctitle(Model 3) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 29)

// Modelo 4
xtreg FDI L.FDI GDPpc GDPg Openness Inflation LCosts VE VE2 c.year, fe
outreg2 using Tabla3.doc, append ctitle(Model 4) addtext(Fixed Effects, -, Time Trend, Yes, Number of countries, 29)

// Modelo 5
xtreg FDI L.FDI GDPpc GDPg Openness Inflation LCosts VE Corruption LaborFlexibility c.year, fe
outreg2 using Tabla3.doc, append ctitle(Model 5) addtext(Fixed Effects, -, Time Trend, Yes, Number of countries, 29)

// Modelo 6
xtreg FDI L.FDI GDPpc GDPg Openness Inflation LCosts VE VE2 Corruption LaborFlexibility c.year, fe
outreg2 using Tabla3.doc, append ctitle(Model 5) addtext(Fixed Effects, -, Time Trend, Yes, Number of countries, 29)