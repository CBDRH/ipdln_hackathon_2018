library(dplyr)
library(readr)

clean_data <- read_csv(file="ipdln_hackathon_2018_data/ipdln_synth_final.csv") %>%
  rename(ab_id_dichot = ABDERR_synth) %>% 
  mutate(ab_id_dichot = factor(ab_id_dichot,
                               levels = c(1, 2),
                               labels = c("Aboriginal ID",
                                          "Non-Aboriginal ID"))
         ) %>% 
  rename(ab_id_detailed = ABIDENT_synth) %>% 
  mutate(ab_id_detailed = factor(ab_id_detailed,
                                 levels = c(1:6),
                                 labels = c("North_Am_Indian", "Mètis",
                                            "Inuit",
                                            "Multiple Aborginal ID", 
                                            "Other Aboriginal",
                                            "Non-Aboriginal"))
         ) %>% 
  rename(adl_difficulty = ADIFCLTY_synth) %>% 
  mutate(adl_difficulty = factor(adl_difficulty,
                                 levels = c(1:4),
                                 labels = c("No", "Not stated", "Often",
                                            "Sometimes"))
         ) %>% 
  rename(age_imm = AGE_IMM_R_group_synth) %>% 
  mutate(age_imm = factor(age_imm,
                          levels = c(1:15),
                          labels = c("<5", "5 to <10", "10 to <15",
                                     "15 to <20", "20 to <25", "25 to <30",
                                     "30 to <35", "35 to <40", "40 to <45",
                                     "45 to <50", "50 to <55", "55 to <60",
                                     "60 and over", 
                                     "Non-permanent resident",
                                     "Non-imigrant and others"
                                     ))
         ) %>% 
  rename(citizen_stat = CITSM_synth) %>% 
  mutate(citizen_stat = factor(citizen_stat,
                               levels = c(1, 2),
                               labels = c("Canadian", "non-Canadian"))
         ) %>% 
  rename(cause_death_1 = COD1_synth) %>% 
  mutate(cause_death_1 = factor(cause_death_1,
                                levels = c(1:5),
                                labels = c("Communicable etc.", 
                                           "Noncommunicable", "Injuries",
                                           "Other causes or NA",
                                           "Did not Die"))
         ) %>% 
  rename(cause_death_2 = COD2_synth) %>% 
  mutate(cause_death_2 = factor(cause_death_2,
                                levels = c(1:14),
                                labels = c("Infectious diseases", 
                                           "Respiratory infections",
                                           "Colon and rectal cancers",
                                           "Breast cancers", "Diabetes",
                                           "Dementia", "IHD", "CVD",
                                           "Respiratory diseases",
                                           "Digestive diseases",
                                           "Genitourinary diseases",
                                           "Unintentional injuries",
                                           "Other causes or NA",
                                           "Did not Die"
                                           ))
         ) %>% 
  rename(worker_class = COWD_synth) %>% 
  mutate(worker_class = factor(worker_class,
                               levels = c(1:7),
                               labels = c("Unpaid family workers", 
                                          "Paid worker,no help",
                                          "Paid worker,paid help",
                                          "Paid Worker",
                                          "Self-employed,no help",
                                          "Self-employed,paid help",
                                          "Not applicable "))
         ) %>% 
  rename(adl_disab_difficulty = DISABFL_synth) %>% 
  mutate(adl_disab_difficulty = factor(adl_disab_difficulty,
                                       levels = c(1:4),
                                       labels = c("No", "Not stated",
                                                  "Often", "Sometimes"))
         ) %>% 
  rename(adl_disab_diff_type = DISABIL_synth) %>% 
  mutate(adl_disab_diff_type = factor(adl_disab_diff_type,
                                      levels = c(1:17),
                                      labels = c("ADL & Home & other",
                                                 "ADL & Home & Work/School",
                                                 "ADL & Home & Work/School & other",
                                                 "ADL & Work & other", "ADL & Home",
                                                 "ADL & other", "ADL & Work/school",
                                                 "ADL", "None", "Home & other",
                                                 "Home & Work/school",
                                                 "Home & Work/school & other",
                                                 "Work/school & other", "Home",
                                                 "Other", "Work/school",
                                                 "Not stated"))
         ) %>% 
  rename(birth_country = DPOB11N_synth) %>% 
  mutate(birth_country = factor(birth_country,
                                levels = c(1:10),
                                labels = c("non-Immigrant",
                                           "Latin America & Caribbean",
                                           "Western Europe", "Eastern Europe",
                                           "Sub-Saharan Africa",
                                           "N Africa, SW Asia & Middle East",
                                           "S Asia", "SE Asia", "E Asia", 
                                           "Australia, NZ, Oceania & Greenland"))
         ) %>% 
  rename(vis_minority = DVISMIN_synth) %>% 
  mutate(vis_minority = factor(vis_minority,
                               levels = c(1:14),
                               labels = c("Chinese", "South Asian", "Black",
                                          "Filipino", "Latin American", 
                                          "Southeast Asian", "Arab", "West Asian",
                                          "Korean", "Japanese", 
                                          "Other visible minority",
                                          "Multiple visible minority", 
                                          "Aboriginal self-reporting",
                                          "Not a visible minority"))
         ) %>% 
  rename(no_fam_members = EFCNT_PP_R_synth) %>% 
  mutate(no_fam_members = factor(no_fam_members,
                                 levels = c(1:10),
                                 labels = c("1", "2", "3", "4", "5",
                                            "6", "7", "8", "9", "10 or more"))
         ) %>% 
  rename(first_lang = FOL_synth) %>% 
  mutate(first_lang = factor(first_lang,
                             levels = c(1:4),
                             labels = c("English", "French", "English & French",
                                        "Other"))
         ) %>% 
  rename(employ_status = FPTIM_synth) %>% 
  mutate(employ_status = factor(employ_status,
                                levels = c(1:3),
                                labels = c("Full-time", "Part-time", "Didn't work"))
         ) %>% 
  #Note the definitions in the metadata file - 3rd generation does not mean
  #what I would intuitively think
  rename(generation = GENSTPOB_synth) %>% 
  mutate(generation = if_else(generation == 3, 0L, generation)) %>%
  mutate(generation = factor(generation,
                             levels = c(0:2),
                             labels = c("3rd Generation","1st Generation", "2nd Generation"))
         ) %>%
  rename(education = HCDD_synth) %>% 
  mutate(education = factor(education,
                            levels = c(1:13),
                            labels = c("None", "High School", "Trades Cert/Dip",
                                       "Apprenticeship Cert/Dip",
                                       "Non-Uni Cert/Dip < 1 year",
                                       "Non-Uni Cert/Dip 1-2 years",
                                       "Non-Uni Cert/Dip > 2years",
                                       "Uni Cert/Dip below Bachelor's",
                                       "Bachelor's degree",
                                       "Uni Cert/Dip above Bachelor's",
                                       "Medicine etc.", "Master's degree",
                                       "Doctorate"))
         ) %>% 
  rename(immigration_stat = IMMDER_synth) %>% 
  mutate(immigration_stat = factor(immigration_stat,
                                   levels = c(1:3),
                                   labels = c("Immigrant", "Non-permanent resident",
                                              "Non-immigrant"))
         ) %>% 
  rename(no_kids = KID_group_synth) %>% 
  mutate(no_kids = factor(no_kids,
                          levels = c(1:3),
                          labels = c("None", "1 or 2",
                                     "3 or more"))
         ) %>% 
  rename(lo_inc_aftertax = LOINCA_synth) %>% 
  mutate(lo_inc_aftertax = factor(lo_inc_aftertax,
                                  levels = c(1:3),
                                  labels = c("non-low income", "low income",
                                             "Concept not applicable"))
         ) %>% 
  rename(lo_inc_beforetax = LOINCB_synth) %>% 
  mutate(lo_inc_beforetax = factor(lo_inc_beforetax,
                                   levels = c(1:3),
                                  labels = c("non-low income", "low income",
                                             "Concept not applicable"))
         ) %>% 
  rename(mar_stat = MARST_synth) %>% 
  mutate(mar_stat = if_else(mar_stat == 2, 0L, mar_stat)) %>%
  mutate(mar_stat = factor(mar_stat,
                           levels = c(0,1,3,4,5),
                           labels = c("Married", "Divorced", "Separated",
                                      "Never married", "Widowed"))
         ) %>%
  rename(occupation = NOCSBRD_synth) %>% 
  mutate(occupation = factor(occupation,
                             levels = c(1:11),
                             labels = c("Management", "Business", 
                                        "Science", "Health", "Govt & Religion",
                                        "Art & Culture", "Sales & Service",
                                        "Trades & Transport", "Primary industry",
                                        "Manufacturing", "Not Applicable"))
         ) %>% 
  rename(official_lang = OLN_synth) %>% 
  mutate(official_lang = factor(official_lang,
                                levels = c(1:4),
                                labels = c("English", "French", "English & French",
                                           "Other"))
         ) %>% 
  rename(place_of_birth = POBDER_synth) %>% 
  mutate(place_of_birth = factor(place_of_birth,
                                 levels = c(1:3),
                                 labels = c("Home province","Other province",
                                            "Outside Canada"))
         ) %>% 
  rename(province = PR_synth) %>% 
  mutate(province = if_else(province == 35, 0L, province)) %>%
  mutate(province = factor(province,
                           levels = c(0, 10, 11, 12, 13, 24,
                                      46, 47, 48, 59, 60, 61, 62),
                           labels = c("Ontario", "Newfoundland and Labrador",
                                      "Prince Edward Island",
                                      "Nova Scotia", "New Brunswick", "Quebec",
                                      "Manitoba", "Saskatchewan",
                                      "Alberta", "British Columbia", "Yukon",
                                      "Northwest Territories", "Nunavut"))
         ) %>%
  rename(repairs = RPAIR_synth) %>% 
  mutate(repairs = factor(repairs,
                          levels = c(1:4),
                          labels = c("No", "Minor", "Major", "Not applicable"))
         ) %>% 
  rename(rur_urb = RUINDFG_synth) %>% 
  mutate(rur_urb = if_else(rur_urb == 2, 0L, rur_urb)) %>%
  mutate(rur_urb = factor(rur_urb,
                          levels = c(0, 1),
                          labels = c("Urban", "Rural"))
        ) %>% 
  rename(sex = SEX_synth) %>% 
  mutate(sex = factor(sex,
                      levels = c(1, 2),
                      labels = c("Female", "Male"))
         ) %>% 
  rename(dead = S_DEAD_synth) %>% 
  mutate(dead = if_else(dead == 2, 0L, dead)) %>%
  mutate(dead = factor(dead,
                       levels = c(0,1),
                       labels = c("Not Dead", "Dead"))
         ) %>% 
  rename(transport = TRMODE_synth) %>% 
  mutate(transport = factor(transport,
                            levels = c(1:9),
                            labels = c("Bicycle", "Driver", "Motorbike",
                                       "Other", "Passenger", "Taxi", 
                                       "Public Transport", "Walk", "Not applicable"))
         ) %>% 
  rename(year_imm = YRIM_group_synth) %>% 
  mutate(year_imm = factor(year_imm,
                           levels = c(1:6),
                           labels = c("2002 or later", "1997-2001", "1987-1996",
                                      "1986 or earlier", "Non-permanent resident",
                                      "Non-immigrant and others"))
         ) %>% 
  rename(age_grp = age_group_synth) %>% 
  mutate(age_grp = factor(age_grp,
                          levels = c(1:15),
                          labels = c("19-24", "25-29", "30-34", "35-39", "40-44",
                                     "45-49", "50-54", "55-59", "60-64", "65-69",
                                     "70-74", "75-79", "80-84", "85-89", "90 plus"))
         ) %>% 
  rename(loinc_decile = d_licoratio_da_bef_synth) %>% 
  mutate(loinc_decile = if_else(loinc_decile == 10, 0L, loinc_decile)) %>%
  mutate(loinc_decile = factor(loinc_decile,
                               levels = c(0:9),
                               labels = c("10 - highest", "1 - lowest", "2", "3", "4", "5",
                                          "6", "7", "8", "9" )))

str(clean_data)

feather::write_feather(clean_data, path="assets/clean_data/clean_data.feather")

