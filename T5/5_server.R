
t5_server <- function(input, output, session) {
  data_wine <-read.csv("./wine.csv")
  # data_wine$Flavanoids
  observeEvent(input$do,{ 
    output$graf_simula<-renderPlotly({
    #X <- unname(unlist(data_wine[input$X]))
      X <- data_wine$TotalPhenols
    Y <- data_wine$Flavanoids
    matrice_jump  =0.01*matrix(c(2,0,0,0,1,0,0,0,1),nrow = 3,ncol=3,byrow = T)
    #res <-run_mcmc(10000,c(0,0,1),X,Y,matrice_jump,0,100,0,100,0.01,0.01)
    res <-run_mcmc(n_sim = input$nsim,
                   c(0,0,1),
                   X,#unname(unlist(data_wine[input$X])),#
                   Y,
                   matrice_jump,
                   input$mean_a0,
                   input$sd_a0,
                   input$mean_b0,
                   input$sd_b0,
                   input$shape0,
                   input$scale0)
    
    df <- data.frame(res)
    
    a <- mean(res[,1])
    b <- mean(res[,2])
    s <- mean(res[,3])
    x.max <- max(X)#unname(unlist(data_wine[input$X]))
    x.min <- min(X)#unname(unlist(data_wine[input$X]))
    x <- seq(x.min,x.max,length.out = nrow(data_wine))
    y <- b*x+a
    
    ##### FIT
    output$graf_FIT<-renderPlotly({
      #fit_seq <- seq(-5,10,length.out = input$nsim)
      plot_ly(x=X , y = Y, type = 'scatter', 
              name = 'Observaciones') %>% 
        layout(title = "Observaciones vs Ajuste") %>%
        add_lines(x=x, y=y , name = 'Ajuste',mode = 'lines')
      })

    ### SIMUL PARAMETROS
    p1<-plot_ly(x= res[,1],type = "histogram", name = "alpha")
    p2<-plot_ly(x= res[,2],type = "histogram", name = "beta") 
    p3<-plot_ly(x= res[,3],type = "histogram", name = "sigmma2") 
    subplot(p1,p2,p3, nrows=3) %>% layout(title = "Simulaciones")
    })#plot
  })#event
  
  
  #################### APRIORI S ########################################3
    output$graf_apriori<-renderPlotly({
      
      a_seq <- seq(-10,10,0.5)
      sig_seq <- seq(-10,10,0.5)
      a_apriori <- exp(sapply(a_seq,logapriori_a,input$mean_a0,input$sd_a0))#
      b_apriori <- exp(sapply(a_seq,logapriori_b,input$mean_b0,input$sd_b0))#
      sig_apriori <- exp(sapply(a_seq,logapriori_sigma2,input$shape0,input$scale0))#
      p1 <- plot_ly(x=a_seq,y=a_apriori,name = "alpha")  
      p2 <- plot_ly(x=a_seq,y=b_apriori,name = "beta") 
      p3 <- plot_ly(x=sig_seq,y=sig_apriori,name = "sigmma2")  
      subplot(p1,p2,p3,nrows = 3)%>% layout(title = "Aprioris")
    })
  
  #######################################################################  

}
