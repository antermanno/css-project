rm(list = ls())
source("R/utils.R")
library(data.table)
library(ggplot2)
library(dplyr)
library(sf)

# let's build some maps
load_all_data_tables(markdown = FALSE)
gtrend = load_gtrends_data(markdown = FALSE)

set_region_column_camera()
set_region_column_senato()


map_region = as.data.table(read_sf("data/Limiti01012022_g/Limiti01012022_g/Reg01012022_g/Reg01012022_g_WGS84.shp"))
map_region[, REGION := stringr::str_extract(toupper(DEN_REG), '\\w*' )]
turn_data = get_turnout_over_years()
rcsr_data = get_rcsr_by_region(gtrend, 2022)

data_map = left_join(map_region, turn_data, by = "REGION")
data_map = left_join(data_map, rcsr_data, by = "REGION")

final = get_final_dataset_by_party(party = "MAINSTREAM_RIGHT")
# final = get_final_dataset_by_party(party = "PARTITO_DEMOCRATICO")
data_map = left_join(data_map, final, by = "REGION")

rcsr_by_year = data_map[,.(geometry, REGION)]
RCSR_2022 = get_rcsr_by_region(gtrend, 2022)
RCSR_2018 = get_rcsr_by_region(gtrend, 2018)
RCSR_2013 = get_rcsr_by_region(gtrend, 2013)

data = inner_join(rcsr_by_year, RCSR_2013, by = "REGION")
data = inner_join(data, RCSR_2018, by = "REGION")
data = inner_join(data, RCSR_2022, by = "REGION")

data_rscr_map = melt(data[,.(geometry, REGION, `2013` = RCSR_2013,
                             `2018` = RCSR_2018,
                             `2022` = RCSR_2022)],
                     id.vars = 1:2,
                     variable.name = "Year",
                     value.name = "RCSR")
data_rscr_map |>
  ggplot()+
  geom_sf(aes(geometry = geometry, fill = RCSR))+
  theme_minimal()+
  scale_fill_gradient(low = "#f7f7f7", high =  "#a50f15")+
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()
        )+
  labs(title = "Racially Charged Search Rate over Time")+
  facet_wrap(.~Year)


map_by_year = melt(data_map[,.(geometry, REGION, `2013` = TURN13,
                               `2018` = TURN18,`2022` = TURN22)],
                        id.vars = 1:2,
                       variable.name = "Year", value.name = "Turnout")
map_by_year |>
  ggplot()+
  geom_sf(aes(geometry = geometry, fill = Turnout))+
  theme_minimal()+
  scale_fill_gradient(low = "#a50", high =  "white")+
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()
        )+
  labs(title = "Regional Turnout by Year")+
  facet_wrap(.~Year)



data_map |>
  ggplot()+
  geom_sf(aes(geometry = geometry, fill = TURN22))+
  theme_minimal()+
  theme(legend.title = element_text("2022 Election Regional Turnout"))

data_map[]|>
  ggplot()+
  geom_sf(aes(geometry = geometry, fill = delta_turn2218))+
  scale_fill_gradient(low = "#a50f15" , high = "#f7f7f7")+
  theme_classic()+
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

#ffeda0
#feb24c
#f03b20::

#f1a340
#f7f7f7
#998ec3
data_map[]|>
  ggplot()+
  geom_sf(aes(geometry = geometry, fill = delta2218))+
  scale_fill_gradient2(low = "#998ec3" , mid = "#f7f7f7", high = "#f1a340")+
  theme_classic()+
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())
