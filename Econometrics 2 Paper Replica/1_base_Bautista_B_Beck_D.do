cd "Econometría II\PC4\Datos"

********************************Trabajando Variables************************************

// Para FDI
// En excel se generó una llave en los años "x" para luego hacer el reshape
import excel "FDI.xlsx", sheet("MySheet") cellrange(A5:AY224) firstrow

drop if YEAR=="ECONOMY"
rename YEAR COUNTRY

foreach var of varlist x1970-x2019 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == "***"
          }
		  
destring x1970-x2019, replace

reshape long x, i(COUNTRY) j(year)

keep if year>= 1996 & year <=2009

rename x FDI

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania NorthMacedonia Malaysia Malta Mexico Moldova,Republicof Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland,Liechtenstein Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRep.of)"

generate key_1 = .

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "FDI.dta", replace

// Para GDP
// En excel se generó una llave en los años "x" para luego hacer el reshape
import excel "GDP.xlsx", sheet("MySheet") cellrange(A5:AY224) firstrow

drop if YEAR=="ECONOMY"

rename YEAR COUNTRY

foreach var of varlist x1970-x2019 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == "***"
          }
		  
destring x1970-x2019, replace

reshape long x, i(COUNTRY) j(year)

keep if year>= 1996 & year <=2009

rename x GDP

replace COUNTRY = subinstr(COUNTRY, " ", "", .)


global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania NorthMacedonia Malaysia Malta Mexico Moldova,Republicof Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland,Liechtenstein Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRep.of)"

generate key_1 = .

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "GDP.dta", replace

// Para GDPpc
// En excel se generó una llave en los años "x" para luego hacer el reshape
import excel "GDPpc.xlsx", sheet("MySheet") cellrange(A5:AY224) firstrow

drop if YEAR=="ECONOMY"

rename YEAR COUNTRY

foreach var of varlist x1970-x2019 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == "***"
          }
		  
destring x1970-x2019, replace

reshape long x, i(COUNTRY) j(year)

keep if year>= 1996 & year <=2009

rename x GDPpc

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

generate key_1 = .

global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania NorthMacedonia Malaysia Malta Mexico Moldova,Republicof Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland,Liechtenstein Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRep.of)"

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "GDPpc.dta", replace

// Para GDPg
// En excel se generó una llave en los años "x" para luego hacer el reshape
import excel "GDPg.xlsx", sheet("MySheet") cellrange(A5:AX234) firstrow

drop if PERIOD=="ECONOMY"

rename PERIOD COUNTRY

foreach var of varlist x1971-x2019 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == "***"
          }
		  
destring x1971-x2019, replace

reshape long x, i(COUNTRY) j(year)

keep if year>= 1996 & year <=2009

rename x GDPg

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

generate key_1 = .

global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania NorthMacedonia Malaysia Malta Mexico Moldova,Republicof Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland,Liechtenstein Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRep.of)"

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "GDPg.dta", replace

// Para Openess
// En excel se generó una llave en los años "x" para luego hacer el reshape. Esta variable se trabaja en dos partes y luego se hace un append.
// 1
import excel "Openess1.xlsx", sheet("MySheet") cellrange(A5:Z243) firstrow
drop if YEAR=="ECONOMY"

rename YEAR COUNTRY

foreach var of varlist x1980-x2004 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_" 
				 replace `var' = "." if `var' == "***"
				 replace `var' = "." if `var' == "-"
          }
		  
destring x1980-x2004, replace

reshape long x, i(COUNTRY) j(year)

keep if year>= 1996 & year <=2004

rename x Openess

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

generate key_1 = .

global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania TFYRofMacedonia Malaysia Malta Mexico RepublicofMoldova Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRepublicof)"



// cambiar TFYRofMacedonia por NorthMacedonia y RepublicofMoldova por MoldovaRepublicof
// Switzerland por Switzerland,Liechtenstein y Venezuela(BolivarianRepublicof) por Venezuela(BolivarianRep.of)


foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

replace COUNTRY = "NorthMacedonia" if COUNTRY == "TFYRofMacedonia"
replace COUNTRY = "MoldovaRepublicof" if COUNTRY == "RepublicofMoldova"
replace COUNTRY = "Switzerland,Liechtenstein" if COUNTRY == "Switzerland"
replace COUNTRY = "Venezuela(BolivarianRep.of)" if COUNTRY == "Venezuela(BolivarianRepublicof)"

save "Openess1.dta", replace

clear all

