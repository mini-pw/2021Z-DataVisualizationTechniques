library(shiny)
library(plotly)
library(ggplot2)
library(tidyr)
library(shinyjs)
library(shinythemes)


  
fluidPage(
  theme  = shinytheme("united"),
  titlePanel("TIMSS 2019 International Results in
Mathematics and Science"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Subject",label="Subject", 
                  choices=c("Mathematics"="m", "Science"="s"), 
                  selected="Mathematics"),
      selectInput("Grade",label="Grade", 
                  choices=c("4"="4", "8"="8"), 
                  selected="4"),
      selectizeInput('Gender',
                     label = 'Gender',
                     choices = c("Boys"="Boys", "Girls"="Girls","Average"="Score"),
                     multiple=FALSE,
                     selected='Score'),
      selectizeInput('Countries',
                     label = 'Countries to highlight',
                     choices =M4$Country,
                     multiple = TRUE),
      checkboxInput("Show", "Show only highlighted", value=FALSE)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(align = "center","Average Score",
                 plotlyOutput("scorePlot", height = "800px")),
        tabPanel("How much students like learning subject?",
                 fluidRow(
                   sidebarPanel(h4("Students were scored according to their responses to nine statements on the Students Like Learning Subject scale."),
                                h4("0-8: Do Not Like"),
                                h4("8-10: Somewhat Like"),
                                h4("10-12: Very Much Like"), width=12)
                   ),
                 fluidRow(
                   plotlyOutput("learningPlot", height = "800px")
                 )
      )
    )
  )
  
  

)
  )