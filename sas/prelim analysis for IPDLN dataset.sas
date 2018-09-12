options nocenter;
proc datasets kill; run;
/*proc import */
/*datafile="C:\Users\Sumeet\Desktop\IPDLN conference\sept 11 workshop\ipdln_synth_final\clean_data.csv" */
/*out=clean_data dbms=csv replace;*/
/*    getnames=yes;*/
/*run;*/

       data WORK.CLEAN_DATA    ;
       %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
       infile 'C:\Users\Sumeet\Desktop\IPDLN conference\sept 11 workshop\ipdln_synth_final\clean_data.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2;
          informat VAR1 $4. ;
          informat ab_id_dichot $100. ;
          informat ab_id_detailed $100. ;
          informat adl_difficulty $100. ;
          informat citizen_stat $100. ;
          informat worker_class $100. ;
          informat adl_disab_difficulty $100. ;
          informat adl_disab_diff_type $100. ;
          informat vis_minority $100. ;
          informat first_lang $100. ;
          informat employ_status $100. ;
          informat generation $100. ;
          informat education $100. ;
          informat immigration_stat $100. ;
          informat lo_inc_aftertax $100. ;
          informat lo_inc_beforetax $100. ;
          informat mar_stat $100. ;
          informat occupation $100. ;
          informat official_lang $100. ;
          informat place_of_birth $100. ;
          informat sex $100. ;
          informat transport $100. ;
          informat repairs $100. ;
          informat province $100.;
          informat rur_urb $100. ;
          informat loinc_decile $100. ;
          informat dead $100. ;
          informat no_fam_members $100. ;
          informat age_imm $100. ;
          informat cause_death_1 $100. ;
          informat cause_death_2 $100. ;
          informat birth_country $100. ;
          informat no_kids $100. ;
          informat year_imm $26. ;
          informat age_grp $100. ;
          format VAR1 $100. ;
          format ab_id_dichot $100. ;
          format ab_id_detailed $100. ;
          format adl_difficulty $100. ;
          format citizen_stat $100. ;
          format worker_class $100. ;
          format adl_disab_difficulty $100.;
          format adl_disab_diff_type $100. ;
          format vis_minority $100. ;
          format first_lang $100. ;
          format employ_status $100. ;
          format generation $100. ;
          format education $100. ;
          format immigration_stat $100. ;
          format lo_inc_aftertax $100.  ;
          format lo_inc_beforetax $100. ;
          format mar_stat $100. ;
          format occupation $100. ;
          format official_lang $100. ;
          format place_of_birth $100. ;
          format sex  $100. ;
          format transport $100. ;
          format repairs $100. ;
          format province $100. ;
          format rur_urb $100. ;
          format loinc_decile $100. ;
          format dead  $100. ;
          format no_fam_members $100. ;
          format age_imm $100. ;
          format cause_death_1 $100. ;
          format cause_death_2 $100. ;
          format birth_country $100. ;
          format no_kids $100. ;
          format year_imm $100. ;
          format age_grp $100. ;
       input
                   VAR1 $
                   ab_id_dichot $
                   ab_id_detailed $
                   adl_difficulty $
                   citizen_stat $
                   worker_class $
                   adl_disab_difficulty $
                   adl_disab_diff_type $
                   vis_minority $
                   first_lang $
                   employ_status $
                   generation $
                  education $
                  immigration_stat $
                  lo_inc_aftertax $
                  lo_inc_beforetax $
                  mar_stat $
                  occupation $
                  official_lang $
                  place_of_birth $
                  sex $
                  transport $
                  repairs $
                  province $
                  rur_urb $
                  loinc_decile $
                  dead $
                  no_fam_members $
                  age_imm $
                  cause_death_1 $
                  cause_death_2 $
                  birth_country $
                  no_kids $
                  year_imm $
                  age_grp $
      ;
      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
      run;


* questions:
1)	What socioeconomic factors contribute to the greatest inequalities in mortality? 
2)	Does the healthy immigrant advantage extend to the second generation?
3)	Does risk of cardiovascular mortality vary among immigrants from different source countries?
;


