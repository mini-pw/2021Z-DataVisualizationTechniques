library(DT)
library(plotly)
library(shiny)
library(dplyr)

Countries <- read.csv("./processeddata/Countries.csv")

pageWithSidebar( #fluidPage()
  headerPanel("TIMSS 2019 International Results in Mathematics"),
  sidebarPanel(
    helpText("The graphs are interacvtive - you should try to zoom or to move your cursor over the parts that you're interested in."),
    
    selectInput("plotly_math_type",
                label = "Math Domain:",
                choices = c("Content", "Cognitive"),
                selected = "Content"),
    selectInput("plotly_math_class",
                label = "Grade:",
                choices = c("4th", "8th"),
                selected = "4th")),
   
  mainPanel(
    tabsetPanel(
      tabPanel("All countries comparison",
               helpText("Each of the maths domain (content and cognitive) has its seperate areas. Choose if you want to compare
                        the overall average of the domain or view separate areas."),
               selectInput("plotly_scatter_choice",
                           label = "Overall Average or Separate areas:",
                           choices = c("Overall Average", "Separate areas"),
                           selected = "Overall Average"),
               selectInput("plotly_scatter_all_sort",
                          label = "Sorted:",
                          choices = c("No", "Yes"),
                          selected = "No"),
               plotlyOutput("plotly_scatter_all")),
      
  
      tabPanel("Scores over the years",
               helpText("Choose a country from the list that you want to analyse. The graph shows scores in each maths' domain area throughout the years. 
                        \n Warning: Some data may be incompelete"),
               selectInput("plotly_country",
                           label = "Country:",
                           choices = unique(Countries$x),
                           selected = "Australia"),
               plotlyOutput("plotly_1")),
      tabPanel("Sources and Author",
               h4("Source"),
               "Data tables needed to generate all of the graphs can be downloaded from",
               tags$a(href="https://timss2019.org/reports/download-center/", target="_blank", 
                      "TIMSS official site"),
               "The code soon will be posted on GitHub but I can as well sent it to you personally - feel free to email me. My e-mail:",
               tags$a(href="mail", target="_blank", 
                      "kinia.u@poczta.fm"),
               h4("Author"),
               "Hello, Kinga Ulasik here.",
               "I am student at the University of Technology in Varsaw in the field of Data Engineering and Analysis. 
               This app was created as a part of a projekt of Data Visualization Techniques.",
               "If you have any questions or suggestions, contact me via email.")
      
    
    )
  )
)