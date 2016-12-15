library(shiny)
library(ggplot2)
library(plotly)

shinyUI(fluidPage(#theme = "bootstrap.css",
  
  tabsetPanel(
    selected="5-MCMC RegLin",type="pills",
    
    tabPanel("1-F_Inv", T1_ui("T1"))
    ,
    tabPanel("2-MC Integra", T2_ui("T2"))
    ,
    tabPanel("4-Interface", T4_ui("T4"))
    ,
    tabPanel("5-MCMC RegLin", T5_ui("T5"))
  )
  
  )
)