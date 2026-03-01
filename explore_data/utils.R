#' load the last years raw data.tables
load_all_data_tables <- function(){
  camera22 <<- data.table::fread("../data/camera-20220925/Camera_Italia_LivComune.csv")
  senato22 <<- data.table::fread("../data/senato-20220925/Senato_Italia_LivComune.csv")

  camera18 <<- data.table::fread("../data/camera-20180304/Camera2018_livComune.txt")
  senato18 <<- data.table::fread("../data/senato-20180304/Senato2018_livComune.txt")

  camera13 <<- data.table::fread("../data/camera-20130224/camera_italia-20130224.txt")
  senato13 <<- data.table::fread("../data/senato-20130224/senato_italia-20130224.txt")

  camera08 <<- data.table::fread("../data/camera-20080413/camera_italia-20080413.txt")
  senato08 <<- data.table::fread("../data/senato-20080413/senato_italia-20080413.txt")
}

#' load the last two election relevant data.tables
load_18_22_data_tables <- function(){
  camera22 <<- data.table::fread("data/camera-20220925/Camera_Italia_LivComune.csv")
  senato22 <<- data.table::fread("data/senato-20220925/Senato_Italia_LivComune.csv")

  camera18 <<- data.table::fread("data/camera-20180304/Camera2018_livComune.txt")
  senato18 <<- data.table::fread("data/senato-20180304/Senato2018_livComune.txt")
}

set_region_column_camera <- function(){

camera22[, REGION := stringr::str_extract(`CIRC-REG`, '\\w*')]
camera18[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]
camera13[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]
camera08[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]

camera13 <<- camera18[, COLLEGIO := COMUNE]
camera18 <<- camera18[REGION != "AOSTA", COLLEGIO := COLLEGIOUNINOMINALE]
camera22 <<- camera22[ , `:=`(
  VOTANTI = VOTANTITOT,
  ELETTORI = ELETTORITOT,
  LISTA = DESCRLISTA,
  VOTI_LISTA = VOTILISTA,
  COLLEGIO = COLLUNINOM
)]
}

set_region_column_senato <- function(){

senato22[, REGION := stringr::str_extract(`CIRC-REG`, '\\w*')]
senato18[, REGION := stringr::str_extract(REGIONE, '\\w*')]
senato13[, REGION := stringr::str_extract(REGIONE, '\\w*')]
senato08[, REGION := stringr::str_extract(REGIONE, '\\w*')]

senato18 <<- senato18[REGION != "AOSTA" & REGION != "TRENTINO", ]
senato22 <<- senato22[ , `:=`(
  VOTANTI = VOTANTITOT,
  ELETTORI = ELETTORITOT,
  LISTA = DESCRLISTA,
  VOTI_LISTA = VOTILISTA,
  COLLEGIO = COLLUNINOM
)]
}

set_party_names <- function(DT){

  c = copy(DT)
  c[, RIGHTWING := filter_right_wing(LISTA)]
  c[, PARTY := filter_minor_parties(LISTA)]

  return(c)
}
filter_minor_parties <- function(partylist){
  dplyr::case_match(
    partylist,
    c("LEGA PER SALVINI PREMIER", "LEGA", "LEGA NORD") ~ "LEGA",
    c("FORZA ITALIA", "IL POPOLO DELLA LIBERTA'") ~ "FORZA_ITALIA",
    c("FRATELLI D'ITALIA", "FRATELLI D'ITALIA CON GIORGIA MELONI") ~ "FRATELLI_D_ITALIA",
    c("PARTITO DEMOCRATICO", "PARTITO DEMOCRATICO - ITALIA DEMOCRATICA E PROGRESSISTA") ~ "PARTITO_DEMOCRATICO",
    c("MOVIMENTO 5 STELLE", "MOVIMENTO 5 STELLE BEPPEGRILLO.IT") ~ "MOVIMENTO_5_STELLE",
    .default = "O"
  )
}

filter_right_wing_mainstream <- function(partylist){
  dplyr::case_match(
    partylist,
    c("LEGA", "FORZA_ITALIA", "FRATELLI_D_ITALIA") ~ "MAINSTREAM_RIGHT",
    .default = "O"
  )
}

filter_right_wing <- function(partylist){
  filter_right_wing_mainstream(filter_minor_parties(partylist))
}

# load data from the gtrends folder
load_gtrends_data <- function(){
  files = list.files(path = "../data/gtrends/")
  files = sapply(files, function(x) paste0("../data/gtrends/", x))
  lapply((files), data.table::fread)
}

