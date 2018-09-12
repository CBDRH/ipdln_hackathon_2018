library(feather)
library(speedglm)
library(broom)

clean_data <- read_feather(path="assets/clean_data.feather")

str(clean_data)

# baseline logistic model
# baseglm <- glm(dead ~ age_grp + sex + loinc_decile + rur_urb +
#                      province + lo_inc_aftertax + mar_stat + generation, 
#                      family=binomial, data=clean_data)
# 
# summary(baseglm)

baseglm <- speedglm(dead ~ age_grp + sex + loinc_decile + rur_urb +
                     province + lo_inc_aftertax + mar_stat + generation, 
                     family=binomial(), data=clean_data)

summary(baseglm)

baseglm_df <- tidy(baseglm) %>%
              bind_cols(tibble(or=exp(coef(baselm_sp)))) %>%
              bind_cols(as.data.frame(exp(confint(baselm_sp)))) %>%
              rename(ci95_lower = "2.5 %", ci95_upper = "97.5 %")
baseglm_df

# OK, that model output exactly matches Sumeet's SAS PROC LOGISTIC model output


