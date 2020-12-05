/*******************************************************************************
				Downloading World Bank data using wbopendata  	              
						Elena Casanovas. Dec 2020  	              
*******************************************************************************/

	cd	"/setpath" 
	set more off
	clear all
	
	
*-- 01. Check list of available indicators 
	
	help wbopendata_indicators
	
*-- 02. Download selected indicators 

	wbopendata, indicator(SL.UEM.ADVN.FE.ZS; SL.UEM.ADVN.MA.ZS) long clear 
	drop if missing(sl_uem_advn_fe_zs) & missing(sl_uem_advn_ma_zs)
	keep countrycode year sl_*
	sort countrycode year
    
   
*-- 03. Figure 
	graph set window fontface "Garamond"
	global inv_gr  =  2 /(sqrt(5)+1)	
	
	#delimit ; 
	line sl_uem_advn_fe_zs year if countrycode == "IDN", lpattern(solid) lw(thick) lcolor(red)   || 
	line sl_uem_advn_ma_zs year if countrycode == "IDN", lpattern(solid) lw(thick) lcolor(blue)  
		xtitle("")  ytitle("")  
		subtitle("Unemployment rates in Indonesia", position(11) justification(left) size(medsmall)) 
		ylabel( , nogrid angle(horizontal) labs(small)) xlabel(, labs(small)) leg(off)
		scheme(s2mono) aspectratio($inv_gr) graphregion(fcolor(white) color(white))
		text(10  2013.5  "Female", size(small) place(w))
		text( 5  2011.4  "Male",   size(small) place(w));
	#delimit cr 
