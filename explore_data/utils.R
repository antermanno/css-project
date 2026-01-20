#' load the last years raw data.tables
load_all_data_tables <- function(){
  camera22 <<- data.table::fread("data/camera-20220925/Camera_Italia_LivComune.csv")
  senato22 <<- data.table::fread("data/senato-20220925/Senato_Italia_LivComune.csv")

  camera18 <<- data.table::fread("data/camera-20180304/Camera2018_livComune.txt")
  senato18 <<- data.table::fread("data/senato-20180304/Senato2018_livComune.txt")

  camera13 <<- data.table::fread("data/camera-20130224/camera_italia-20130224.txt")
  senato13 <<- data.table::fread("data/senato-20130224/senato_italia-20130224.txt")

  camera08 <<- data.table::fread("data/camera-20080413/camera_italia-20080413.txt")
  senato08 <<- data.table::fread("data/senato-20080413/senato_italia-20080413.txt")
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

camera18 <<- camera18[REGION != "AOSTA", ]
camera22 <<- camera22[ , `:=`(
  VOTANTI = VOTANTITOT,
  ELETTORITOT = ELETTORITOT,
  LISTA = DESCRLISTA,
  VOTI_LISTA = VOTILISTA
)]
}

filter_minor_parties <- function(partylist){
  dplyr::case_match(
    partylist,
    c("LEGA PER SALVINI PREMIER", "LEGA", "LEGA NORD") ~ "LEGA",
    c("FORZA ITALIA", "IL POPOLO DELLA LIBERTA'") ~ "FORZA ITALIA",
    c("FRATELLI D'ITALIA", "FRATELLI D'ITALIA CON GIORGIA MELONI") ~ "FRATELLI D'ITALIA",
    c("PARTITO DEMOCRATICO", "PARTITO DEMOCRATICO - ITALIA DEMOCRATICA E PROGRESSISTA") ~ "PARTITO DEMOCRATICO",
    c("MOVIMENTO 5 STELLE", "MOVIMENTO 5 STELLE BEPPEGRILLO.IT") ~ "MOVIMENTO 5 STELLE",
    .default = "O"
  )
}

filter_right_wing_mainstream <- function(partylist){
  dplyr::case_match(
    partylist,
    c("LEGA", "FORZA ITALIA", "FRATELLI D'ITALIA") ~ "MAINSTREAM_RIGHT",
    .default = "O"
  )
}

filter_right_wing <- function(partylist){
  filter_right_wing_mainstream(filter_minor_parties(partylist))
}

# load data from the gtrends folder
load_gtrends_data <- function(){
  files = list.files(path = "data/gtrends/")
  files = sapply(files, function(x) paste0("data/gtrends/", x))
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

get_rcsr_by_region <- function(gtrend){
  gtrend_reg = copy(gtrend$racecharge_by_region.csv)
  setnames(gtrend_reg, c("Region", "RCSR_all_time"))
  gtrend_reg = gtrend_reg[, REG := toupper(Region)]
  gtrend_reg[, REGION := stringr::str_extract(REG, '\\w*' )]
  gtrend_reg = gtrend_reg[REGION != "VALLE", .(REGION, RCSR_all_time)]
  return(gtrend_reg)
}


# join the tables 2018
get_joint_voteshare_rcsr_tbl <- function(table, rcsr_tbl, list){
  data_cor = inner_join(table[LISTA == list,
                                 .(VOTI = sum(VOTI_LISTA)), by = REGION],
                        table[LISTA == list,
                                 .(VOTERS = sum(VOTANTI)), by = REGION],
                        by = "REGION")
  # print(data_cor)
  data_cor = inner_join(data_cor, rcsr_tbl, by = "REGION")
  data_cor[,.(REGION, VOTI, VOTERS, RCSR_all_time, LISTA = ..list)]
}




