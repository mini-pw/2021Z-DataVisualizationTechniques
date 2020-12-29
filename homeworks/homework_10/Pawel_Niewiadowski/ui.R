library(DT)
library(plotly)
library(readxl)

pageWithSidebar(
  headerPanel("TIMSS"),
  sidebarPanel(
    selectInput("klasa",
                label = "Klasa: Uwaga! Nie wszystkie kraje mają ósmą klasę",
                choices = c(4,8),
                selected = 4),
    selectInput("przedmiot",
                label = "Przedmiot:",
                choices = c("Matematyka", "Przyroda"),
                selected = "Matematyka"),
    
    selectInput("kraj",
                label = "Kraj:",
                choices = read_excel("data/1-3_achievement-trends-M4.xlsx", range = "C7:C58"),
                selected = "Poland"),
  ),
  mainPanel(
    plotlyOutput("plot_1"),
    plotlyOutput("plot_2"),
    #DT::dataTableOutput("table_1")
    # verbatimTextOutput("verbatim_1")
  )
)
