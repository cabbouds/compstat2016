T1_ui <- function(id){
  ns <- NS(id)
  tagList(
    h4("Genera numero pseud-oaleatorios de la F.Exp con metodo de la funcion inversa"),
    
    sidebarLayout(
      sidebarPanel(
        sliderInput(ns("xbins"), "No.de bins", 
                    min = 1, max = 50, value = 20),
        sliderInput(inputId = ns("nsim"), 
                    label = "Numero de sim", 
                    value = 1000, min = 10, max = 10000),
        sliderInput(inputId = ns("lambda"), 
                    label = "Elije lambda", 
                    value = 1, min = 0.01, max = 25),
        sliderInput(ns("seed"), "Semilla", 
                    min = 1, max = 50000, value = 12345)
      ),
      mainPanel(
        h4("Simulacion vs. Sistema de la Funcion Exponencial"),
        plotlyOutput(ns('graf')),
        verbatimTextOutput(ns('text')),
        helpText("Suponiendo un umbral de 0.05 para el p-value, se concluye:")
        ,verbatimTextOutput(ns("hypo"))
      )
    )

  )}
