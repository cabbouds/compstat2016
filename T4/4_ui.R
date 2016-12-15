#UTF-8

T4_ui <- function(id){
  ns <- NS(id)
  #data_wine <-read.csv("./wine.csv")
  tagList(
    h2("Visualizacion y seleccion de parametros"),
    sidebarLayout(
      sidebarPanel(
                   div(style = "display:inline-block", width=3,
                       sliderInput(ns("mean_a0"),"mean_a0",min=-20,max=20,value=0,step =1),
                       sliderInput(ns("sd_a0"),"sd_a0",min=0,max=9,value=1,step =.5),
                       sliderInput(ns("mean_b0"),"mean_b0",min=-20,max=20,value=0,step =1),
                       sliderInput(ns("sd_b0"),"sd_b0",-0.0001,max=20,value=1,step =.5),
                       sliderInput(ns("shape0"),"gamma_shape0",min=0.0001,max=20,value=1,step =.5),
                       sliderInput(ns("scale0"),"gamma_scale0",min=0.0001,max=20,value=1,step =.5)
                   
                   )),
        mainPanel(
          fluidRow(
            column(selectInput(ns("Y"),"Y",
                             label = "Variable Y:",
                             choices = names(data_wine)), width = 3),
            column(selectInput(ns("X"),"X",
                             label = "Variable X:",
                             choices = names(data_wine)), width = 3)
          ),
          fluidRow(
            column(plotOutput(ns("graf")), width = 10,height = '70%')
          ),
          
          fluidRow(
           
            column(plotlyOutput(ns("graf_a")), width=4,height = '33%'),
            column(plotlyOutput(ns("graf_b")), width=4,height = '33%'),
            column(plotlyOutput(ns("graf_sigma")), width=4,height = '33%')
            ,height = '33%'
            ),
          
          fluidRow(
            DT::dataTableOutput(ns("table")))
        ) # Main     
      )# Layout
  )}