
t5_server <- function(input, output, session) {
  # load
  #Rcpp::sourceCpp("T5/cpp_funs.cpp")
  #data_wine <-read.csv("./T5/wine.csv")
  x <- data_wine$TotalPhenols
  y <- data_wine$Flavanoids
  
  #######################################################################  
  tags$head(tags$script(src = "message-handler.js")),
  actionButton("do", "Click Me")
  #########################################################
 
 ####################################################################### 
  
  # graf_load
  output$graf_load<-renderPlotly({
    plot_ly(x=x,y=y,color = "grey", title= "testing")
    })
  
  # graf_sigma_apriori
  output$graf_sigma<-renderPlotly({
  g_seq <- seq(0,10,0.5)
  g_apriori<- exp(sapply(g_seq,logapriori_sigma2,input$shape0,input$scale0))
  plot_ly(x=g_seq,y=g_apriori, title= "testing")
  })
 
  output$graf_a<-renderPlotly({
    a_seq <- seq(-10,10,0.5)
    aux_a <- isolate(global_mean_a0)
    a_apriori<- exp(sapply(a_seq,logapriori_a,aux_a,input$sd_a0))#input$mean_a0
    plot_ly(x=a_seq,y=a_apriori)  %>% layout(title = "alpha", aspectmode = 'cube')
  })
  
  output$graf_b<-renderPlotly({
    b_seq <- seq(-10,10,0.5)
    b_apriori<- exp(sapply(b_seq,logapriori_b,
                           input$mean_b0,input$sd_b0))
    plot_ly(x=b_seq,y=b_apriori)
  })
  
  output$graf_AP<-renderPlotly({
    AP_theta <- seq(-10,10,0.5)
    AP<- exp(sapply(AP_theta,log_AP,
                    input$mean_a0,input$sd_a0,
                    input$mean_b0,input$sd_b0,
                    input$shape0,input$scale0))
    plot_ly(x=AP_theta,y=AP)
  })

  output$graf_LA<-renderPlotly({
    AP_seq <- seq(-10,10,0.5)
    AP<- exp(sapply(AP_seq,log_AP,
                    input$mean_a0,input$sd_a0,
                    input$mean_b0,input$sd_b0,
                    input$shape0,input$scale0))
    plot_ly(x=AP_seq,y=AP)
  })
  
  #test
  output$text1 <- renderText({global_mean_a0})
  
}
