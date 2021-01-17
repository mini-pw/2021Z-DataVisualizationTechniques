library(shiny)
library(ggplot2)
library(plotly)

math <- read.csv("./dane/math.csv")
dane_temp <- math %>% select("Country", "four") %>% na.omit() 

shinyUI(fluidPage(
  
  titlePanel("TIMSS data visualizaton"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("grade",
                  label = "Select grade:",
                  choices = c("4th", "8th"),
                  selected = "4th"),
      
      selectizeInput("subject", 
                     label = "Select subject:", 
                     choices = list("mathematics" = 0, "science" = 1), 
                     selected = 0),
      selectizeInput('country',
                     label = 'Select coutries',
                     choices = dane_temp$Country,
                     multiple = TRUE),
      helpText("List of countries is generated based on previous choices, so if you can't find 
               a one it's probably because there's no data about selected grade or subcject
               for this county.")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Scores comparison",
                 h4("Plot showing comparison of average scores obtained by students from different countries"),
                 h6("The comparison tests were created and conducted by TIMSS ogranization."),
                 plotlyOutput("barplot", height = 800, width = 900)),
        tabPanel("Affluence and Score",
                 h4("Plot showing relation between affluence and score."),
                 h6("More affluent school is school where more than 25% of student body comes from economiclly affluent 
                    homes and less than 25% from economically disadventaged homes"),
                 plotlyOutput("scatterplot", height = 450, width = 900)),
        
        tabPanel("Sources and Author",
                 h3("About author "),
                 "I'm Szymon Szmajdziński and I study Data Science at Warsow Uniwersity of Technology.
                 This is my homework project." ,

                 h3("Data"),
                 HTML("I used data form TIMSS official website, an international organization conducting comparative assessments of student achievement in mathematics and science.<br>"),
                 "To read more about this organization check this link:", tags$a(href="https://timssandpirls.bc.edu/about.html", "https://timssandpirls.bc.edu/about.html"),
                 HTML("<br>And if you want to download data check this link:"),
                 tags$a(href="https://timss2019.org/reports/download-center/", "https://timss2019.org/reports/download-center/"))

      )
    )
  )
))