#' get turnout from a dataset
get_turnout_by <- function(DT, is22 = FALSE){
  if (is22){
    copy <- DT
    copy = copy[,.(COMUNE, ELETTORITOT, VOTANTITOT, REGION)]
    copy = copy[!duplicated(copy),]
    copy = copy[, .(TOTEL = sum(ELETTORITOT), TOTVOT = sum(VOTANTITOT)), by = REGION]
    copy = copy[, TURNOUT := TOTVOT/TOTEL]
    # gtrends_data <<- copy
    return(copy)
  }
  copy <- DT
  copy = copy[,.(COMUNE, ELETTORI, VOTANTI, REGION)]
  copy = copy[!duplicated(copy),]
  copy = copy[, .(TOTEL = sum(ELETTORI), TOTVOT = sum(VOTANTI)), by = REGION]
  copy = copy[, TURNOUT := TOTVOT/TOTEL]
  # gtrends_data <<- copy
  return(copy)

}

get_rcsr_by_region <- function(gtrend, year = 2022){
  if (year == 2022){
    gtrend_reg = copy(gtrend$gtrends_22.csv)
  } else {
    gtrend_reg = copy(gtrend$gtrend_18.csv)
  }
  rcsr_col_name = paste0("RCSR_", year)
  setnames(gtrend_reg, c("Region", rcsr_col_name))
  gtrend_reg = gtrend_reg[, REG := toupper(Region)]
  gtrend_reg[, REGION := stringr::str_extract(REG, '\\w*' )]
  gtrend_reg = gtrend_reg[REGION != "VALLE", mget(c("REGION", rcsr_col_name))]
  return(gtrend_reg)
}


# join the tables 2018
get_joint_voteshare <- function(table, list, by_comune = FALSE){
  data_cor = inner_join(table[LISTA == list,
                                 .(VOTI = sum(VOTI_LISTA)), by = REGION],
                        table[LISTA == list,
                                 .(VOTERS = sum(VOTANTI)), by = REGION],
                        by = "REGION")
  data_comune = inner_join(table[LISTA == list,
                                 .(VOTI = sum(VOTI_LISTA)), by = COMUNE],
                        table[LISTA == list,
                                 .(VOTERS = sum(VOTANTI)), by = COMUNE],
                        by = "COMUNE")
  # print(data_cor)
  # data_cor = inner_join(data_cor, rcsr_tbl, by = "REGION")
  if (by_comune) return(data_comune[,.(COMUNE, REGION, VOTI, VOTERS, LISTA = ..list)])
  data_cor[,.(REGION, VOTI, VOTERS, LISTA = ..list)]
}

get_party_share_all_years <- function(senato = FALSE){
  year = camera22
  if (senato) {year = senato22}
  all_parties22 = lapply(unique(year$LISTA) , get_joint_voteshare,
                         table = year)
  all_parties22 = rbindlist(all_parties22)
  all_parties22[, YEAR := "Y2022"]

  year = camera18
  if (senato) {year = senato18}
  all_parties18 = lapply(unique(year$LISTA) , get_joint_voteshare,
                         table = year)
  all_parties18 = rbindlist(all_parties18)
  all_parties18[, YEAR := "Y2018"]

  year = camera13
  if (senato) {year = senato13}
  all_parties13 = lapply(unique(year$LISTA) , get_joint_voteshare,
                         table = year)
  all_parties13 = rbindlist(all_parties13)
  all_parties13[, YEAR := "Y2013"]

  data_221813 = rbind(all_parties18, all_parties22, all_parties13)

  data_221813[, RIGHTWING := filter_right_wing(LISTA)]
  data_221813[, PARTY := filter_minor_parties(LISTA)]
  data_221813[, SHARE := VOTI/VOTERS]

  data_221813
}

get_share_by_comune_year <- function(DT, party = "MAINSTREAM_RIGHT", major_parties = T){
}

get_share_by_region_year <- function(DT, party = "MAINSTREAM_RIGHT", major_parties = T){
  if (party == "MAINSTREAM_RIGHT" ){
    return( DT[RIGHTWING == "MAINSTREAM_RIGHT",
       .(SHARE = sum(SHARE)), by = .(REGION, YEAR) ] )
  }
  if (!major_parties){
    return(DT[LISTA == party,
              .(SHARE = sum(SHARE)), by = .(REGION, YEAR) ])
  }
  return(DT[PARTY == party,
          .(SHARE = sum(SHARE)), by = .(REGION, YEAR) ])
}

