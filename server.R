
library(shiny)

shinyServer(function(input, output, session) {

  callModule(t1_server,"T1")
  callModule(t2_server,"T2")
  callModule(t4_server,"T4")
  callModule(t5_server,"T5")
  
})
