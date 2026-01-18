# RESEARCH QUESTION: Did the transition back to MOVIMENTO 5 STAR from right
# wing voters was driven by racial animus?
rm(list = ls())
library(data.table)
library(ggplot2)
library(dplyr)
source("explore_data/utils.R")

# load all electoral files from the data directory
load_all_data_tables()

# let's join everything in a big happy table-family
camera22 |> names()
camera18 |> names()
camera13 |> names()
camera08 |> names()

# remove aosta regional district
camera18 = camera18[CIRCOSCRIZIONE != "AOSTA"]

camera_all_list = list(camera08 = camera08,
                       camera13 = camera13,
                       camera18 = camera18,
                       camera22 = camera22)

# stack all the rows (full join)
camera_all = rbindlist(camera_all_list,use.names = TRUE, idcol = "YEAR", fill = TRUE)
camera_all[, .(CIRCOSCRIZIONE = fcoalesce(CIRCOSCRIZIONE, `CIRC-REG`))]

# make only one elettori column
camera_all[, .(ELETTORI = fcoalesce(ELETTORI, ELETTORITOT))] # |> is.na() |> sum()

camera_all[, .(LISTA = fcoalesce(DESCRLISTA, LISTA))] # |> is.na() |> sum()

camera_all[CIRCOSCRIZIONE != "AOSTA",
           .(VOTILISTA = fcoalesce(VOTILISTA, VOTI_LISTA))] |> nrow()

camera_all[CIRCOSCRIZIONE == "AOSTA", .N] # |> is.na() |> sum()
camera_all[, .N] # |> is.na() |> sum()

# get abstension
camera08[COMUNE == "BOLOGNA",
         .(ELETTORI, VOTANTI, ELETTORI_MASCHI,
           ASTENSIONE = 1 - VOTANTI/ELETTORI)]

# get the data at communal level
camera22[COMUNE == "BOLOGNA", #| COMUNE == "PIACENZA" | COMUNE == "FIRENZE" ,
       .( VOTICANDIDATO, VOTILISTA, DESCRLISTA)]

senato[COMUNE == "VALSAMOGGIA", #| COMUNE == "PIACENZA" | COMUNE == "FIRENZE" ,
       .(VOTICANDIDATO,  VOTILISTA, DESCRLISTA, COGNOME, COMUNE,
         COLLPLURI, COLLUNINOM)]


# GET RESULTS BY COMUNE
camera[COMUNE == "NAPOLI", #| COMUNE == "PIACENZA" | COMUNE == "FIRENZE" ,
       .( 100*( VOTICANDIDATO - sum(VOTILISTA) )/ VOTICANDIDATO , VOTICANDIDATO
          ,DESCRLISTA),
       by = COGNOME]

# Get list total votes
c = camera[, .(sum = sum(VOTILISTA)), by = .(DESCRLISTA )][sum > 10e5] [order(-sum)]
# c18 = camera18[, .(sum = sum(VOTI_LISTA)), by = .(LISTA )][order(-sum)]

c[ ,.(DESCRLISTA,percentage = 100 * sum / sum(sum) ) ]
# c18[ ,.(LISTA,percentage = 100 * sum / sum(sum) ) ]
# camera[, .(sum = sum(VOTILISTA)), by = .(DESCRLISTA )]

names(camera)
camera[, length(unique(COMUNE))]
camera[, length(unique(COLLUNINOM))]


camera18[LISTA = ,]
# plot a map
camera18[LISTA == "MOVIMENTO 5 STELLE", sum(is.na(VOTI_LISTA)), by = CIRCOSCRIZIONE]
camera_no_aosta = camera18[CIRCOSCRIZIONE != "AOSTA",]


c8 = camera_no_aosta[, .(sum = sum(VOTI_LISTA)), by = .(LISTA )][sum > 10e5] [order(-sum)]
c8[ ,.(LISTA,percentage = 100 * sum / sum(sum) ) ]

stringdist(camera08$CIRCOSCRIZIONE, c("EMILIA" , "TOSCANA"))
# Let's extract the percentages by region and year
# 2008

# get_electoral_data_country <- function(DT, list, list_votes, region){
#   DT[, TOTAL_VOTES_BY_LIST := sum(c(list_votes)), by = c(list)]
#   # DT[, REGION := str_extract(region, "\\w*")]
#   # DT[, .(list, PERCENTAGE = TOTAL_VOTES_BY_LIST, TOTAL_VOTES_BY_LIST)]
# }

# get_electoral_data_country(camera08, "LISTA", "VOTI_LISTA", "CIRCOSCRIZIONE")

camera08[, .(REGION = str_extract(CIRCOSCRIZIONE, '\\w*'))]
senato08[, unique(REGIONE)]
camera08[, REGIONE := str_extract(CIRCOSCRIZIONE, "\\w*")]
c08 = camera08[, .(TOT_VOTES = sum(VOTI_LISTA)), by = c("REGIONE", "LISTA")]
c08[ REGIONE == "PUGLIA", ]
s08 = senato08[, .(TOT_VOTES = sum(VOTI_LISTA)), by = c("REGIONE", "LISTA")]
s08[ REGIONE == "PUGLIA", ]


camera13[, REGIONE := str_extract(CIRCOSCRIZIONE, '\\w*')]
senato13[, unique(REGIONE)]
c13 = camera13[, .(TOT_VOTES = sum(VOTI_LISTA)), by = c("REGIONE", "LISTA")]
c13[ REGIONE == "PUGLIA", ]
s13 = senato13[, .(TOT_VOTES = sum(VOTI_LISTA)), by = c("REGIONE", "LISTA")]
s13[ REGIONE == "PUGLIA", ]

camera18[, .(REGION = str_extract(CIRCOSCRIZIONE, '\\w*'))][,unique(REGION)]
senato18[, unique(REGIONE)]


camera[, .(REGION = str_extract(`CIRC-REG`, '\\w*'))][,unique(REGION)]
senato[, unique(`CIRC-REG`)]