proc freq data=clean_data;
tables ab_id_dichot ab_id_detailed adl_difficulty citizen_stat worker_class 
		adl_disab_difficulty adl_disab_diff_type vis_minority first_lang employ_status 
		generation education immigration_stat lo_inc_aftertax lo_inc_beforetax mar_stat 
		occupation official_lang place_of_birth sex transport repairs province rur_urb loinc_decile 
		dead no_fam_members age_imm cause_death_1 cause_death_2 birth_country no_kids year_imm age_grp ;
title 'Table 1:Distribution of each variable in the dataset';
run;

proc freq data=clean_data;
tables education*generation/  norow nopercent;
run;



/*ods pdf close;*/


/*options nodate;*/
/*ods pdf file='C:\Users\Sumeet\Desktop\IPDLN conference\sept 11 workshop\ipdln_synth_final\tabulation.pdf';*/

*q1;
*SES variables: (1) age group, (2) sex, (3) income decile, (4) occupation, (5) education, (6) province, 
				(7) income before tax, (8) income after tax, (9) marriage status, 
				(10) residing in urban or rural region   ;

 proc format; picture mypct (round) low-high='009.9%'; run;
proc tabulate data=clean_data  s=[just=r cellwidth=125] missing ; 
 class   age_grp  sex  loinc_decile dead occupation education lo_inc_aftertax lo_inc_beforetax mar_stat rur_urb place_of_birth birth_country year_imm province;
tables 		age_grp  sex  loinc_decile  occupation education province
			lo_inc_beforetax lo_inc_aftertax mar_stat rur_urb 
			    	all={label='Total'},
		dead*( N*f=comma.  rowpctn={label='Percent (%)'}*f=mypct.) all={label='Total'};
title 'Table 1: Mortality with respect to patient and geographical characteristics';
run;


* logistic regression using the following covariates:
(1) age group, 
(2) sex, 
(3) income decile, 
(4) residing in urban or rural region, 
(5) occupation, 
(6) province, 
(7) income after tax, 
(8) marriage status
;

proc freq data=clean_data;
tables lo_inc_beforetax*lo_inc_aftertax / norow nocol nopercent ;
 run;


 proc freq data=clean_data;
tables ab_id_dichot*province / norow nocol nopercent ;
 run;


proc logistic data=clean_Data;
 class  	age_grp(ref='19-24')  
			sex(ref='Female')    
			loinc_decile(ref='10 - highest')   
			rur_urb(ref='Urban')  
			province(ref='Ontario')  
			lo_inc_aftertax(ref='non-low income')    
			mar_stat(ref='Married') 
			immigration_stat(ref='Non-immigrant')
			generation(ref='3rd Generation')/ param=glm   
			;
model dead(ref='Not Dead')= age_grp  
			sex  
			loinc_decile 
			rur_urb
			province
			lo_inc_aftertax  
			mar_stat
			generation;
lsmeans 	age_grp  
			sex  
			loinc_decile 
			rur_urb
			province
			lo_inc_aftertax  
			mar_stat generation / ilink cl;
ods output oddsratios=or_mortality;
ods output ParameterEstimates=log_or_mortality;
ods output GlobalTests=globaltest_mortality;
ods output lsmeans=lsmeans_mortality;
run;
* urban is the reference;

data log_or2_mortality; length reference_group $50.;
set log_or_mortality;
if variable='Intercept' then delete;
if df=0 then delete;
if variable='age_grp' then reference_group='19-24';
if variable='sex' then reference_group='Female';
if variable='loinc_decile' then reference_group='10 - highest';
if variable='rur_urb' then reference_group='Urban';
if variable='province' then reference_group='Ontario';
if variable='lo_inc_aftertax' then reference_group='non-low income';
if variable='mar_stat' then reference_group='Married';
if variable='generation' then reference_group='3rd Generation';
rename ClassVal0=index_group;
rename variable=effect;
odds_ratio=exp(Estimate);
lower_CL=exp(Estimate- 1.96*StdErr);
upper_CL=exp(Estimate+ 1.96*StdErr);
run;


proc print data=log_or2_mortality noobs;
var effect index_group reference_Group odds_ratio lower_CL upper_CL ProbChiSq; 
run;


