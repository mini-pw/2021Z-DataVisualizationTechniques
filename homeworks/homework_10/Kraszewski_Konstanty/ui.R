library(plotly)
library(dplyr)
source("data.R")

pageWithSidebar(
  headerPanel("TIMSS 2019"),
  sidebarPanel(
    selectInput("subject",
                label = "Subject:",
                choices = c("mathematics", "science"),
                selected = "matematyka"),
    selectInput("year",
                label = "Year:",
                choices = c("4","8"),
                selected = "4"),
    selectInput("country",
                label = "Country:",
                choices = sort(unique(c(M4$Country, M8$Country, S4$Country, S8$Country))),
                selected = "Poland")
  ),
  mainPanel(
    plotlyOutput("plot_1"),
    plotOutput("plot_2")
  )
)