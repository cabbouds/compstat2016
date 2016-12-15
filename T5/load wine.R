setwd("./RegMCMC")
data_wine<-read.csv("wine.csv")

Y <- data_wine[2]#"Flavanoids"
X <- data_wine[14]#"ColorIntensity"
plot(X[,1],Y[,1])


install.packages("corrplot")
library("corrplot")

corrplot(data_wine, method="circle")
unlist(data_wine)
View(data_wine)


NumericMatrix cov_cpp(NumericMatix X){
  return wrap(arma::cov(as<arma::mat>(X)));
}

double logapriori_b(double b, double m)


