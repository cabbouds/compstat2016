t4_server <- function(input, output, session) {
  # load
  X <- data_wine$TotalPhenols
  Y <- data_wine$Flavanoids
  global_mean_a0 <<-isolate(input$mean_a0)
  #global_sd_a0 <<- input$sd_a0
  #global_mean_b0 <<- input$mean_a0
  #global_sd_b0 <<- input$sd_a0
  
  #######################################################################  
  # tags$head(tags$script(src = "message-handler.js")),
  # actionButton("do", "Click Me")
  #########################################################
  output$table <- DT::renderDataTable(DT::datatable({
                  data_wine
                  }))
  
  output$graf <- renderPlot({
    ggplot(data_wine, aes(eval(parse(text=input$X)),
                          eval(parse(text=input$Y))
                          )
           ) + geom_point() + xlab(input$X) + ylab(input$Y)
  })
  
  ### Distribucion apriors
  output$graf_a<-renderPlotly({
    a_seq <- seq(-10,10,0.5)
    a_apriori<- exp(sapply(a_seq,logapriori_a,input$mean_a0,input$sd_a0))
    plot_ly(x=a_seq,y=a_apriori)  %>% layout(title = "alpha", aspectmode = 'cube')
  })
  output$graf_b<-renderPlotly({
    b_seq <- seq(-10,10,0.5)
    b_apriori<- exp(sapply(b_seq,logapriori_b,
                           input$mean_b0,input$sd_b0))
    plot_ly(x=b_seq,y=b_apriori) %>% layout(title = "beta", aspectmode = 'cube')
    })
    output$graf_sigma<-renderPlotly({
      g_seq <- seq(0,10,0.5)
      g_apriori<- exp(sapply(g_seq,logapriori_sigma2,input$shape0,input$scale0))
      plot_ly(x=g_seq,y=g_apriori) %>% layout(title = "sigma", aspectmode = 'cube')
    })
  
}