*Variables nuevas
//  Tariffs (arancel)
import excel "Tariffs.xlsx", sheet("MySheet") cellrange(A5:AH205) firstrow
drop if A=="MARKET"
drop YEAR
rename A COUNTRY

drop x1988-x1995

foreach var of varlist x1996-x2019 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == "***"
				 replace `var' = "." if `var' == "-"
				 replace `var' = "." if `var' == "."
				 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == ".."
          }
		  

destring x1996-x2019, replace


reshape long x, i(COUNTRY) j(year)

keep if year>= 1996 & year <=2009


rename x Tariffs

replace COUNTRY = subinstr(COUNTRY, " ", "", .)


global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania NorthMacedonia Malaysia Malta Mexico Moldova,Republicof Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland,Liechtenstein Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRep.of)"


replace COUNTRY = "NorthMacedonia" if COUNTRY == "TFYRofMacedonia"
replace COUNTRY = "Moldova,Republicof" if COUNTRY == "RepublicofMoldova"
replace COUNTRY = "Switzerland,Liechtenstein" if COUNTRY == "Switzerland"
replace COUNTRY = "Venezuela(BolivarianRep.of)" if COUNTRY == "Venezuela(BolivarianRepublicof)"
replace COUNTRY = "Korea,Dem.People'sRep.of" if COUNTRY == "Korea,Republicof"


generate key_1 = .

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "Tariffs.dta", replace

//  EXC (tipo de cambio real)

import excel "EXC.xlsx", sheet("MySheet") cellrange(A5:T241) firstrow
drop if YEAR=="ECONOMY"
rename YEAR COUNTRY


foreach var of varlist x1998-x2016 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == "***"
				 replace `var' = "." if `var' == "-"
				 replace `var' = "." if `var' == "."
          }
		  
destring x1998-x2016, replace

reshape long x, i(COUNTRY) j(year)

keep if year>= 1996 & year <=2009

rename x EXC

replace COUNTRY = subinstr(COUNTRY, " ", "", .)


global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania NorthMacedonia Malaysia Malta Mexico Moldova,Republicof Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland,Liechtenstein Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRep.of)"


replace COUNTRY = "NorthMacedonia" if COUNTRY == "TFYRofMacedonia"
replace COUNTRY = "Moldova,Republicof" if COUNTRY == "RepublicofMoldova"
replace COUNTRY = "Switzerland,Liechtenstein" if COUNTRY == "Switzerland"
replace COUNTRY = "Venezuela(BolivarianRep.of)" if COUNTRY == "Venezuela(BolivarianRepublicof)"

generate key_1 = .

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "EXC.dta", replace

*************************************merge************************************

use "Tariffs.dta"

merge 1:1 COUNTRY year using "EXC.dta", nogenerate

rename COUNTRY country_2

save "Variables_aporte.dta", replace

use "Datos-Final.dta"

merge 1:1 country_2 year using "Variables_aporte.dta", nogenerate


***** Missing values

foreach var of varlist Tariffs-EXC{
	ipolate `var' year, gen(`var'_1) epolate by(country_2)
	drop `var'
	rename `var'_1 `var'
}

use "Datos-Final.dta", replace
*******************************Regresión************************************

xtset country year, yearly
// Modelo 1
xtreg FDI GDPpc_log GDPg Openness Inflation VE Tariffs EXC, fe
outreg2 using Aporte1.doc, ctitle(Model 1) addtext(Fixed Effects, Yes, Time Trend, No, Number of countries, 65)

// Modelo 2
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE Tariffs EXC, fe
outreg2 using Aporte1.doc, append ctitle(Model 2) addtext(Fixed Effects, Yes, Time Trend, No, Number of countries, 65)

// Modelo 3
xtreg FDI L.FDI GDPpc_log GDPg Openness Inflation VE VE2 Tariffs EXC, fe
outreg2 using Aporte1.doc, append ctitle(Model 3) addtext(Fixed Effects, -, Time Trend, No, Number of countries, 65)