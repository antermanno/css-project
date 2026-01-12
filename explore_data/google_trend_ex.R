countries = data.frame(
  names = c("Aland", "Bland"),
  area = c(1, 2),
  percentage = c(.8, .4)
  )

countries$queries_tot = countries$area * countries$percentage
countries

# standardize to 100
range0100 <- function(x) (x-min(x))/(max(x)-min(x)) * 100


countries$range0100 = range0100(countries$percentage)
countries$rangegoo = countries$percentage / max(countries$percentage) * 100
countries
