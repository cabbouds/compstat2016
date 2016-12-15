setwd("/home/camilo/0-MCD/3-Estad Com/compstat2016/T5")
library(Rcpp)
Rcpp::sourceCpp("cpp_funs_matrix.cpp")
data<-read.csv("wine.csv")

X=data$Flavanoids
y=data$TotalPhenols
Y=data$TotalPhenols

matrice_jump=0.01*matrix(c(2,0,0,0,1,0,0,0,1),nrow = 3,ncol=3,byrow = T)

camilo_sample=run_mcmc(10000,c(0,0,1),X,Y,matrice_jump,0,100,0,100,0.01,0.01)

mean(camilo_sample[,1])
mean(camilo_sample[,2])
mean(camilo_sample[,3])

#mira esta bueno los resultados normalmente va a foncionar con tus input$ 