get_delta_share <- function(sharedt){
  delta_share = dcast(sharedt,
                      REGION ~ YEAR,
                      value.var = c("SHARE")
  )[, .(delta2218 =  (Y2022 - Y2018)*100,
        delta1813 =  (Y2018 - Y2013)*100,
        SX_2022 = Y2022 * 100,
        SX_2018 = Y2018 * 100,
        SX_2013 = Y2013 * 100,
        REGION)]
  delta_share
}

get_turnout_over_years <- function(senato = FALSE){

  year = camera22
  if (senato) {year = senato22}
  turn22 = get_turnout_by(year, is22 = TRUE)
  turn22 = turn22[,.(REGION, TURN22 = TURNOUT)]

  year = camera18
  if (senato) {year = senato18}
  turn18 = get_turnout_by(year)
  turn18 = turn18[,.(REGION, TURN18 = TURNOUT)]

  year = camera13
  if (senato) {year = senato13}
  turn13 = get_turnout_by(year)
  turn13 = turn13[,.(REGION, TURN13 = TURNOUT)]
  data = inner_join(turn13 , turn18, by = "REGION")
  data = inner_join(data, turn22, by = "REGION")
  data
}

join_by_reg <- function(DT, table){
  data = inner_join(DT, table, by = "REGION")
  data
}

get_final_dataset_by_party <- function(party = "MAINSTREAM_RIGHT"){

  RCSR_2022 = get_rcsr_by_region(gtrend, year= 2022)
  RCSR_2018 = get_rcsr_by_region(gtrend, year= 2018)

  data_221813 = get_party_share_all_years()
  print(data_221813)
  share = get_share_by_region_year(data_221813,
                                      party = party)
  delta_share = get_delta_share(share)
  turnout = get_turnout_over_years()

  data = join_by_reg(delta_share, turnout)
  data = join_by_reg(data, RCSR_2018)
  data = join_by_reg(data, RCSR_2022)

  data = data[, .(delta2218, delta1813, REGION, RCSR_2022, RCSR_2018,
                  SX_2022, SX_2018, SX_2013,
                  delta_turn2218 = 100*(TURN22 - TURN18),
                  delta_turn1813 = 100*(TURN18 - TURN13))]
  data
}

get_party_names <- function(major_parties = TRUE ,year = "ALL"){

  lista22 = camera22$LISTA |> unique()
  lista18 = camera18$LISTA |> unique()
  lista13 = camera13$LISTA |> unique()
  lista08 = camera08$LISTA |> unique()
  lista_all = c(lista08, lista13, lista18, lista22)

  if (major_parties) {

    lista22 = filter_minor_parties(lista22 ) |> unique()
    lista18 = filter_minor_parties(lista18 ) |> unique()
    lista13 = filter_minor_parties(lista13 ) |> unique()
    lista08 = filter_minor_parties(lista08 ) |> unique()
    lista_all = filter_minor_parties(lista_all ) |> unique()

  }
  switch (as.character(year),
    "2022" = lista22,
    "2018" = lista18,
    "2013" = lista13,
    "2008" = lista08,
    "ALL" = lista_all)

}

get_share_by_comune <- function(DT, list){
  data_by_comune = inner_join(
    DT[ LISTA == list, .(VOTI = sum(VOTI_LISTA)), by = .(REGION, COMUNE)],
    DT[ LISTA == list, .(VOTERS = sum(VOTANTI)), by = .(REGION, COMUNE) ],
    by = c("REGION", "COMUNE")
  )[,.(REGION, COMUNE, SHARE = VOTI/VOTERS),]
}


# data_by_comune|>
#   ggplot(aes(x = SHARE, after_stat(density)))+
#   geom_density(bounds = c(0, 1), fill = party_color, alpha = .8)+
#   labs(y = NULL)+
#   facet_grid(REGION~.)+
#   theme_minimal()


get_vote_share_by_comune_by_party <- function(DT){
  unique(DT[,.(PARTY = filter_minor_parties(LISTA),
        VOTI_LISTA, COLLEGIO, REGION, ELETTORI, COMUNE, VOTANTI)][
          , .(SHARE = sum(VOTI_LISTA)/ELETTORI, REGION, ABSTENTION = 1 - VOTANTI/ELETTORI),
          by= .(PARTY, COLLEGIO, ELETTORI, COMUNE)])#[
            # , .(ABSTENTION = 1 - sum(SHARE),
            #     PARTY, SHARE, REGION), by = .(ELETTORI, COLLEGIO)]
}

party_abs_vote_share_by_comune <- function(DT){
  get_vote_share_by_comune_by_party(DT)

  dcast(get_vote_share_by_comune_by_party(DT),
        ELETTORI + COLLEGIO + REGION + COMUNE + ABSTENTION ~ PARTY,
        value.var = "SHARE")[]
}
