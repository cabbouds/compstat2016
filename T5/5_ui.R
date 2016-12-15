#UTF-8
T5_ui <- function(id){
  ns <- NS(id)
  tagList(
    h4("Regresion Simple con MCMC"),
    sidebarLayout(
      sidebarPanel(width =3,
        
        div(style = "display:inline-block", width=3,
            sliderInput(inputId = ns("nsim"), label = "Numero de sim", 
                        value = 100, min = 10, max = 100000,step = 10),
            sliderInput(ns("mean_a0"),"mean_a0",min=-20,max=20,value=0,step =1),
            sliderInput(ns("sd_a0"),"sd_a0",min=0,max=9,value=1,step =.5),
            sliderInput(ns("mean_b0"),"mean_b0",min=-20,max=20,value=0,step =1),
            sliderInput(ns("sd_b0"),"sd_b0",-0.0001,max=20,value=1,step =.5),
            sliderInput(ns("shape0"),"gamma_shape0",min=0.0001,max=20,value=1,step =.5),
            sliderInput(ns("scale0"),"gamma_scale0",min=0.0001,max=20,value=1,step =.5)
        )
    ), #sidebar
      
      mainPanel(
        textOutput(ns("text1")),
        fluidRow(
          column(DT::dataTableOutput(ns("table")),width = 12)
        )
        , #)
        ##############################################################
        
        fluidRow(
          column(5,plotlyOutput(ns("graf_load"), width="300px",height="200px")),
          column(5,plotlyOutput(ns("graf_sigma"), width="300px",height="200px"))
        ),
        fluidRow(
          column(5,plotlyOutput(ns("graf_a"), width="300px",height="200px")),
          column(5,plotlyOutput(ns("graf_b"), width="300px",height="200px"))
        )
        ,
        fluidRow(
          column(plotlyOutput(ns("graf_AP")), width=10,height="200px")
        )
      ) # Main     
    )# Layout
    
  )}