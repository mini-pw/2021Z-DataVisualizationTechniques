library(shiny)
library(shinythemes)
library(dplyr)
library(xlsx)
library(ggplot2)
library(plotly)
source("data.R")

ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel("TIMSS Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "grade",
                  label = "Grade",
                  choices = c(4, 8)),
      br(),
      selectInput(inputId = "subject",
                  label = "Subject",
                  choices = c("Mathematics", "Science")),
      br(),
      uiOutput("source")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Average achievements", br(),
                 selectInput(inputId = "year",
                             label = "Year",
                             choices = c(2019, 2015, 2011, 2007, 2003, 1995)),
                 br(),
                 dataTableOutput("table")),
        tabPanel("Trend plots of average achievement", br(),
                 selectInput(inputId = "country",
                             label = "Country",
                             choices = trends_M4 %>% pull(Country)
                 ),
                 br(),
                 plotlyOutput("scoreTrends")),
        tabPanel("Frequency of student absences", br(),
                 selectInput(inputId = "country2",
                             label = "Country",
                             choices = freq_M4 %>% pull(Country)
                 ),
                 br(),
                 dataTableOutput("table2"),
                 br(),
                 plotlyOutput("absences"),
                 br(), br(), br()
                 )
      )
    )
  )
)

server <- function(input, output, session) {
  
  url <- a("TIMSS2019", href="https://timss2019.org/reports/download-center/")
  output$source <- renderUI({
    tagList("Source:", url)
  })
  
  prepareDataTable <- function(subject, grade, year) {
    trends <- paste0("trends_", substring(subject, 1, 1), grade)
    year <- paste0("X", year)
    df_table <- get(trends) %>%
      filter(get(year) != '') %>%
      filter(!is.na(get(year))) %>%
      select("Country", year) %>%
      ungroup() %>%
      arrange(desc(get(year)))
    names(df_table) <- c("Country", "average score")
    return(df_table)
  }
  
  prepareDataTable_2 <- function(subject, grade, country) {
    freqs <- paste0("freq_", substring(subject, 1, 1), grade)
    df_table <- get(freqs) %>%
      filter(Country == country)
    if (nrow(df_table) == 0) {
      return(data.frame("Frequency of Student Absences" = NULL, 
                        "Percent of Students" = NULL,
                        "Average Achievement" = NULL))
    } else {
      v <- as.numeric(df_table[1,2:11]);
    return(data.frame("Frequency of Student Absences" = c(
      "Never or Almost Never", "Once Every Two Months", "Once a Month",
      "Once Every Two Weeks", "Once a Week"
    ), "Percent of Students" = c(v[1], v[3], v[5], v[7], v[9]),
    "Average Achievement" = c(v[2], v[4], v[6], v[8], v[10])))
    }
  }
  
  output$table <- renderDataTable(prepareDataTable(
    input$subject, input$grade, input$year
  ), options = list(pageLength = 5))
  
  output$table2 <- renderDataTable(prepareDataTable_2(
    input$subject, input$grade, input$country2
  ), options = list(pageLength = 5, lengthMenu = c(3, 5)))

  
  output$scoreTrends <- renderPlotly({
    trends <- paste0("trends_", substring(input$subject, 1, 1), input$grade)
    df <- get(trends) %>%
      filter(Country == input$country)
    if (nrow(df) == 0) {
      ggplot() + 
        annotate("text", x = 4, y = 25, size=8,
                 label = "No data found\nfor selected options") + 
        theme_void()
    } else {
      v <- as.numeric(df[1,2:7]);
      df2 <- data.frame("year" = c(2019, 2015, 2011, 2007, 2003, 1995),
                        "score" = v) %>%
        filter(!is.na(score))
      ggplot(df2, aes(x = year, y = score)) +
        xlim(1995, 2019) +
        ylim(280, 650) +
        ylab("average achievement") +
        geom_line() +
        geom_point() + 
        theme_minimal()
    }
  })
  
  output$absences <- renderPlotly({
    df <- prepareDataTable_2(input$subject, input$grade, input$country2)
    if (nrow(df) == 0) {
      ggplot() + 
        annotate("text", x = 4, y = 25, size=8,
                 label = "No data found\nfor selected options") + 
        theme_void()
    } else {
      df$Frequency.of.Student.Absences <- c(
        "Never or\nAlmost Never", "Once Every\nTwo Months", "Once\na Month",
        "Once Every\nTwo Weeks", "Once\na Week"
      )
      ggplot(data = df, aes(
        x = Frequency.of.Student.Absences, y = Percent.of.Students
      )) +
        geom_bar(stat = "identity", color="#e6a40b", fill="#e6a40b") +
        ylim(0, 100) +
        ylab("percent of students [%]") +
        xlab("") +
        theme_minimal()
    }
  })
}

shinyApp(ui, server)

