
#library( shiny)

library(shiny)
library(leaflet)
library(shinydashboard)
library(shinyWidgets)
library(shinythemes)
library(dplyr)
library(ggplot2)

#setwd("/home/kurowskik/RStudio/TWD/Lab10/")
df2 <- read.csv( "./TIMSS_2019_Gender_Comparison_data.csv")


fluidPage(
    headerPanel( title = "TIMSS 2019 Math Grade 4 Scores Comparison"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "CountrySelection",
          "Select Countries",
          choices = df2$Country,
          multiple = TRUE
        )
        ,
        checkboxInput(
          "GraphScores",
          "Graph Scores",
          value = FALSE
        ),
        checkboxInput(
          "GraphPercentages",
          "Graph Percentages",
          value = FALSE
        )
       ),
      mainPanel( 
        plotOutput("GenderScores"),
        plotOutput("GenderPercentage")
      )
  )
)
