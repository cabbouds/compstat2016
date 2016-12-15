
t5_server <- function(input, output, session) {
  # load
  #Rcpp::sourceCpp("T5/cpp_funs.cpp")
  #data_wine <-read.csv("./T5/wine.csv")
  X <- data_wine$TotalPhenols
  Y <- data_wine$Flavanoids
  # 
  observeEvent(input$do,{ 
    output$graf_b<-renderPlotly({
    
    matrice_jump  =0.01*matrix(c(2,0,0,0,1,0,0,0,1),nrow = 3,ncol=3,byrow = T)
    res <-run_mcmc(10000,c(0,0,1),X,Y,matrice_jump,0,100,0,100,0.01,0.01)
    df <- data.frame(res)
    
    a <- mean(res[,1])
    b <- mean(res[,2])
    s <- mean(res[,3])
    x.max <- max(unname(unlist(data_wine[input$X])))
    x.min <- min(unname(unlist(data_wine[input$X])))
    x <- seq(x.min,x.max,length.out = 100)
    y <- b*x+a
    # par(mfrow=c(3,3))
    #hist(res[,1])
    plot_ly(x= res[,1],type = "histogram", name="Alfa sim")#x = seq(1,nrow(df),by=1), 
    
    })#plot
  })#event
  
    # res <<- run_mcmc(n_sim=10^input$nsim,
    #                  theta0 = c(0,0,1),
    #                  X=unname(unlist(data_wine[input$X])),
    #                  Y=unname(unlist(data_wine[input$Y])),
    #                  matrice_jump,
    #                  #jump=0.05,
    #                  mean_a = input$mean_a0,
    #                  sd_a = input$sd_a0,
    #                  mean_b = input$mean_b0,
    #                  sd_b = input$sd_b0,
    #                  shape_sigma2 = input$shape0,
    #                  scale_sigma2 = input$scale0)
    
    #return(pairs(res, labels = c("Alpha","Betha","Sigma")))

    output$graf_a<-renderPlotly({
      # matrice_jump  =0.01*matrix(c(2,0,0,0,1,0,0,0,1),nrow = 3,ncol=3,byrow = T)
      # res <<-  run_mcmc(10000,c(0,0,1),X,Y,matrice_jump,0,100,0,100,0.01,0.01)
      
      a_seq <- seq(-10,10,0.5)
      a_apriori <- exp(sapply(a_seq,logapriori_a,input$mean_a0,input$sd_a0))#
      plot_ly(x=a_seq,y=a_apriori)  %>% layout(title = "alpha", aspectmode = 'cube')
    })
    #hist(rnorm(100))
  
  
  #######################################################################  

  # graf_load
  # output$graf_load<-renderPlotly({
  #   plot_ly(x=x,y=y,color = "grey") %>% layout(title = "alpha")
  #   })
  # 
  # # graf_sigma_apriori
  # output$graf_sigma<-renderPlotly({
  # g_seq <- seq(0,10,0.5)
  # g_apriori<- exp(sapply(g_seq,logapriori_sigma2,input$shape0,input$scale0))
  # plot_ly(x=g_seq,y=g_apriori, title= "testing")
  # })
  # 
  # output$graf_a<-renderPlotly({
  #   a_seq <- seq(-10,10,0.5)
  #   aux_a <- isolate(global_mean_a0)
  #   a_apriori<- exp(sapply(a_seq,logapriori_a,aux_a,input$sd_a0))#input$mean_a0
  #   plot_ly(x=a_seq,y=a_apriori)  %>% layout(title = "alpha", aspectmode = 'cube')
  # })
  # 
  # output$graf_b<-renderPlotly({
  #   b_seq <- seq(-10,10,0.5)
  #   b_apriori<- exp(sapply(b_seq,logapriori_b,
  #                          input$mean_b0,input$sd_b0))
  #   plot_ly(x=b_seq,y=b_apriori)
  # })
  # 
  # output$graf_AP<-renderPlotly({
  #   AP_theta <- seq(-10,10,0.5)
  #   AP<- exp(sapply(AP_theta,log_AP,
  #                   input$mean_a0,input$sd_a0,
  #                   input$mean_b0,input$sd_b0,
  #                   input$shape0,input$scale0))
  #   plot_ly(x=AP_theta,y=AP)
  # })
  # 
  # output$graf_LA<-renderPlotly({
  #   AP_seq <- seq(-10,10,0.5)
  #   AP<- exp(sapply(AP_seq,log_AP,
  #                   input$mean_a0,input$sd_a0,
  #                   input$mean_b0,input$sd_b0,
  #                   input$shape0,input$scale0))
  #   plot_ly(x=AP_seq,y=AP)
  # })
  # 
  # #test
  # output$text1 <- renderText({global_mean_a0})
  
}
