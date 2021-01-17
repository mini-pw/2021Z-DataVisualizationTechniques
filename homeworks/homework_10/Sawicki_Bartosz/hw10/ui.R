#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(leaflet)
library(spData)
library(shinythemes)
library(plotly)
library(sf)


shinyUI(fluidPage(

    # Application title
    titlePanel("How does Students\' attitude affect their results"),

    sidebarLayout(
        sidebarPanel(
            "Choose Country 1 (and Country 2 for comparison)",
            selectInput("country1",
                        "Country 1:",
                        choices = NULL),
            selectInput("country2",
                        "Country 2:",
                        choices = NULL),
            helpText("Chosen countries on world map"),
            leafletOutput("map")
        ),
        
        mainPanel(
            "Data from TIMSS 2019 4th grade Mathematics survey",
            radioButtons("radio", label = h3("Choose category:"),
                         choices = list("Enjoying Maths" = 1, "Confidence in Maths" = 2, "Bullying at school" = 3), 
                         selected = 1, inline = TRUE),
            plotlyOutput("all_countries"),
            plotOutput("details")
        )
    ),
    theme = shinytheme("spacelab")
))
