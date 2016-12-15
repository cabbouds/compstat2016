
n=20
n_vector <-c(2,5,10)
mi_fun<-sapply(n_vector,rnorm,mean = 0,sd = 1)
sd <-sapply(mi_fun,sd)
quantile<-sapply(mi_fun,quantile,probs= .95)
#########################
n_vector <-c(2,5,10)
mi_fun1<-function(n_vector){
  sapply(n_vector,rnorm,mean = 1,sd = 2)
}
mi_fun2<-function(n_vector){
  sapply(n_vector,rnorm,mean = 0,sd = 1)
}

mi_fun1_val<-mi_fun1(n_vector)
mi_fun2_val<-mi_fun2(n_vector)
mi_fun1_val[[3]]-mi_fun2_val[[3]]
#########################################

mi_resta <- function(mi_fun1_val,mi_fun2_val){
acum=0
for(i in 1:length(mi_fun1_val)){
    acum<-c(acum,list(mi_fun1_val[[i]]-mi_fun2_val[[i]]))
}  
return(acum)
}
mi_resta(mi_fun1_val,mi_fun2_val)


################################

  i=3

  sd_vect <- function(mi_fun1_val,mi_fun2_val){
    acum=0
    for(i in 1:length(mi_fun1_val)){
      new<-sum((mi_fun1_val[[i]]-mi_fun2_val[[i]])**2)/length(mi_fun1_val[[i]])
      acum<-c(acum,new)
    }  
    return(acum[-1])
  }

  sd_vect(mi_fun1_val,mi_fun2_val)
i=2
j=3
  sd_vect <- function(mi_fun1_val,mi_fun2_val){
    acum=0
    for(i in 1:length(mi_fun1_val)){
      for (j in 1:length(mi_fun1_val[[i]])){
        new_j <-sum((mi_fun1_val[[i]][j]-mi_fun2_val[[i]][j])**2)
      }
      new_i<-sqrt(sum(new_j)/length(mi_fun1_val[[i]]))
      acum<-c(acum,new_i)
    }  
    return(acum[-1])
  }
  
  
  
  ########################################  
  n_vector <-c(2,5,10)
  mi_fun1_val<-mi_fun1(n_vector)
  mi_fun2_val<-mi_fun2(n_vector)
  mi_fun1_val[[3]]-mi_fun2_val[[3]]
    
  min = 1
  max = 3
  u_vector <-sapply(n_vector,runif,min=min,max=max)
  fun_vector <-sapply(u_vector,log) # lista de listas con tamaños 10,100,...
  integral_vector <- sapply(fun_vector,mean)*(max-min)
  sd <-sd_vect(fun_vector,integral_vector) 
  sd