// 2
import excel "Openess2.xlsx", sheet("MySheet") cellrange(A5:P229) firstrow

drop if YEAR=="ECONOMY"

rename YEAR COUNTRY

foreach var of varlist x2005-x2019 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == "***"
				 replace `var' = "." if `var' == "-"				 
          }
		  
destring x2005-x2019, replace

reshape long x, i(COUNTRY) j(year)

keep if year>= 2005 & year <=2009

rename x Openess

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

generate key_1 = .

global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania NorthMacedonia Malaysia Malta Mexico Moldova,Republicof Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland,Liechtenstein Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRep.of)"

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "Openess2.dta", replace

clear all 

use "Openess1.dta"

append using "Openess2.dta"

sort COUNTRY

save "Openess.dta"

// Para Inflation
import excel "Inflation.xlsx", sheet("MySheet") cellrange(A5:AO220) firstrow

drop if YEAR=="ECONOMY"

rename YEAR COUNTRY

foreach var of varlist x1980-x2019 {
                 replace `var' = "." if `var' == ".."
                 replace `var' = "." if `var' == "_"
				 replace `var' = "." if `var' == "***"
				 replace `var' = "." if `var' == "-"
          }
		  
destring x1980-x2019, replace

reshape long x, i(COUNTRY) j(year)

keep if year>= 1996 & year <=2009

rename x Inflation

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

replace COUNTRY = "Korea,Dem.People'sRep.of" if COUNTRY == "Korea,Republicof"

generate key_1 = .

global Variables_1 "Argentina Australia Austria Belgium Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Cyprus Czechia Denmark Ecuador Egypt ElSalvador Estonia Finland France Georgia Germany Greece Honduras Hungary Iceland Indonesia Ireland Israel Italy Jamaica Japan Korea,Dem.People'sRep.of Latvia Lithuania NorthMacedonia Malaysia Malta Mexico Moldova,Republicof Morocco Netherlands NewZealand Nicaragua Norway Pakistan Panama Paraguay Peru Philippines Poland Portugal Romania RussianFederation Singapore Slovakia Slovenia Spain SriLanka Sweden Switzerland,Liechtenstein Thailand Turkey UnitedKingdom Uruguay Venezuela(BolivarianRep.of)"

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "Inflation.dta", replace

// Para V.E
import excel "V.E.xls", sheet("Data") cellrange(A4:BB268) firstrow

drop CountryCode-IndicatorCode

rename CountryName COUNTRY

reshape long x, i(COUNTRY) j(year)

rename x VE

keep if year>= 1996 & year <=2009

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

replace COUNTRY = "Bolivia(PlurinationalStateof)" if COUNTRY == "Bolivia"
replace COUNTRY = "Czechia" if COUNTRY == "CzechRepublic"
replace COUNTRY = "Egypt" if COUNTRY == "Egypt,ArabRep."
replace COUNTRY = "Korea,Dem.People'sRep.of" if COUNTRY == "Korea,Dem.People'sRep."
replace COUNTRY = "Moldova,Republicof" if COUNTRY == "Moldova"
replace COUNTRY = "Slovakia" if COUNTRY == "SlovakRepublic"
replace COUNTRY = "Switzerland,Liechtenstein" if COUNTRY == "Switzerland"
replace COUNTRY = "Venezuela(BolivarianRep.of)" if COUNTRY == "Venezuela,RB"

generate key_1 = .

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "V.E.dta", replace

// Para Corruption

import excel "Corruption.xlsx", sheet("Hoja2") firstrow

keep Name IndexYear GovernmentIntegrity

rename Name COUNTRY

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

replace COUNTRY = "Bolivia(PlurinationalStateof)" if COUNTRY == "Bolivia"
replace COUNTRY = "Czechia" if COUNTRY == "CzechRepublic"
replace COUNTRY = "Korea,Dem.People'sRep.of" if COUNTRY == "SouthKorea"
replace COUNTRY = "Moldova,Republicof" if COUNTRY == "Moldova"
replace COUNTRY = "RussianFederation" if COUNTRY == "Russia"
replace COUNTRY = "Switzerland,Liechtenstein" if COUNTRY == "Switzerland"
replace COUNTRY = "Venezuela(BolivarianRep.of)" if COUNTRY == "Venezuela"
replace COUNTRY = "Slovakia" if COUNTRY == "SlovakRepublic"

generate key_1 = .

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

rename IndexYear year

keep if year>= 1996 & year <=2009

rename GovernmentIntegrity Corruption

