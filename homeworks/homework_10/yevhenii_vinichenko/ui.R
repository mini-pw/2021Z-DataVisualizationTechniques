library(dplyr)
library(ggplot2)

countries <- read_xlsx("1-8_benchmarks-results-M4.xlsx", skip = 5) %>%
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
      
      selectInput((inputId = "benchmark"),
                  label = "Choose benchmark",
                  choices = c("low", "intermediate",
                              "high", "advanced"),
      ),
      
      selectInput((inputId = "form"),
                  label = "Choose form",
                  choices = c("4th", "8th") 
      ),
      
      checkboxInput("show_median", "Show median", TRUE)
      
  ),
  
  mainPanel(
    
    textOutput("no_country_info"),
  
    plotOutput("plot1", height=600, width = 750)
    
  )
 )
)