rm(list = ls())
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

names(camera)
camera[, length(unique(COMUNE))]
camera[, length(unique(COLLUNINOM))]
# plot a map

#######################################
#############  Lab 1 ##################
#######################################
# install.packages
# install.packages
# install.packages()

library(tidyverse)
library(sf)
library(tmap)

# Load the map of italian provinces

map <- read_sf("../data/map-folder/map.shp")

class(map)
map

# mapping the boundaries of the italian provinces
# using the tmap library

tm_shape(map) +
  tm_borders()

# number of provinces in the map
n <- nrow(map)
n


# # read data on separate waste collection (swc)
# data <- read_csv2("data-folder/separateWC.csv")
# class(data)
# data
# 
# # merge the map with the data on swc
# swc <- left_join(map, data, by = "COD_PRO")
# class(swc)
# swc
# 
# # map of the propensity to swc in 2004
# tm_shape(swc) +
#   tm_polygons("Y04")
# 
# 
# # manage the color palette
# RColorBrewer::display.brewer.all()
# 
# # same map in 2009
# tm_shape(swc) +
#   tm_polygons("Y09", palette="Blues", style="quantile")
# 
# # compare the two maps
# tm_shape(swc) +
#   tm_polygons(c("Y04", "Y09"), palette="Blues", style="quantile")
# 
# # give the same legends to the two maps
# my_breaks <- quantile(
#   c(swc$Y04, swc$Y09)
# )
# 
# # compare the two maps again with the same legends
# tm_shape(swc) +
#   tm_polygons(c("Y04", "Y09"), palette="Blues", breaks=my_breaks)
# 
# 
# 
# #######################################
# #############  Lab 2 ##################
# #######################################
# 
# 
# # install.packages("spdep")
# library(spdep)
# 
# #  Construct the Adjacency Matrix W
# # step 1 - create the nb object
# map_nblist <- poly2nb(map)
# str(map_nblist)
# 
# #step 2 - create the W list
# Wlist <- nb2listw(map_nblist, style="B")
# str(Wlist)
# Wlist 
# 
# # step 3 - create the W matrix (manually)
# W <- matrix(0, nrow=n, ncol=n)
# for(i in 1:n){
#   W[i, Wlist$neighbours[[i]]] <- Wlist$weights[[i]]
# }
# W
# rowSums(W) 
# 
# # step 4 - row standardized matrix
# Wlist_til <- nb2listw(map_nblist, style="W")
# W_til <- matrix(0, n, n)
# 
# for(i in 1:n){
#   W_til[i, Wlist_til$neighbours[[i]]] <- Wlist_til$weights[[i]]
# }
# W_til
# 
# # Moran's I 
# # Using its expression in matrix form
# y <- swc$Y04
# 
# # Centering the variable
# y <- y - mean(y)
# 
# # Moran's I
# I <- (t(y) %*% W_til %*% y) / (t(y) %*% y)
# I
# 
# # Computation of Moran's I using the spdep library
# moran(y, Wlist_til, n = n, S0 = n)
# 
# # Spatial lag: computing Moran's I
# y_til <- W_til %*% y
# 
# (t(y) %*% y_til) / (t(y) %*% y)  # should be equal to Moran's I
# 
# # Moran's I as a regression coefficient
# lm(y_til ~ y) %>% summary() # should be equal to Moran's I
# 
# # Moran scatterplot
# plot(y, y_til, xlab="y", ylab="W*y")
# abline(h=0, v=0, col="gray", lty = 2)
# abline(a = 0, b = I, col="red", lwd = 2)
# 
# var(y)
# var(y_til)
# 
# # Spatial smoothing scalar
# sd(y_til) / sd(y)
# 
# # SIMULATION of data that do not show spatial autocorrelation
# ysim <- rnorm(n, mean = 0, sd = 1)
# (t(ysim) %*% W_til %*% ysim) / (t(ysim) %*% ysim)
# 
# I_sim <- numeric(10000)
# 
# for(i in 1:10000){
#   ysim <- rnorm(n, mean = 0, sd = 1)
#   I_sim[i] <- (t(ysim) %*% W_til %*% ysim) / (t(ysim) %*% ysim)
# }
# I_sim
# hist(I_sim, breaks=50, col="gray", xlab="Moran's I", main="Simulation of Moran's I")
# 
# # Spatial lag of the simulated data
# ysim_til <- W_til %*% ysim
# 
# # Moran scatterplot
# plot(ysim, ysim_til, xlab="y", ylab="W*y")
# abline(h=0, v=0, col="gray", lty = 2)
# 
# # Spatial smoothing scalar
# sd(ysim_til) / sd(ysim)
# 
# 
# 
# 
# 
# y<- swc$Y04
# 
# # TEST 1 - Normality assumption on Y and Gaussian approximation 
# # to the distribution of standardised Moran's I
# 
# moran.test(y, Wlist_til,
#            randomisation = FALSE, 
#            alternative = "greater")
# 
# # TEST 2 -  Gaussian approximation 
# # to the distribution of standardised Moran's I
# 
# moran.test(y, Wlist_til,
#            randomisation = TRUE, 
#            alternative = "greater")
# 
# # TEST 3 - No assumptions (better than the previous ones)
# 
# moran.mc(y, Wlist_til,
#          alternative = "greater",
#          nsim = 10000)
# 
# out_mc <- moran.mc(y, Wlist_til,
#                    alternative = "greater",
#                    nsim = 10000)
# 
# length(out_mc$res)
# hist(out_mc$res, breaks= 50)
# abline(v= out_mc$statistic, lwd=2, col=4)
# 
# # See what happens when there is no spatial autocorrelation
# # i.e. simulation from an iid process
# y <- rnorm(n)
# 
# out_mc <- moran.mc(y, Wlist_til,
#                    alternative = "greater",
#                    nsim = 10000)
# 
# length(out_mc$res)
# hist(out_mc$res, breaks= 50)
# abline(v= out_mc$statistic, lwd=2, col=4)
# 
# # hint for building an MC permutation test
# x <- c(10, 5, 100, 20)
# sample(x, 4, replace = FALSE)
# 
# 
# # install.packages("mvtnorm")
# library(mvtnorm)
# # install.packages("spatialreg")
# library(tidyverse)
# library(sf)
# library(tmap)
# library(spdep)
# library(spatialreg)
# 
# 
# #simulation from the SAR model
# I_n <- diag(n)
# rho <- 0.9 #we fix the rho and see what happens
# 
# # Covariance matrix of the SAR model
# Sigma_SAR <- solve(
#   t(I_n -rho*W_til) %*% (I_n -rho*W_til)
# )
# 
# # sample from the multivariate normal distribution
# y <- c(rmvnorm(1, mean = rep(0,n), sigma=Sigma_SAR))
# dim(y)  
# 
# #center y
# y <- y-mean(y)
# 
# map$y <- y  
# 
# tm_shape(map)+
#   tm_polygons("y")
# 
# y<- as.vector(y)
# I <- (t(y)%% W_til%% y) / (t(y)%*%y)
# O <- (t(y)%% W_til%% y) / (t(y)%% t(W_til) %% W_til %*%y)
# APLE <- aple(y, Wlist_til)
# 
# c(I,O, APLE)
# 
# #samples from the sampling distribution of I,O and APLE
# #number of samples
# n_sim <- 500
# 
# #objects for storage
# I_sim <- rep(NA, n_sim)
# O_sim <- rep(NA, n_sim)
# APLE_sim <- rep(NA, n_sim)
# 
# for (k in 1:n_sim) {
#   y <- c(rmvnorm(1, mean = rep(0,n), sigma=Sigma_SAR))
#   y <- y-mean(y)
#   I <- (t(y)%% W_til%% y) / (t(y)%*%y)
#   O <- (t(y)%% W_til%% y) / (t(y)%% t(W_til) %% W_til %*%y)
#   APLE <- aple(y, Wlist_til)
#   
#   #storage
#   I_sim[k] <- I
#   O_sim[k] <- O
#   APLE_sim[k] <- APLE
# }
# 
# E_I_sim <- mean(I_sim)
# E_O_sim <- mean(O_sim)
# E_APLE_sim <- mean(APLE_sim)
# 
# V_I_sim <- var(I_sim)
# V_O_sim <- var(O_sim)
# V_APLE_sim <- var(APLE_sim)
# 
# MSE_I_sim <- V_I_sim + (E_I_sim - rho)^2
# MSE_O_sim <- V_O_sim + (E_O_sim - rho)^2
# MSE_APLE_sim <- V_APLE_sim + (E_APLE_sim - rho)^2
# 
# MSE_APLE_sim #smallest so we prefer this
# MSE_I_sim #moran's I is better in the neighbourhood of 0
# MSE_O_sim
# 
# hist(APLE_sim, breaks = 25)
# 
