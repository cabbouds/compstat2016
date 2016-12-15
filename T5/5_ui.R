#UTF-8
T5_ui <- function(id){
  ns <- NS(id)
  tagList(
    h4("Regresion Simple con MCMC"),
    sidebarLayout(
      sidebarPanel(width =3,
        
        div(style = "display:inline-block", width=3,
            sliderInput(inputId = ns("nsim"), label = "Numero de sim", 
                        value = 1000, min = 10, max = 100000,step = 10),
            sliderInput(ns("mean_a0"),"mean_a0",min=-20,max=20,value=0,step =1),
            sliderInput(ns("sd_a0"),"sd_a0",min=0,max=9,value=1,step =.5),
            sliderInput(ns("mean_b0"),"mean_b0",min=-20,max=20,value=0,step =1),
            sliderInput(ns("sd_b0"),"sd_b0",-0.0001,max=20,value=1,step =.5),
            sliderInput(ns("shape0"),"gamma_shape0",min=0.0001,max=20,value=1,step =.5),
            sliderInput(ns("scale0"),"gamma_scale0",min=0.0001,max=20,value=1,step =.5)
            ,
            selectInput(ns("Y"),"Y",
                                 label = "Variable Y:",
                                 choices = names(data_wine)),#,selected = "TotalPhenols"
            selectInput(ns("X"),"X",
                                 label = "Variable X:",
                                 choices = names(data_wine))#,selected = "Flavanoids"
            )#div
        )#sidebar
    , 
  ###########################################################################    
      mainPanel(
        textOutput(ns("text1")),
        tags$head(tags$script(src = "message-handler.js")),
        actionButton(ns("do"), "Click Me"),
        ##############################################################
        
        fluidRow(
          column(plotlyOutput(ns("graf_FIT")), width=12)
        ),
        fluidRow(
          column(plotlyOutput(ns("graf_apriori")), width=6),
          column(plotlyOutput(ns("graf_simula")), width=6)
        )
        
      ) # Main     
    )# Layout
    
  )}