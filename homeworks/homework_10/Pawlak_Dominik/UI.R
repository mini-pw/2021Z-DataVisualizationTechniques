library(DT)
library(plotly)
library(shiny)
library(dplyr)

pageWithSidebar(
  
  headerPanel("TIMSS 2019"),
  
  sidebarPanel(
    
    helpText("TIMSS (Trends in Mathematics and Science Achievement) is an international research assessing students' knowledge from Mathematics and Science. It is conducted among students 
      of grades IV and VIII. In this visualisation, data from 2019 is being used"),
    
    selectInput('subject', 
      label = "Choose subject", 
      choices = list("Mathematics", "Science"),
      selected = "Science"),
    
     selectInput('class', 
      label = "Choose grade", 
      choices = list("IV", "VIII"),
      selected = "IV"),
    
    selectInput('data_type',
      label = "Choose data you want to see:",
      choices = list("Boys" = 1, "Girls" = 2, "Both sexes" = 3),
      selected = 1),
    
    selectInput('sort_type',
                label = "Choose way of sorting:",
                choices = list("Ascending", "Descending"),
                selected = 1),
    
    numericInput('no',
                 label = "Number of countries to be presented in the visualisation, (the head of sorted data frame)*",
                 value = 0),
    
    selectInput('choose_country',
                label = "Choose country to highlight: **",
                choices = M4L %>% pull(Country),
                selected = 1),
    
    actionButton("confirm", label = "Confirm and render plot"),
    
    helpText("source: https://timss2019.org/reports/download-center/"),
    helpText("author: Dominik Pawlak"),
    helpText("* If inserted number is too small, the programme will show 5 countries; if too big - all countries"),
    helpText("** Not all data for all countries is available")
  ),
  
  mainPanel(
    plotlyOutput("plot", height = 600),
    plotlyOutput("plot1")
  )
)

