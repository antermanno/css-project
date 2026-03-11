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

# scale_fill_manual(
#   name = "Party",
#   labels = c("FORZA ITALIA", "FRATELLI D'ITALIA", "LEGA",
#              "MOVIMENTO 5 STELLE", "OTHER", "PARTITO DEMOCRATICO"),
#   values = c("#3788fd", "#003366", "#97d45f","#fecc3c","#5a5a5a",  "#fe624f"))+

# histrogram of the data: lega is clearly bi-modal, NOTE
data_plot[ PARTY == "FRATELLI_D_ITALIA" |
            PARTY == "LEGA" |
             PARTY == "PARTITO_DEMOCRATICO" ,] |>
  ggplot(aes(x = SHARE))+
  # geom_density(fill = "grey")+
  geom_histogram(aes(fill = PARTY),alpha = 0.9,  binwidth = 0.01)+
scale_fill_manual(
  name = "Party",
  values = c("#3788fd",  "#97d45f", "#fe624f"))+
  theme_bw()+
  theme(legend.position = "none")+
  facet_wrap(~PARTY)




data13 <- party_abs_vote_share_by_comune(camera13)


fit_dir = fitDirichlet(data13[,.(FRATELLI_D_ITALIA,LEGA,PARTITO_DEMOCRATICO, FORZA_ITALIA,
                                MOVIMENTO_5_STELLE, O, ABSTENTION)])

c(fit_dir$alpha[1], alpha_pd)
# The estimates of from the dirichlet and the betaregression are pretty similar.
# From now on we will use the dirichlet estimation for convenience and speed.

data_mock = rdirichlet(10000, fit_dir$alpha)
data.frame(data_mock) |>
  ggplot(aes(x = X3))+
  geom_density(fill = "grey")+
  theme_bw()

