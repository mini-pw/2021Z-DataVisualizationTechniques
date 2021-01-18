library(DT)
library(plotly)

math_4<-read.csv("math_4_grade_score.csv")
math_4

ui <- fluidPage(
  tags$head(tags$link(rel="shortcut icon",
                      href="https://prnewswire2-a.akamaihd.net/p/1893751/sp/189375100/thumbnail/entry_id/0_3uwa93ez/def_height/2700/def_width/2700/version/100012/type/1")),

pageWithSidebar(
  headerPanel("TIMSS 2019 results"),
  sidebarPanel(
    selectInput("subject_choice",
                label = "Subject:",
                choices = c("Math", "Science"),
                selected = "Math"),
    selectInput("grade_choice",
                label = "Grade:",
                choices = c("4th", "8th"),
                selected = "4th"),
    sliderInput("number_countries",
                label = "How many countries:",
                min = 1, 
                max = length(math_4$Country), 
                value = 30,
                animate = TRUE),
    
    
    helpText("If one country is not highlighted on the chart, it may be below choosen number of countries."),
    selectInput("country_choice",
                label = "Country:",
                choices = math_4$Country,
                selected = math_4$Country[1]),
    
    helpText("Chart about genders you can find on second page."),
    radioButtons("gender_choice", label = "Gender:",
                 choices = c("Girls", "Boys", "Both"), inline=F),
    
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Scores",icon=icon("star"),
               plotlyOutput(output = "barchart_1", height = 600)),
      tabPanel("Genders",icon=icon("venus-mars"),
               plotlyOutput(output = "linegraph_1", height = 600)),
      tabPanel("Author",icon=icon("at"), helpText("Agata Kaczmarek")),
      tabPanel("Data", icon=icon("database"), helpText("Data downloaded: 07.01.2021"), helpText("Source: "), a("https://timss2019.org/reports/download-center/"))
      
    ),
  )
)
)