replace Corruption = "." if Corruption == "N/A"

destring Corruption, replace

save "Corruption.dta", replace

// Para L.Flex // (Labor market regulations)
import excel "Labor Flexibility.xlsx", sheet("EFW Data 2020 Report") cellrange(A5:CB4056) firstrow

keep Year Countries Labormarketregulations

rename Year year

keep if year>= 1996 & year <=2009

rename Countries COUNTRY

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

replace COUNTRY = "Bolivia(PlurinationalStateof)" if COUNTRY == "Bolivia"
replace COUNTRY = "Czechia" if COUNTRY == "CzechRepublic"
replace COUNTRY = "Korea,Dem.People'sRep.of" if COUNTRY == "Korea,Rep."
replace COUNTRY = "Moldova,Republicof" if COUNTRY == "Moldova"
replace COUNTRY = "Switzerland,Liechtenstein" if COUNTRY == "Switzerland"
replace COUNTRY = "Venezuela(BolivarianRep.of)" if COUNTRY == "Venezuela,RB"
replace COUNTRY = "Slovakia" if COUNTRY == "SlovakRepublic"
replace COUNTRY = "Korea,Dem.People'sRep.of" if COUNTRY == "Korea,Rep."
replace COUNTRY = "Egypt" if COUNTRY == "Egypt,ArabRep."

generate key_1 = .

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

rename Labormarketregulations LaborFlexibility

save "L.Flex.dta", replace

// Para Labour Costs // SOLO 29 COUNTRIES
import excel "Labor Costs.xlsx", sheet("Hoja2") firstrow

rename ref_arealabel COUNTRY
rename time year
rename obs_value LCosts

keep COUNTRY year LCosts

replace COUNTRY = subinstr(COUNTRY, " ", "", .)

replace COUNTRY = "Switzerland,Liechtenstein" if COUNTRY == "Switzerland"

keep if year>= 1996 & year <=2009


generate key_1 = .

foreach var of global Variables_1 {
	replace key = 1 if COUNTRY == "`var'"
	}

keep if key_1 == 1

drop key_1

save "Labor Costs.dta", replace

********************************Mergeando data************************************

use FDI.dta

merge 1:1 COUNTRY year using "GDP.dta"

drop _merge

merge 1:1 COUNTRY year using "GDPg.dta", nogenerate

merge 1:1 COUNTRY year using "GDPg.dta", nogenerate

merge 1:1 COUNTRY year using "GDPpc.dta", nogenerate

merge 1:1 COUNTRY year using "Inflation.dta", nogenerate

merge 1:1 COUNTRY year using "Openess.dta", nogenerate

merge 1:1 COUNTRY year using "V.E.dta", nogenerate

merge 1:1 COUNTRY year using "Corruption.dta", nogenerate

merge 1:1 COUNTRY year using "L.Flex.dta"

merge 1:1 COUNTRY year using "Labor Costs.dta"

save "Datos_Final.dta"

rename COUNTRY country

*************************Trabajando Missing Values******************************
// Para los missing values asumimos interpolación por medio de ipolate

foreach var of varlist GDP-Corruption{
	ipolate `var' year, gen(`var'_1) epolate by(COUNTRY)
	drop `var'
	rename `var'_1 `var'
}

save "Datos-Final.dta", replace

*************************Para developed******************************
gen DEV=.
global Developed "Australia Austria Belgium Cyprus Czechia Denmark Estonia Finland France Germany Greece Iceland Ireland Israel Italy Japan Latvia Lithuania Malta Netherlands NewZealand Norway Poland Portugal Romania Singapore Slovakia Slovenia Spain Sweden Switzerland,Liechtenstein UnitedKingdom"
*32
global Develoing "Argentina Bolivia(PlurinationalStateof) Brazil Chile Colombia CostaRica Croatia Ecuador Egypt ElSalvador Honduras Hungary Indonesia Jamaica Mexico Moldova,Republicof Morocco Nicaragua NorthMacedonia Pakistan Panama Peru Paraguay Philippines SriLanka Thailand Turkey Uruguay Venezuela(BolivarianRep.of) RussianFederation Georgia Korea,Dem.People'sRep.of Malaysia"
*33

foreach var of global Developed{
	replace DEV=1 if COUNTRY == "`var'"
	}
replace DEV=0 if DEV==.

rename country country_2
encode country_2, gen(country)

order country, first
rename Openess Openness
xtset country year, yearly

gen GDPpc_log = log(GDPpc)
gen VE2 = VE^2