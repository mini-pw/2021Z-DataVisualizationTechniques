library(shiny)
library(leaflet)
library(shinydashboard)
library(shinyWidgets)
library(shinythemes)


shinyUI(bootstrapPage(
    navbarPage(theme = shinytheme("flatly"), collapsible = TRUE, 
               "TIMMS 2019", id = "nav",
        tabPanel("Map",
                tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
                leafletOutput("map"),
                absolutePanel(id = "controls", class = "panel panel-default",
                              top = 75, left = 55, width = 250, fixed = TRUE,
                              draggable = TRUE, height = "auto",
                              selectInput("subject", 
                                          label = "Choose subject: ", 
                                          choices = c("Math", "Science")),
                              selectInput("class",
                                          label = "Choose class: ",
                                          choices = c(4, 8))
                  )),
        tabPanel("Gender",
                 plotOutput("gender")))
    )
)

