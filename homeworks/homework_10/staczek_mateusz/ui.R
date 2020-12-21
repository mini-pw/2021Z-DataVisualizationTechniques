library(shiny)
library(plotly)

ui <- fluidPage(
  tags$head(tags$link(rel="shortcut icon",
                      href="https://i.ibb.co/SsqLNtQ/unicorns-Are-Real.png")),
  
  titlePanel("TIMSS Countries Comparison"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(inputId = "year",label =  "Select year:",
                  choices = c("2019")),
      
      selectInput(inputId = "subject",label =  "Select subject:",
                  choices = c("Mathematics", "Science")),
      
      selectInput(inputId = "grade",label =  "Select grade of students:",
                  choices = c("4th", "8th")),
      
      
      helpText("Choose country to be highlighted in the plots. 'None' disables highlighting."),

      selectizeInput(inputId = "country",
                     label="Highlighted country:",
                     choices = c("None"),
                     selected = "None",
                     options = list(maxItems = 1,
                                    maxOptions = 200)),
      actionButton("updateCountriesList", "Update countries selection list"),
      helpText("Button above updates countries selection to show only countries in selected dataset
               (that is for chosen grade, subject etc)." ),
      tags$a(href="https://timssandpirls.bc.edu/about.html", target="_blank", 
             "Read more about TIMSS"),
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel(title = "Average Score Plot", 
                 h4("Average Achievement and Scale Score Distributions"),
                 helpText("Plot below is interactive - try hovering over bars or zooming."),
                 
                 plotlyOutput(outputId = "avgplot",height = 400),
                 
                 ),
        tabPanel("Detailed Students' Achievment Plot", 
                 h4("Percentages of Students Reaching International Benchmarks Achievement"),
                 helpText("Plot below shows percentage of students who scored above 625 (Advanced 
               - black dots), 550 (High - white dots), 475 (Intermediate - dark blue) 
               or 400 (Low - light blue)."),
                 selectInput(inputId = "sortingByColumn",label =  "Select value to sort by:",
                             choices = c("Advanced", "High", "Intermediate", "Low")),
                 
                 plotOutput(outputId = "benchplot",height = 700),
                 
                 ),
        tabPanel("Sources and others", 
                 h4("Sources"),
                 "Data was downloaded on 19th December, 2020 from ",
                 tags$a(href="https://timss2019.org/reports/download-center/", target="_blank", 
                        "official TIMSS webpage"),
                 verbatimTextOutput("justToMakeEnter;P"),
                 "Code is available here:",
                 tags$a(href="https://github.com/mstaczek/ShinyTIMSS", target="_blank", 
                        "github.com/mstaczek/ShinyTIMSS"),
                 
                 h4("About author"),
                 "Hi, I'm Mateusz and I've build this small Shiny app as a project for Data 
                 Visualization Techniques course at my studies. If you found any errors or have
                 any suggestions, feel free to send me a message here:",
                 tags$a(href="mailto:jgatrr@gmail.com", target="_blank", 
                        "jgatrr@gmail.com"),
                 )
        
      ),
    )
  )
)