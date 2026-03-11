rm(list = ls())
source("explore_data/utils.R")
library(data.table)
library(ggplot2)
library(dplyr)
library(compositions)
library(lme4)

load_all_data_tables(markdown = F)
gtrend = load_gtrends_data(markdown = F)

set_region_column_camera()
set_region_column_senato()

data22 <- party_abs_vote_share_by_comune(camera22)
data18 <- party_abs_vote_share_by_comune(camera18)
data13 <- party_abs_vote_share_by_comune(camera13)

data18 <- data18[-316]
data13 <- data18[-316]

# function for estimating dirichlet params by region given datasets
get_actractiveness_dt <- function(DT, ...){

  fitted = lapply(unique(DT$REGION), function(reg){
    param = fitDirichlet(DT[REGION == reg, .(ABSTENTION, FORZA_ITALIA,
                                             FRATELLI_D_ITALIA, LEGA,
                                             MOVIMENTO_5_STELLE, O,
                                             PARTITO_DEMOCRATICO)])
    data.frame(alpha = param$alpha, REGION = reg, ...)
  })

  rbindlist(fitted)
}

party_names = c("ABS", "FI", "FDI", "LEGA", "M5S", "OTH", "PD")

al13 = get_actractiveness_dt(data13, PARTY = party_names, year = 0)
al18 = get_actractiveness_dt(data18, PARTY = party_names, year = 1)
al22 = get_actractiveness_dt(data22, PARTY = party_names, year = 2)

data_alpha = rbind(al13, al18, al22)

# encode incumbency and the "treatment" variable
data_enc = data_alpha |>
  mutate(M = if_else( (PARTY == "LEGA" & year > 0) | (PARTY == "FDI" & year > 1), 1, 0),
         inc = case_when(
           PARTY == "PD" & (year == 1 | year == 2) ~ 1 ,
           PARTY == "M5S" & year == 2 ~ 1 ,
           PARTY == "FI" ~ 1 ,
           PARTY == "FDI" & year == 0 ~ 1 ,
           PARTY == "PD" & (year == 0 | year == 2) ~ 1 ,
           .default = 0
         ))


# get the racially charged search rate data for each region and year
RCSR_2022 = get_rcsr_by_region(gtrend, year = 2022)
RCSR_2022 = RCSR_2022 |>
   rename(RCSR = RCSR_2022 ) |>
  mutate(year = 2)
RCSR_2018 = get_rcsr_by_region(gtrend, year = 2018)
RCSR_2018 = RCSR_2018 |>
   rename(RCSR = RCSR_2018 ) |>
  mutate(year = 1)
RCSR_2013 = get_rcsr_by_region(gtrend, year = 2013)
RCSR_2013 = RCSR_2013 |>
   rename(RCSR = RCSR_2013 ) |>
  mutate(year = 0)

rcsr = rbind(RCSR_2013, RCSR_2018, RCSR_2022)

data_w_abs = inner_join(data_enc, rcsr, by = c("REGION", "year"))
data_no_abs = data_w_abs[PARTY != "ABS", ]


fit= lm(log(alpha) ~ year + M + inc + RCSR:M , data_no_abs, REML = FALSE)
fit1= lmer(log(alpha) ~ (1 | REGION*PARTY) + year + M + inc + RCSR:M  , data_no_abs, REML = FALSE)

plot(fit)
plot(fit1)

anova(fit, fit1)
BIC(fit)
BIC(fit1)
plot(fit, abs(resid(.))  ~  log(alpha) | PARTY)
plot(fit, resid(.)  ~  log(alpha) | year)
plot(fit,PARTY   ~resid(.)  | year)
plot(fit, fitted(.)  ~  log(alpha) | PARTY)
plot(fit, fitted(.)  ~  log(alpha) | year)
plot(fit, resid(., scale = TRUE)  ~  fitted(.)| M)