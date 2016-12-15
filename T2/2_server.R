t2_server <- function(input, output, session) {

###### Funciones
  
  # Captura usuario
  fun3.1 <- reactive({
    texto <- paste("aux <- ", "function(x) ", input$expresion3.1)
    eval(parse(text=texto))
    aux
  })
  # Crea unifomres
  u3.1 <- reactive({
    runif(n = input$nsim, min = input$minGraf3, max = input$maxGraf3)
    })
  # Integra Montecarlo
  montecarlo<-reactive({
    (input$maxGraf3-input$minGraf3)*
      mean(sapply(u3.1(), fun3.1()))
  })
# sigma Intervalo
  sigma<-reactive({
    sqrt(
      sum((u3.1()- montecarlo())^2)/(input$nsim-1)
    )
  })
  z_2<-reactive({qnorm(p = 1-((input$alpha)/2),mean = 0, sd = 1)})
  diff<-reactive({z_2()*sigma()*(1/sqrt(input$nsim))})

  
# Integra Montecarlo (n.vector -> no reactivo)
  n_vector <-c(10,100,1000,10000,100000)
  
  mean_vector <-reactive({
  min = input$minGraf3
  max = input$maxGraf3
  u_vector <-sapply(n_vector,runif,min=min,max=max)
  fun_vector <-sapply(u_vector,fun3.1()) # lista de listas con tamaños 10,100,...
  integral_vector <- sapply(fun_vector,mean)*(max-min)
  sd_vector <- sapply(fun_vector,sd)
  integral_vector
  })
 
  ### sd multi-largo FUN
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
  
  ### sd multi-largo reactive
  mc_sd <-reactive({
    min = input$minGraf3
    max = input$maxGraf3
    u_vector <-sapply(n_vector,runif,min=min,max=max)
    fun_vector <-sapply(u_vector,fun3.1()) # lista de listas con tamaños 10,100,...
    integral_vector <- sapply(fun_vector,mean)*(max-min)
    sd<-sd_vect(integral_vector,fun_vector)
  })
  
  mc_quantile <-reactive({
    min = input$minGraf3
    max = input$maxGraf3
    u_vector <-sapply(n_vector,runif,min=min,max=max)
    fun_vector <-sapply(u_vector,fun3.1()) # lista de listas con tamaños 10,100,...
    integral_vector <- sapply(fun_vector,mean)*(max-min)
    quantil_vector <- sapply(fun_vector,quantile,1-input$alpha)
  })

#### Objetos
  
  # Grafica Input
 output$Grafica3.1 <- renderPlot({
    x3.1 <- seq(input$minGraf3, input$maxGraf3, length.out = input$nsim)
    y3.1 <- sapply(x3.1,fun3.1())
    plot(x3.1, y3.1, type="bar", col="blue", main="Integral")
    lines(x3.1, y3.1)
  })
  # Graf Montecarlo dado n
 output$Grafica_logn <- renderPlot({
   radio<-mc_quantile()*1/sqrt(n_vector)*mc_sd()
   max_y<-c( min(mean_vector()- radio), max(mean_vector() + radio) )
   
   plot(n_vector, mean_vector(), col="green", type="bar",
        main="Integral",log=c("x"),xlab = "número de simulaciones",
        ylab = "Valor de la integral",ylim =max_y)
   lines(n_vector,mean_vector() +radio)
   lines(n_vector,mean_vector() - radio)
 })
 
 
  # La integral vale:
  output$text3.1 <- renderText({
    #a<-mc_intervalo()
    c("La integral Monte Carlo para" ,input$expresion3.1," en el intervalo [ ",
      input$minGraf3,input$maxGraf3, "] es" , round(montecarlo(),2))
    })
  # output$text3.2 <- renderText({
  #   #a<-mc_intervalo()
  #   c("La integral Monte Carlo para" ,input$expresion3.1," en el intervalo [ ",
  #     input$minGraf3,input$maxGraf3, "] es" , unlist(mc_sd()) )
  # })
  # 
  
  # El intervalo de confianza es:
  # output$text3.2 <- renderText({
  #   c("Su intervalo de confianza es:["
  #     ,round(montecarlo()-diff(),2),", ", round(montecarlo()+diff(),2)
  #     ," ] con alfa = ", input$alpha)
  # })
}

