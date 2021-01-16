library(DT)
library(plotly)
library(shiny)
library(shinydashboard)
library(readxl)

M4_2019_read <- read_xlsx("1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 13, 14) %>%
  rename("Score" = "Average \r\nScale Score", "5th_percentile" = "Mathematics Achievement Distribution",
         "25th_percentile" = "...10", "75th_percentile" = "...13", "95th_percentile" = "...14") %>%
  na.omit()

M4_2015_read <- read_xlsx("1_1_math-distribution-of-mathematics-achievement-grade-4.xlsx", skip = 4) %>%
  select(3, 4, 7, 8, 11, 12) %>%
  rename("Score" ="Average\r\nScale Score", "5th_percentile" = "Mathematics Achievement Distribution",
         "25th_percentile" = "...8", "75th_percentile" = "...11", "95th_percentile" = "...12") %>% 
  na.omit()


M4_countries <- M4_2015_read[M4_2015_read$Country %in% M4_2019_read$Country, c("Country")]


pageWithSidebar(
  headerPanel("TIMSS visualization"),
  sidebarPanel(
    radioButtons("subject", "Subject:",
                 list("Math", "Science")),
    checkboxGroupInput("checkGroup", label = ("Year"), 
                       choices = c("2015", "2019"),
                       selected = "2019"),
    selectInput("country_selection",
                label = "Country:",
                choices = M4_countries$Country,
                multiple = TRUE)),
  mainPanel(
    plotOutput("plot_1"),
    fluidRow(
      column(width = 12,
             box(
               title = "Score and percentiles", width = NULL, status = "primary",
               div(style = 'overflow-x: scroll', DT::dataTableOutput('table_1'))
             ))))
)

