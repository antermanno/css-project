library(data.table)
library(ggplot2)
camera = data.table::fread("../data/camera-20220925/Camera_Italia_LivComune.csv")
senato = data.table::fread("../data/senato-20220925/Senato_Italia_LivComune.csv")

# get a toy sample to familiarize with data
# ind = sample.int(10, 5)

# get the data at communal level
camera[COMUNE == "BOLOGNA", #| COMUNE == "PIACENZA" | COMUNE == "FIRENZE" ,
       .(VOTICANDIDATO, VOTILISTA, DESCRLISTA, COGNOME, COMUNE,
         `CIRC-REG`, CODTIPOELEZIONE)]

senato[COMUNE == "VALSAMOGGIA", #| COMUNE == "PIACENZA" | COMUNE == "FIRENZE" ,
       .(VOTICANDIDATO, VOTILISTA, DESCRLISTA, COGNOME, COMUNE,
         COLLPLURI, COLLUNINOM)]


# GET RESULTS BY COMUNE
camera[COMUNE == "NAPOLI", #| COMUNE == "PIACENZA" | COMUNE == "FIRENZE" ,
       .( 100*( VOTICANDIDATO - sum(VOTILISTA) )/ VOTICANDIDATO , VOTICANDIDATO 
          ,DESCRLISTA),
       by = COGNOME]

# Get list total votes
camera[, .(sum = sum(VOTILISTA)), by = .(DESCRLISTA )] [sum > 10e5][order(-sum)]

# plot a map
