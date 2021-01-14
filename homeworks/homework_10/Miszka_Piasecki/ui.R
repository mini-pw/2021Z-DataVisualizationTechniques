library(DT)
library(plotly)
source("data_processing.R")


pageWithSidebar(
  
  headerPanel("TIMSS Results 2019"),
  sidebarPanel(
    
    selectInput('Subject',
                label = "Choose subject:",
                choices = c("Mathematics", "Science"),
                selected = "Mathematics"),
    selectInput('Grade',
                label = "Choose grade:",
                choices = c("IV", "VIII"),
                selected = "IV"),
    selectInput('kraj',
                label = "Wybierz kraj:",
                choices = sort(unique(c(Math_4$Country, Math_8$Country)))),
    helpText("TIMSS and PIRLS are international assessments that monitor trends in student achievement in mathematics, science, and reading.

Currently 70 countries participate in the assessments, which have been conducted at regular intervals since 1995..")
  ),
  
  
  mainPanel(
    tabsetPanel(
      tabPanel("Average result",icon=icon("award"),
               selectInput('top', label = "Choose option:",
                           choices = c("10 best countries", "30 best countries",
                                       "10 worst countries", "30 worst countries",
                                       "all"),
                           selected = "all"),
               textOutput("text1"),
               plotlyOutput("wykres1"))
      
      
      )
    )
  )
