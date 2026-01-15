# RESEARCH QUESTION: Did the transition back to MOVIMENTO 5 STAR from right
# wing voters was driven by racial animus?
rm(list = ls())
library(data.table)
library(ggplot2)
camera = data.table::fread("../data/camera-20220925/Camera_Italia_LivComune.csv")
senato = data.table::fread("../data/senato-20220925/Senato_Italia_LivComune.csv")

camera18 = data.table::fread("../data/camera-20180304/Camera2018_livComune.txt")
senato18 = data.table::fread("../data/senato-20180304/Senato2018_livComune.txt")

camera13 = data.table::fread("../data/camera-20130224/camera_italia-20130224.txt")
senato13 = data.table::fread("../data/senato-20130224/senato_italia-20130224.txt")

camera08 = data.table::fread("../data/camera-20080413/camera_italia-20080413.txt")
senato08 = data.table::fread("../data/senato-20080413/senato_italia-20080413.txt")
# get a toy sample to familiarize with data
# ind = sample.int(10, 5)

# get the data at communal level
camera[COMUNE == "BOLOGNA", #| COMUNE == "PIACENZA" | COMUNE == "FIRENZE" ,
       .(VOTICANDIDATO, VOTILISTA, DESCRLISTA, COGNOME, COMUNE,
         `CIRC-REG`, CODTIPOELEZIONE)]

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

library(stringr)
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
