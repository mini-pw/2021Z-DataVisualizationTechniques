library(shiny)

ui <- fluidPage(
  
  titlePanel("Interactive ggplot2"),

  sliderInput("slider1", "Slide sth", 
              min = 1, max = 10, value = c(3, 7)),
  
  plotOutput("plot1", click = "plot1_click"),
  
  verbatimTextOutput("click_value")
  
)