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

set_region_column <- function(){

camera22[, REGION := stringr::str_extract(`CIRC-REG`, '\\w*')]
camera18[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]
camera13[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]
camera08[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]

camera18 <<- camera18[REGION != "AOSTA", ]
}

# load data from the gtrends folder
load_gtrends_data <- function(){
  files = list.files(path = "data/gtrends/")
  files = sapply(files, function(x) paste0("data/gtrends/", x))
  lapply((files), data.table::fread)
}

#' get turnout from a dataset
get_turnout_by <- function(DT){
  copy <- DT
  copy[, REGION := stringr::str_extract(CIRCOSCRIZIONE, '\\w*')]
  copy = copy[,.(COMUNE, ELETTORI, VOTANTI, REGION)]
  copy = copy[!duplicated(copy),]
  copy = copy[, .(TOTEL = sum(ELETTORI), TOTVOT = sum(VOTANTI)), by = REGION]
  copy = copy[, TURNOUT := TOTVOT/TOTEL]
  gtrends_data <<- copy
  return(copy)

}














