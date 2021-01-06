library(dplyr)
library(ggplot2)
library(shiny)
library("readxl")
library(plotly)

countries <- read_xlsx("data/plot1/1-8_benchmarks-results-M4.xlsx", skip = 5) %>%
  select(3) %>%
  na.omit()

countries <- countries[-(59:65), ]

countries <- countries[[1]]

countries <- sort(countries)

ui <- fluidPage(
  
  titlePanel("TIMSS 2019"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput((inputId = "country"),
                  label = "Choose country to highlight",
                  choices = countries
      ),
      
      selectInput((inputId = "subject"),
                  label = "Choose subject",
                  choices = c("math", "science") 
      ),
      
      selectInput((inputId = "form"),
                  label = "Choose form",
                  choices = c("4th", "8th") 
      ),
      
      "In case of suggestions or questions:",
      
      tags$a(href="mailto:shinyappTWD@protonmail.com", target="_blank", 
             "shinyappTWD@protonmail.com"),
      
      ".",
      
      tags$br(),
      
      tags$a(href="https://timssandpirls.bc.edu/timss-landing.html", 
             "Futher reading on TIMSS.")
      
  ),
  
  mainPanel(
    
    tabsetPanel(type = "tabs",
                
       tabPanel("Benchmarks",
    
            fluidRow(
    
                column( width = 4,
                          checkboxInput("show_median", "Show median", TRUE)
                       ),
      
                column( width = 4,
                          selectInput((inputId = "benchmark"),
                                      label = "Choose benchmark",
                          choices = c("low", "intermediate",
                                      "high", "advanced"),
                                      )
    
                      ) 
    
                ),
    
            plotOutput("plot1", height=600, width = 750)
    
    
             ),
       
       tabPanel("Teachers & results",
                plotlyOutput("plot2"),
                "This plot is interactive, try hovering or zooming.")
      
       ),

)

)
)