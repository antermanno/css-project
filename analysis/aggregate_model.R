rm(list = ls())
source("R/utils.R")
library(data.table)
library(ggplot2)
library(dplyr)

load_all_data_tables(markdown = F)
gtrend = load_gtrends_data(markdown = F)

set_region_column_camera()
set_region_column_senato()

RCSR_2022 = get_rcsr_by_region(gtrend, year = 2022)
RCSR_2018 = get_rcsr_by_region(gtrend, year = 2018)
RCSR_2013 = get_rcsr_by_region(gtrend, year = 2013)

data_for_reg = as.data.frame(get_final_dataset_by_party())

fit_agg = lm(delta2218 ~ RCSR_2022 + delta_turn2218, data_for_reg )
summary(fit_agg)
# plot(fit_agg)

# looking at the diagnostic plots, we can see that observations
# 4 and 17 have high cook's distance, that means they have
# a lot of influence on the final regression. Let's try to exclude
# them from the regression

data_for_reg[c(4, 17),]
fit_no_leverage = lm(delta2218 ~ RCSR_2022 + delta_turn2218,
                     data_for_reg[-c(4, 17),] )
summary(fit_no_leverage)
# plot(fit_no_leverage)

# polynomial turnout no removal of outliers
fit_poly = lm(delta2218 ~ RCSR_2022 + poly(delta_turn2218, 2, raw = T),
                     data_for_reg[,] )
summary(fit_poly)
# plot(fit_no_leverage)


# polynomial turnout no removal of outliers (campania,)
fit_poly_no_leverage = lm(delta2218 ~ RCSR_2022 + poly(delta_turn2218, 2, raw = T),
                     data_for_reg[-c(4, 17),] )
summary(fit_poly_no_leverage )
plot(fit_poly_no_leverage)

anova(fit_agg, fit_poly)
AIC(fit_agg, fit_poly)
AIC(fit_no_leverage, fit_poly_no_leverage)
anova(fit_no_leverage, fit_poly_no_leverage)
AIC(fit_no_leverage, fit_poly_no_leverage)

# Regressing on the quadratic of the delta in turnout, doesn't
# improve model performance of the models significantly.

rcsr_Coeff = sapply(list(fit_agg, fit_no_leverage,
            fit_poly, fit_poly_no_leverage),
       function(mod){mod$coefficients[["RCSR_2022"]]})

rcsr_Coeff < 0

# All the coefficients are less than zero. No evidence of a postive effect on
# change in vote share of the right wing coalition between 2018 and 2022
# irregarding of outlier and non linear term adaptations.








