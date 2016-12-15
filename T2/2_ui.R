T2_ui <- function(id){
  ns <- NS(id)
  tagList(
    h4("Integracion MonteCarlo Simple"),
    sidebarLayout(
      sidebarPanel(
        sliderInput(inputId = ns("nsim"), label = "Numero de sim", 
                    value = 100, min = 10, max = 100000),
        div(style = "display:inline-block",  
          numericInput(ns("minGraf3"), "xmin", 0),
          numericInput(ns("maxGraf3"), "xmax", 6.28),
        sliderInput(ns("alpha"),"alpha",min=0,max=1,value=0.05)
      )), #sidebar
 
        mainPanel(
          textInput(
            inputId = ns("expresion3.1"),
            label = "Funcion f(x)",
            value = "abs(sin(x))",#1/sqrt(2*pi)*exp(-1/2*x**2)"
            width = '80%'
          ),
          textOutput(ns("text3.1")),
          textOutput(ns("text3.2")),
          textOutput(ns("text3.3")),
          plotOutput(ns("Grafica_logn")),
          plotOutput(ns("Grafica3.1"))
          
          
        ) # Main     
    )# Layout
  
 
)}