data lsmeans2_mortality;
set lsmeans_mortality;
level=COALESCEC(age_grp, sex, loinc_decile, rur_urb, province, lo_inc_aftertax, mar_stat,generation );
mean_probability=round(mu,0.001);
lower_mean_probability=round(lowermu,0.001);
upper_mean_probability=round(uppermu,0.001);
keep effect level mean_probability lower_mean_probability upper_mean_probability;
run;

proc print data=lsmeans2_mortality noobs;
var effect level mean_probability lower_mean_probability upper_mean_probability;;
run;

* adjusted mortality rate in Canadian provinces using LSMEANS
30 province Alberta 0.081  
31 province British Columbia 0.080  
32 province Manitoba 0.095  
33 province New Brunswick 0.087  
34 province Newfoundland and Labrador 0.090  
35 province Northwest Territories 0.074 
36 province Nova Scotia 0.094  
37 province Nunavut 0.095  
38 province Prince Edward Island 0.098  
39 province Quebec 0.078  
40 province Saskatchewan 0.095  
41 province Yukon 0.066  
42 province Ontario 0.082  
;
* Province ID in SAS shapefile:
10 	Newfoundland
11 	Prince Edward Island
12 	Nova Scotia
13 	New Brunswick
24 	Quebec
35 	Ontario
46 	Manitoba
47 	Saskatchewan
48 	Alberta
59 	British Columbia
60 	Yukon
61 	Northwest Territories
;

data province_mortality; length province $2. province_name $25.;
input province $ province_name $ mortality_rate;
cards;
10 	Newfoundland 9.0 
11 	Prince_Edward_Island 9.8 
12 	Nova_Scotia 9.4 
13 	New_Brunswick 8.7 
24 	Quebec 7.8 
35 	Ontario 8.2 
46 	Manitoba 9.5 
47 	Saskatchewan 9.5 
48 	Alberta 8.1  
59 	British_Columbia 8.0  
60 	Yukon 6.6 
61 	Northwest_Territories 7.4 
;
run;

*** reset all graphics options to default values;
goptions reset=all;
*** choose a set of colors - sequentially increasing shades of blue;
pattern1 v=ms c=cxeff3ff;
pattern2 v=ms c=cxbdd7e7;
pattern3 v=ms c=cx6baed6;
pattern4 v=ms c=cx2171b5;
*** specify parameters for the legend;
legend1
origin=(70,60)pct
across=1
mode=share
label=(position=top j=c 'Mortality rate (per 100 individuals)')
shape=bar(3,4)pct
cborder=black;

proc GMAP map=maps.canada2 
data=work.province_mortality ;
label mortality_rate="Mortality rate";
id PROVINCE;
choro mortality_rate / levels=5 coutline=black legend=legend1;
title ' ';
run;


%macro graph_estimated_prob(var=,effect=,xaxis=);
data &var;
set lsmeans2_mortality;
where effect=&effect;   
run;
proc sort data=&var; by mean_probability; run;
proc sgplot data=&var noautolegend;                                                                                             
   scatter x=level y=mean_probability / yerrorlower=lower_mean_probability                                                                                            
                           yerrorupper=upper_mean_probability                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=level y=mean_probability / lineattrs=(color=blue pattern=2); 
yaxis label='Estimated probability of death'; 
xaxis label=&xaxis;
   title1 "Estimated probability of death with respect to &xaxis";                                                                   
run;
%mend; 
        

%graph_estimated_prob(var=age_grp,effect='age_grp',xaxis='Age group (years)');
%graph_estimated_prob(var=sex,effect='sex',xaxis='Sex (Male/Female)');
%graph_estimated_prob(var=rur_urb,effect='rur_urb',xaxis='Region');
%graph_estimated_prob(var=lo_inc_aftertax,effect='lo_inc_aftertax',xaxis='Income after tax');
%graph_estimated_prob(var=mar_stat,effect='mar_stat',xaxis='Marriage status');

data loinc_decile;
set lsmeans2_mortality;
where effect='loinc_decile';  
if  level='1 - lowest' then level='1';
if  level='10 - highest' then level='10';
income_decile=level*1;
run;
/*proc sort data=loinc_decile; by income_decile; run;*/
proc sgplot data=loinc_decile noautolegend;                                                                                             
   scatter x=level y=mean_probability / yerrorlower=lower_mean_probability                                                                                            
                           yerrorupper=upper_mean_probability                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=level y=mean_probability / lineattrs=(color=blue pattern=2); 
