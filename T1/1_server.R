t1_server <- function(input, output, session) {

  U <- reactive({runif(nsim())})
  nsim <- reactive({input$nsim})
  lambda <- reactive({input$lambda})
 
compute_bins <- function(x, n) {
  list(start = min(x),end = max(x),size = (max(x) - min(x)) / (n))
}

output$graf <- renderPlotly({
  
  set.seed(input$seed)
  Exp_sim <- reactive({(-log(1-U())/lambda())})
  Exp_sys <- reactive({rexp(nsim(),rate=lambda()) })
  data_sim <- Exp_sim()
  data_sys <- Exp_sys()
  xbins <- compute_bins(data_sim, input$xbins)
  #plot
  p <-plot_ly(x = data_sim, type = "histogram", autobinx = F,
               xbins = xbins,alpha = 0.6, name = "Simulacion") %>%
  add_trace(x = data_sys, type = "histogram", autobinx = F,
            xbins = xbins,alpha = 0.6, name ="Sistemta")
})
 # input values
output$text <-renderPrint(paste('nsim:',input$nsim,
                                ' xbins:',input$xbins,
                                ' lambda:',input$lambda,
                                ' seed:',input$seed))
# ts-test
output$hypo <- renderText({
  set.seed(input$seed)
  Exp_sim <- reactive({(-log(1-U())/lambda())})
  Exp_sys <- reactive({rexp(nsim(),rate=lambda()) })
  data_sim <- Exp_sim()
  data_sys <- Exp_sys()
  lambda <- reactive({input$lambda})
  tst <- ks.test(data_sim,data_sys)
  if (tst["p.value"]<0.05){
    paste("Se rechaza hipotesis de igualdad de distribucion con un p-value de:"
          ,tst["p.value"])
  }
  else{
    paste("No se rechaza la hipotesis de igualdad con un p-value de:"
          ,tst["p.value"])
  }
})

}