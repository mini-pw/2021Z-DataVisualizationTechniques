library(ggplot2)
library(ggiraph)
library(shiny)

pageWithSidebar(
  headerPanel("Click on a ball and choose a movie for Christmas!"),
  sidebarPanel(width=0),
  mainPanel(
    girafeOutput("christmas")
  )
)