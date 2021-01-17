library(shiny)
library(shinyWidgets)
library(dplyr)
library(networkD3)
library(shinydashboard)
library(plotly)
library(shinydashboardPlus)
#devtools::install_github('Lchiffon/wordcloud2', force = T)
library(wordcloud2)

source("upload.R")
dashboardPage(

  skin = "green",
  dashboardHeader(title = "Spotify", disable = F),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Chmura slow", tabName = "wordcloud", icon = icon("fas fa-cloud")),
      menuItem("Radar gatunków", tabName = "radar", icon = icon("fas fa-radiation")),
      menuItem("Graf Artystów", tabName = "graph", icon = icon("fab fa-connectdevelop")),
      menuItem(textInput("token", "Porównaj się z nami", placeholder = "podaj swój token")),
      menuItem(actionButton("submit", "Wczytaj")),
      menuItem(valueBoxOutput("progressBox"))
    )
  ),
  dashboardBody(
    setBackgroundColor("#222d32", shinydashboard = TRUE),
    tags$head( 
      tags$style(HTML(".main-sidebar { font-size: 20px; }")) #change the font size to 20
    ),
    tabItems(
      tabItem(tabName = "wordcloud", wordcloud2Output("cloud", height = 900, width = 1650)),
      tabItem(tabName = "graph", forceNetworkOutput('force', height = 900, width = 1650)),
      tabItem(tabName = "radar", plotlyOutput("radar", height = 900, width = 1650))
    )
  )
)



