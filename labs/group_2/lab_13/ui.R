library(shiny)

ui <- fluidPage(
  
  titlePanel("Interactive ggplot2"),
  numericInput("max_slider", "Input max slider length",
               min = 10, max = 20, value = 10),
  sliderInput("slider1", "Slide something", 
              min = 1, max = 100, value = c(4, 6)),
  
  textInput("text1", "Enter title", value = "title"),
  uiOutput("long_text_box"),
  textOutput("text_value"),
  
  plotOutput("plot1", click = "plot1_click"),
  
  verbatimTextOutput("click_value")
  
)
