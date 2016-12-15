#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]

double logapriori_b(double b, double mean_b,double sd_b){
  // Se llama a R y usa rnorm con parámetro 1 (log)
  return R::dnorm(b,mean_b,sd_b,1);
}

// [[Rcpp::export]]
double logapriori_a(double a, double mean_a,double sd_a){
  // Se llama a R y usa rnorm con parámetro 1 (log)
  return R::dnorm(a,mean_a,sd_a,1);
}

// [[Rcpp::export]]
double logapriori_sigma2(double sigma2, double shape_sigma2,double scale_sigma2){
  // apriori sigma2
  return R::dgamma(sigma2,shape_sigma2,scale_sigma2,1);
}

// [[Rcpp::export]]
double logapriori(NumericVector theta,
                  double mean_a,
                  double sd_a,
                  double mean_b,
                  double sd_b,
                  double shape_sigma2,
                  double scale_sigma2
)
{ double a = theta[0];
  double b = theta[1];
  double sigma2 = theta[2];
  
  return logapriori_a(a,mean_a,sd_a) 
    + logapriori_b(b, mean_b, sd_b) 
    + logapriori_sigma2(sigma2, shape_sigma2, scale_sigma2);
}


// [[Rcpp::export]]
double loglikehood(NumericVector theta ,NumericVector X,NumericVector Y, int n_datos)
{
  NumericVector error2(n_datos);
  double pi = 3.1416;
  for (int i=0; i < n_datos; i++)
  {
    error2[i]=pow((Y[i]-theta[1]*X[i]+theta[0]),2);
  }
  
  return log(pow(2*pi*theta[2],n_datos/2)*exp(-(1/2*theta[2])*sum(error2)));
}

  