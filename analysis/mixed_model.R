rm(list = ls())
source("R/utils.R")
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

# Encoded vars:

# inc : INCUMBENCY
# - A party is considered incumbent if it was part of at least one government
# coaliton in the previous legislature (the timeframe for which the parliament
#                                       stays in charge)
# communication startegy
# The following variables are relative to the usage of
# the far-right, social media driven, communication strategy employed by
# following parties: Lega (after 2013), Fratelli D'Italia (after 2018)

# A : Active time of Communication strategy

# S : Start of Communication strategy

# M : Keeping strategy after obtaining governance

data_enc = data_alpha |>
  mutate(
         A = if_else( (PARTY == "LEGA" & year > 0) | (PARTY == "FDI" & year > 1), 1, 0),
         S = if_else( (PARTY == "LEGA" & year == 1) | (PARTY == "FDI" & year > 1), 1, 0),
         M = if_else( (PARTY == "LEGA" & year == 2), 1, 0),
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


# Find relevant variables
# we will keep the region*party interaction term.
# As it is reasonable to believe that each party and each
# region have correlated elements among them (as simple as the fact that
# alphas inside a region are estimated jointly and depend of the
# other parties' results inside the region)

# We first estimate just a random intercept model (the model with abstension
# is just for reference). In the model abstension behaves like a perty
# to the extent that it has an actractiveness parameter and
# abide the herding behaviour of agents that switch to it.

fit_0_abs = lmer(log(alpha) ~ (1 | REGION*PARTY),
             data_w_abs, REML = FALSE)

plot(fit_0_abs,PARTY   ~ resid(.)  | year)
# the Lega presents the highest std error. This in the first
# two years, and fratelli d'italia (FDI) alpha is overestimated
# in the 2013 and 2018, and underestimated in the third year.
# This is in line with the shrinking effect of random effects.

# let's add incumbency of a party to the basic model. Comparison
# is with including time as a regressor. (Note, it doesn't make
# sense to define incumbency for abstension. this is just for
# reference, so we know what to include in the final model)
fit_inc_abs = lmer(log(alpha) ~ (1 | REGION*PARTY) + inc,
             data_w_abs, REML = FALSE)
fit_year_abs = lmer(log(alpha) ~ (1 | REGION*PARTY) + year,
             data_w_abs, REML = FALSE)
BIC(fit_year_abs, fit_inc_abs, fit_0_abs)
# We observe that the BIC when including incumbency is noticeably
# lower.

# We now start with the actual modelling of the parties' actractiveness
# We now exclude abstension from the observations.

# base model
fit_0 = lmer(log(alpha) ~ (1 | REGION*PARTY),
             data_no_abs, REML = FALSE)

fit_inc = lmer(log(alpha) ~ (1 | REGION*PARTY) + inc,
             data_no_abs, REML = FALSE)
BIC(fit_inc, fit_0)

# We now include the S term (stands for Started - it
# takes into account only the first year the new communication startegy
# was employed), vs the
# A term (Active communication - the binary variable is 1 in the years they
# maintain the communication strategy). Both refer to the far-right, social media driven,
# communication startegy. First by Lega (before 2018) and later by
# Fratelli D'Italia (before 2022)
# !!! Quantity of interest of this analysis is to capture the interaction
# with the proxy measure for racial animus, not the effect of the communication
# strategy itself. As it is a posteriori known that it had a positive effect.
# We only care for the component of the effect that was *possibly* driven
# by racial animus.

fit_A = lmer(log(alpha) ~ (1 | REGION*PARTY) +  A + inc,
             data_no_abs, REML = FALSE)
fit_S = lmer(log(alpha) ~ (1 | REGION*PARTY) +  S + inc,
             data_no_abs, REML = FALSE)
BIC(fit_A, fit_S)
# The best fit is - expectedly - the year in which a party started
# the new communication/leadership. The postive effect is expected
# as the year the two parties started the new communication is also the
# year they rose in the polls. As Lega experienced a drop in
# polls, it is expected that the A variable has a lower effect due
# to the sharp electoral decline of Lega in 2022 election.

# It is now time to consider time once again.
# An higher alpha coefficient not only implies a higher expected value
# but also a higer concentration of votshare
# However we excluded the alphas that where modelling abstension.
# As abstension increased over time, we expected the overall
# concentration of share among other parties to decrease over time.
# With the year coefficient we try to capture the lost in vote share
# between voters and abstension
fit_S_TIME = lmer(log(alpha) ~ (1 | REGION*PARTY) +  S + inc + year,
             data_no_abs, REML = FALSE)
fit_S_TIME
BIC(fit_S, fit_S_TIME)
anova(fit_S, fit_S_TIME)
# it looks like time improves our model fit.

# Keeping everything elese constant, the effect of time
# reduce the actractiveness of parties by ~ 10%
# each year on average.
# They change by a multiplicative factor of:
exp(-0.09907)



# We include now the interaction term between the proxy for racial
# animus and start of the use of the new communication strategy.
fit_S_rcsr = lmer(log(alpha) ~ (1 | REGION*PARTY) + year + S + inc + RCSR:S,
             data_no_abs, REML = FALSE)
fit_A
fit_S_TIME
fit_S_rcsr
summary(fit_S_rcsr)

fit_S_rcsr
anova(fit_S_TIME, fit_S_rcsr)
# Looking at the anova we test the interaction term.
# We obtain a p-value of 0.01514. !!!

# Computing the e-value as likelihood ratio between the model with and
# without the interaction term
e_val = exp( logLik(fit_S_rcsr) - logLik(fit_S_TIME) )
e_val

BIC(fit_inc, fit_A, fit_S_TIME,  fit_S_rcsr)
AIC(fit_inc, fit_A, fit_S_TIME,  fit_S_rcsr)
# looking at IC the model with the interaction is slightly better

plot(fit_S_rcsr)
# The residual pattern doesn't look too unusual

plot(fit_S_rcsr,PARTY   ~resid(.)  | year)
# We can see that for are still some over and under estimation
# issues for Lega and Fratelli D'Italia.
# Those are to be expected as they have the least linear
# electoral trajectory among parties.

plot(fit_S_rcsr, fitted(.) ~ RCSR | PARTY)
plot(fit_S_rcsr, residuals(.) ~ RCSR | PARTY)
# In the graph it is possible to observe how the fitted
# values and RCSR correlate for different parties
fit_S_TIME

plot(fit_S_TIME, fitted(.) ~ RCSR | PARTY)


# Let's see if the league retained electors more in regions with an higher
# rcsr score

fit_S_rcsr_M = lmer(log(alpha) ~ (1 | REGION*PARTY) + S + M + M:RCSR + inc + RCSR:S,
             data_no_abs, REML = FALSE)

fit = fit_S_rcsr
plot(fit, abs(resid(.))  ~  log(alpha) | PARTY)
plot(fit, resid(.)  ~  log(alpha) | year)
plot(fit, fitted(.)  ~  log(alpha) | PARTY)
plot(fit, fitted(.)  ~  log(alpha) | year)
plot(fit, fitted(.) ~ RCSR | PARTY)
