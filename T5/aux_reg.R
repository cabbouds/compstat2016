setwd("/home/camilo/0-MCD/3-Estad Com/")
Rcpp::sourceCpp("./T5/cpp_funs.cpp")
data_wine<-read.csv("T5/wine.csv")
#View(data_wine)
x <- data_wine$TotalPhenols
y <- data_wine$Flavanoids
n_data <- length(x)
plot(x,y)

x_seq <- seq(0,10,0.5)
a<- exp(sapply(x_seq,logapriori_sigma2,1,1))
plot(x_seq,a)

#logapriori test
x_seq <- seq(-10,10,0.5)
aux<-function(){}
a <- sapply(x_seq,logapriori,0,1,5,2,1,1)
plot(x_seq,a)

#liklyhood
x_seq <- seq(-10,10,0.5)
theta0 <- c(0,1,0,1,1,1)
a<- sapply(1,log_LH,x,y,theta0)
plot(x_seq,a)
length(x_seq)

x <- data_wine$TotalPhenols
y <- data_wine$Flavanoids
n_data <- length(x)
plot(x,y)

theta0 <- c(0,1,10) #
n_sim <- 100000
jump <- .05
post_sample <- run_mcmc(
  n_sim = n_sim,
  theta0 = theta0,
  X=x,
  Y=y,
  jump = jump,
  mean_a=0, sd_a=1, mean_b=0,sd_b=1, shape_sigma2=1, scale_sigma2=1
)

colMeans(post_sample)
lm(y ~ x, data = data_wine)