yaxis label='Estimated probability of death'; 
xaxis label='Income decile (1= lowest; 10=highest)';
   title1 "Estimated probability of death with respect to 'Income decile'";                                                                   
run;




*************************************************************************************
Question 2: Does the healthy immigrant advantage extend to the second generation?
*************************************************************************************;
data clean_data2; length health_immigration_status $50.;
set clean_data;
if 	immigration_stat='Immigrant' and 
	adl_disab_difficulty='No' then health_immigration_status='Healthy immigrant'; 
if immigration_stat='Immigrant' and 
	adl_disab_difficulty in('Often','Sometimes') then health_immigration_status='Unhealthy immigrant';
if immigration_stat in('Non-immigrant','Non-permanent resident') and 
	adl_disab_difficulty='No' then health_immigration_status='Healthy non-immigrant';
if immigration_stat in('Non-immigrant','Non-permanent resident') and 
	adl_disab_difficulty in('Often','Sometimes')  then health_immigration_status='Unhealthy non-immigrant';
if adl_disab_difficulty='Not stated' then health_immigration_status=''; * health status unknown;
run;
proc freq data=clean_Data2; tables health_immigration_status; run;


 proc format; picture mypct (round) low-high='009.9%'; run;
proc tabulate data=clean_data2  s=[just=r cellwidth=125] missing ; 
 class  generation health_immigration_status;
tables 	 health_immigration_status
 		all={label='Total'},
		generation*( N  rowpctn={label='Percent (%)'}*f=mypct.) all={label='Total'};
title 'Table 2: health & immigration status with respect to generation';
run;



 proc format; picture mypct (round) low-high='009.9%'; run;
proc tabulate data=clean_data2  s=[just=r cellwidth=125] missing ; 
 class  generation sex adl_difficulty  adl_disab_difficulty adl_disab_diff_type employ_status occupation place_of_birth loinc_decile age_grp no_kids year_imm birth_country age_imm ;
tables 	 age_grp sex  loinc_decile adl_difficulty  adl_disab_difficulty adl_disab_diff_type employ_status occupation   no_kids all={label='Total'},
		generation*( N  colpctn={label='Percent (%)'}*f=mypct.) all={label='Total'};
title 'Table 2: How does Healthy immigrant advantage extend to second generation with respect to patient and geographical characteristics?';
run;


 proc format; picture mypct (round) low-high='009.9%'; run;
proc tabulate data=clean_data  s=[just=r cellwidth=125] missing ; 
 class  generation age_grp  sex  loinc_decile dead occupation education lo_inc_aftertax lo_inc_beforetax mar_stat rur_urb place_of_birth birth_country year_imm;
tables 	 age_grp  sex  loinc_decile  mar_stat rur_urb place_of_birth birth_country year_imm
 		all={label='Total'},
		generation*( N  rowpctn={label='Percent (%)'}*f=mypct.) all={label='Total'};
title 'Table 2: How does Healthy immigrant advantage extend to second generation with respect to patient and geographical characteristics?';
run;



************************************************************************************************************
Question 3: Does risk of cardiovascular mortality vary among immigrants from different source countries?
***********************************************************************************************************;

data clean_Data3; length mortality $50.;
set clean_data2;
if cause_death_2='CVD' then mortality='Death due to CVD';
if cause_death_2='Did not Die ' then mortality='Did not die';
if cause_death_2 ne 'CVD' and cause_death_2 ne 'Did not Die ' then mortality='Death due to other competing risk';

 proc format; picture mypct (round) low-high='009.9%'; run;
proc tabulate data=clean_data3  s=[just=r cellwidth=125] missing ; 
 class   birth_country dead mortality;
tables 	 birth_country 
 		all={label='Total'},
		(mortality)*( N  rowpctn={label='Percent (%)'}*f=mypct.) all={label='Total'};
title 'Table 3: Does risk of cardiovascular mortality vary among immigrants from different source countries?';
run;


 
 
