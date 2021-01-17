library(shiny)

ui <- fluidPage(
  
  titlePanel("Interactive ggplot2"),
  numericInput("max_slider", "Input max slider length",
               min = 10, max = 20, value = 10),
  sliderInput("slider1", "Slide", 
              min = 1, max = 100, value = c(3,6)),
  
  textInput("text1", "Provide title", value = "Title"),
  uiOutput("long_text_box"),
  textOutput("text_value"),
  
  plotOutput("plot1", click = "plot1_click"),
  
  verbatimTextOutput("click_value")
)