rm(list = ls())
source("R/utils.R")
library(data.table)
library(ggplot2)
library(dplyr)
library(ggalluvial)

# load_data
load_all_data_tables(markdown = FALSE)

set_region_column_camera()
set_region_column_senato()

all_yrs = get_party_share_all_years()
data_alluvial = all_yrs[REGION == "VENETO", .(SHARE_PARTY = sum(SHARE)), by = .(PARTY, YEAR)][
  , .(PARTY, SHARE_PARTY,yr = as.integer(stringr::str_extract(YEAR, "\\d+")) )
]

data_alluviat_tot_vot = all_yrs[complete.cases(all_yrs), .( VOTI = sum(VOTI),
                                     yr = as.integer(stringr::str_extract(YEAR, "\\d+"))),
                                by = .(YEAR, PARTY)]


options(scipen = 9999)
ggplot(data = data_alluviat_tot_vot,
       aes(x = yr, y = VOTI, alluvium = PARTY)) +
  geom_alluvium(aes(fill = PARTY),
                alpha = .75, decreasing = FALSE) +
  geom_stratum(aes(stratum = PARTY, fill = PARTY), decreasing = FALSE,
               width = 0.3)+
  scale_x_continuous(breaks = c(2013, 2018, 2022)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = -30, hjust = 0),
        axis.text = element_blank()) +
  scale_fill_manual(
    name = "Party",
    labels = c("FORZA ITALIA", "FRATELLI D'ITALIA", "LEGA",
               "MOVIMENTO 5 STELLE", "OTHER", "PARTITO DEMOCRATICO"),
    values = c("#3788fd", "#003366", "#97d45f","#fecc3c","#5a5a5a",  "#fe624f"))+
  # scale_colour_manual(
  #   name = "Party",
  #   labels = c("FORZA ITALIA", "FRATELLI D'ITALIA", "LEGA",
  #              "MOVIMENTO 5 STELLE", "OTHER", "PARTITO DEMOCRATICO"),
  #   values = c("#00a2e8", "#003366", "#008000","#ffeb3b","#5a5a5a",  "#e91d24"))+
  labs(title = "ITALIAN ELECTIONS",
       x = NULL, y = "TOTAL VOTES")


ggplot(data = data_alluviat_tot_vot,
       aes(x = yr, y = VOTI, alluvium = PARTY)) +
  geom_alluvium(aes(fill = PARTY),
                alpha = .75, decreasing = FALSE) +
  geom_stratum(aes(stratum = PARTY, fill = PARTY), decreasing = FALSE,
               width = 0.3)+
  scale_x_continuous(breaks = c(2013, 2018, 2022)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = -30, hjust = 0),
        axis.text = element_blank()) +
  scale_fill_manual(
    name = "Party",
    labels = c("FORZA ITALIA", "FRATELLI D'ITALIA", "LEGA",
               "MOVIMENTO 5 STELLE", "OTHER", "PARTITO DEMOCRATICO"),
    values = c("#3788fd", "#003366", "#97d45f","#5a5a5a","#5a5a5a",  "#5a5a5a"))+
  # scale_colour_manual(
  #   name = "Party",
  #   labels = c("FORZA ITALIA", "FRATELLI D'ITALIA", "LEGA",
  #              "MOVIMENTO 5 STELLE", "OTHER", "PARTITO DEMOCRATICO"),
  #   values = c("#00a2e8", "#003366", "#008000","#ffeb3b","#5a5a5a",  "#e91d24"))+
  labs(title = "ITALIAN ELECTIONS",
       x = NULL, y = "TOTAL VOTES")


ggplot(data = data_alluviat_tot_vot,
       aes(x = yr, y = VOTI, alluvium = PARTY)) +
  geom_alluvium(aes(fill = PARTY),
                alpha = .75, decreasing = FALSE) +
  geom_stratum(aes(stratum = PARTY, fill = PARTY), decreasing = FALSE,
               width = 0.3)+
  scale_x_continuous(breaks = c(2013, 2018, 2022)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = -30, hjust = 0),
        axis.text = element_blank()) +
  scale_fill_manual(
    name = "Party",
    labels = c("FORZA ITALIA", "FRATELLI D'ITALIA", "LEGA",
               "MOVIMENTO 5 STELLE", "OTHER", "PARTITO DEMOCRATICO"),
    values = c("#5a5a5a", "#5a5a5a", "#5a5a5a","#5a5a5a","#c49e62",  "#5a5a5a"))+
  # scale_colour_manual(
  #   name = "Party",
  #   labels = c("FORZA ITALIA", "FRATELLI D'ITALIA", "LEGA",
  #              "MOVIMENTO 5 STELLE", "OTHER", "PARTITO DEMOCRATICO"),
  #   values = c("#00a2e8", "#003366", "#008000","#ffeb3b","#5a5a5a",  "#e91d24"))+
  labs(title = "ITALIAN ELECTIONS",
       x = NULL, y = "TOTAL VOTES")


gtrend$rcsr_italy_0522.csv |>
  ggplot(aes(x = Time, y = RCSR))+
  geom_hline(yintercept = mean(gtrend$rcsr_italy_0522.csv$RCSR), color = "#1e2a32",
             size = 1)+
  geom_line(col ="#c15546", size = 0.7)+
  theme_minimal()+
  labs(x = NULL, title = "OVER TIME - ITALY",
       y = NULL)

