rm(list = ls())
source("explore_data/utils.R")
library(data.table)
library(ggplot2)
library(dplyr)
library(stringdist)
library(sf)
library(compositions)
library(betareg)
library(DirichletReg)
library(MCMCpack)

load_all_data_tables(markdown = FALSE)
# fix the directory thingy NOTE
# load_18_22_data_tables()
gtrend = load_gtrends_data(markdown = FALSE)

set_region_column_camera()
set_region_column_senato()

# get the party shares for all years

data_plot = get_vote_share_by_comune_by_party(camera13)
# let's plot PD, FDI, and FI in 2013

data_plot[PARTY == "PARTITO_DEMOCRATICO" |
            PARTY == "FRATELLI_D_ITALIA" |
            PARTY == "FORZA_ITALIA",] |>
  ggplot(aes(x = SHARE))+
  geom_density(fill = "grey")+
  theme_bw()+
  facet_wrap(~PARTY)

data13 <- party_abs_vote_share_by_comune(camera13)
fit = betareg(PARTITO_DEMOCRATICO~1,data = data13)

alpha_pd = exp(fit$coefficients$mu)*fit$coefficients$phi

fit_dir = fitDirichlet(data13[,.(PARTITO_DEMOCRATICO, FORZA_ITALIA, FRATELLI_D_ITALIA,
                                MOVIMENTO_5_STELLE, O,ABSTENTION)])

c(fit_dir$alpha[1], alpha_pd)
# The estimates of from the dirichlet and the betaregression are pretty similar.
# From now on we will use the dirichlet estimation for convenience and speed.

data_mock = rdirichlet(10000, fit_dir$alpha)
data.frame(data_mock) |>
  ggplot(aes(x = X3))+
  geom_density(fill = "grey")+
  theme_bw()





