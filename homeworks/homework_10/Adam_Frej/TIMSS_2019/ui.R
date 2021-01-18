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
library(ggplot2)
library(plotly)

# Define UI for application
shinyUI(fluidPage(

    # Application title
    titlePanel("TIMSS results"),
    
    mainPanel(
        plotlyOutput("plot_bar", height = 900),
        width = 6
        ),
    sidebarPanel(
        selectInput("select_gender", label = h3("Gender"), 
                    choices = list("Both" = "all", "Girls" = "girls", "Boys" = "boys"), 
                    selected = 1),
        selectInput("select_year", label = h3("Year"), 
                    choices = list("2019" = "Score2019", "2015" = "Score2015", 
                                   "2011" = "Score2011", "2007" = "Score2007", 
                                   "2003" = "Score2003", "1995" = "Score1995"), 
                    selected = 1),
        selectInput("select_data", label = h3("Research"), 
                    choices = list("Math" = "M", "Science" = "S"), 
                    selected = 1),
        plotlyOutput("plot_time"),
        strong("Click on the bars."),
        width = 6
    )
))
