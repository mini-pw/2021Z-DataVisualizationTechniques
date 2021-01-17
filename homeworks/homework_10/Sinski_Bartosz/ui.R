library(plotly)
library(shiny)
source("readingData.R")
fluidPage(
  titlePanel("TIMSS 2019 - Trends in International Mathematics and Science Study"),
  fluidRow(
    column(8,
           selectInput("Countries","Choose country:",M4t$Country,selected = "United States")
    ),
    column(4,
           radioButtons("grade"," Choose Grade:", choices = list("4th Grade" = 1, "8th Grade" = 2, "Both" = 3),selected = 1)
    )
  ),
  fluidRow(
    column(6,
           plotOutput("plot1")
           ),
    column(6,
           plotOutput("plot2")
           )
  )
  
)
