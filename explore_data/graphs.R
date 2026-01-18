rm(list = ls())
source("explore_data/utils.R")
library(data.table)
library(ggplot2)
library(dplyr)
library(stringdist)

load_all_data_tables()
# load_18_22_data_tables()
gtrend = load_gtrends_data()

set_region_column_camera()
# group by region and not electoral district
# camera22[, REGION := stringr::str_extract(`CIRC-REG`, '\\w*')]
# camera18[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]
# camera13[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]
# camera08[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]

# COMPARE THAT THE REGION DENOMINATION IS THE SAME FOR ALL
lapply(list(camera08, camera13, camera18, camera22), function(x){
  x$REGION |> unique() |> sort()
})

# DROP AOSTA FROM YEAR 2018
# camera18 <- camera18[REGION != "AOSTA", ]

# GET GTRENDS BY CORRECTLY NAMED REGION
# gtrend_reg = gtrend$racecharge_by_region.csv
# setnames(gtrend_reg, c("Region", "RCSR_all_time"))
# gtrend_reg = gtrend_reg[, REG := toupper(Region)]
# gtrend_reg[, REGION := stringr::str_extract(REG, '\\w*' )]
# gtrend_reg = gtrend_reg[REGION != "VALLE", .(REGION, RCSR_all_time)]


(test = get_turnout_by(camera22, is22 = TRUE))
(test = get_turnout_by(camera18))
test[, .(TURNOUT = (sum(TOTVOT)/sum(TOTEL)))]

(tmp = get_rcsr_by_region(gtrend))


(joint = get_joint_voteshare_rcsr_tbl(camera22 ,rcsr_tbl = tmp,
                             list = "FRATELLI D'ITALIA"))
# get_vote_share_by_region_for_major_parties
year = camera22
all_parties = lapply(unique(year$LISTA) , get_joint_voteshare_rcsr_tbl,
        table = year, rcsr_tbl = tmp)
all_parties = rbindlist(all_parties)
all_parties
# join the tables
full_tbl = inner_join(camera22, gtrend_reg)
data_cor = inner_join(camera22[DESCRLISTA == "FRATELLI D'ITALIA CON GIORGIA MELONI",
         .(VOTI = sum(VOTILISTA)), by = REGION],
camera22[DESCRLISTA == "FRATELLI D'ITALIA CON GIORGIA MELONI",
         .(VOTERS = sum(VOTANTITOT)), by = REGION])
data_cor = inner_join(data_cor, tmp)

data_cor22 = data_cor[, .(VOTESHARE = VOTI/VOTERS, REGION, RCSR_all_time )]
ggplot(data_cor22, aes(x=VOTESHARE, y = scale(RCSR_all_time), colour = REGION))+
  geom_point()+
  geom_abline()+
  theme_bw()


# join the tables 2018
full_tbl = inner_join(camera18, tmp)
data_cor = inner_join(camera18[LISTA == "FRATELLI D'ITALIA CON GIORGIA MELONI",
         .(VOTI = sum(VOTI_LISTA)), by = REGION],
camera22[DESCRLISTA == "FRATELLI D'ITALIA CON GIORGIA MELONI",
         .(VOTERS = sum(VOTANTITOT)), by = REGION])
data_cor = inner_join(data_cor, tmp)

data_cor18 = data_cor[, .(VOTESHARE = VOTI/VOTERS, REGION, RCSR_all_time )]

# use a function to perform the same task
(joint = get_joint_voteshare_rcsr_tbl(camera18,rcsr_tbl = tmp,
                             list = "FRATELLI D'ITALIA"))
camera18[LISTA =="FRATELLI D'ITALIA" , .(VOTI = sum(VOTI_LISTA)), by = REGION]
camera18[LISTA == "TEST", .(VOTI = sum(VOTI_LISTA)), by = REGION]

# correlation plots between rcsr variable and voteshare
ggplot(data_cor18, aes(x=VOTESHARE, y = scale(RCSR_all_time), colour = REGION))+
  geom_point()+
  geom_abline()+
  theme_bw()


joined_voted_share = inner_join(data_cor18, data_cor22, by = c("REGION", "RCSR_all_time"))
diff = joined_voted_share[, .(delta = VOTESHARE.y - VOTESHARE.x, REGION, RCSR_all_time)]
diff |>
  ggplot(aes( x = RCSR_all_time  , y = delta, colour = REGION))+
  geom_point()+
  geom_abline()+
  theme_bw()


tot_vot = camera22[,.(COMUNE, ELETTORITOT, VOTANTITOT, REGION)]
lm( delta ~ RCSR_all_time, diff) |> summary()

glm( delta ~ RCSR_all_time, data = diff, family = "")



vot_table = tot_vot[!duplicated(tot_vot),]
total_Vot_region = vot_table[, .(TOTEL = sum(ELETTORITOT), TOTVOT = sum(VOTANTITOT)), by = REGION]
total_Vot_region[, TURNOUT := TOTVOT/TOTEL]



(test = get_turnout_by(camera08[order(REGION)]))
(test2 = get_turnout_by(camera13[order(REGION)]))
(test3 = get_turnout_by(camera18[order(REGION)]))

# turnaout change percentage
log(test3[REGION != "AOSTA",]$TURNOUT/test2$TURNOUT)*100
log(test2$TURNOUT/test$TURNOUT)*100

# camera18[, REGION := stringr::str_extract(oIRCOSCRIZIONE, '\\w*')]
# tot_vot = camera18[,.(COMUNE, ELETTORI, VOTANTI, REGION)]
# vot_table = tot_vot[!duplicated(tot_vot),]
# total_Vot_region = vot_table[, .(TOTEL = sum(ELETTORITOT), TOTVOT = sum(VOTANTITOT)), by = REGION]
# total_Vot_region[, TURNOUT := TOTVOT/TOTEL]

total_Vot_region
# compute fratelli d'italia % by region
vote_tot_by_region = camera22[, .(TOT_VOTES = sum(VOTILISTA)), by = .(REGION, DESCRLISTA)]
# [ DESCRLISTA == "FRATELLI D'ITALIA CON GIORGIA MELONI" ,  ]

full_table = inner_join(tot_vot, vote_tot_by_region)[]# c08 = camera08[, .(TOT_VOTES = sum(VOTI_LISTA)), by = c("REGIONE", "LISTA")]
# c08[ REGIONE == "PUGLIA", ]
full_table[DESCRLISTA == "FRATELLI D'ITALIA CON GIORGIA MELONI",
           .(REGION, PERCENTAGE = TOT_VOTES / TOTALVOTEREGION  * 100)]
