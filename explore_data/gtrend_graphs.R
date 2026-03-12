rm(list = ls())
source("explore_data/utils.R")
library(data.table)
library(ggplot2)
gtrend = load_gtrends_data(markdown = F)

rcsr_over_time = gtrend$racecharge_over_time_italy.csv

rcsr_over_time = rcsr_over_time[, .(month = paste0(Mese, "-01"), RCSR = `negro: (Italia)`)]
rcsr_over_time = rcsr_over_time[, .(date = as.Date(month) , RCSR)]

rcsr_over_time |>
  ggplot(aes(x = date, y = RCSR))+
  geom_line(linewidth = 0.7, alpha = 0.7)+
  theme_bw()+
  ylim(c(0,100))

redacted = gtrend$common_word_comparison_2014_2022.csv[, .(WORD1 = negro,
                                                           cartello, miniera, mistero,
                                                           Time)]
word_comparison = melt(redacted,
                        id.vars = "Time",
                       variable.name = "word", value.name = "RCSR")
# compare WORD1 to common words, to get an idea of usage
word_comparison |>
  ggplot(aes(x = Time, y = RCSR))+
  geom_line(aes(colour  = word, linetype = word),
            linewidth = 1.2)+
  theme_bw()

#compare WORD1 to immigrati
redacted1 = gtrend$immigrati_n_2014_2022.csv[, .(WORD1 = negro, immigrati,
                                                 Time)]
word_comparison_word1_immigrati = melt(redacted1,
                        id.vars = "Time",
                       variable.name = "word", value.name = "RCSR")


word_comparison_word1_immigrati |>
  ggplot(aes(x = Time, y = RCSR))+
  geom_line(aes(colour  = word, linetype = word),
            linewidth = 1.2)+
  theme_bw()
