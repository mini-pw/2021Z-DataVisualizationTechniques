library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(plotly)
source("data.R")

ui <- fluidPage(theme = shinytheme("flatly"),
  titlePanel("TIMSS Data Explorer"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("grade", "Select grade:", choices = 
                   c("4",
                     "8")),
      br(),
      radioButtons("subject", "Select subject:", choices = 
                     c("Mathematics",
                      "Science")), br(), 
      selectInput(inputId = "country",
                  label = "Select country to highlight",
                  choices = M4_results %>% pull(Country)),
      width = 3
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Average achievements", br(), verbatimTextOutput("warning2"),
                 br(),
                 plotlyOutput("results")),
        tabPanel("Trends in countries",br(), verbatimTextOutput("warning"),  br(),
                 plotlyOutput("resultsTrends"))
      )
    )
  )
)




server <- function(input, output, session) {
  
  output$results<- renderPlotly({
    
    if (input$subject == "Mathematics" & input$grade == "4"){
      data_score <- M4_results
    } else if (input$subject == "Mathematics" & input$grade == "8") {
      data_score <- M8_results
      
    }else if (input$subject == "Science" & input$grade == "8") {
      data_score <- S8_results
      
    } else{
      data_score <- S4_results
    }
    
    
    data_score$Country <- factor(data_score$Country, levels = data_score$Country)
    
    
    fig <- plot_ly(data_score)
    
    fig <- fig %>% add_segments(x = ~th5_Percentile, xend = ~th95_Percentile, y = ~Country, yend = ~Country, line = list(color = '#7f7f7f'), showlegend = F)
    
    data_score_2 <- data_score %>% filter(Country == input$country)
    
    
    
    fig <- fig %>% add_segments(data = data_score_2, x = ~th5_Percentile, xend = ~th95_Percentile, y = ~Country, yend = ~Country, line = list(color = 'red'), name = 'Highlighted country')
    
    fig <- fig %>% add_segments(data = data_score,x = ~a_95Confidence_Interval_1, xend = ~a_95Confidence_Interval_2, y = ~Country, yend = ~Country, line = list(color = 'black'), name = '95% Confidence Interval')
    
    
    fig <- fig %>% add_markers( x = ~th5_Percentile, y = ~Country, name = "5th percentile",  marker = list(color = '#1f77b4') )
    fig <- fig %>% add_markers(x = ~th25_Percentile, y = ~Country, name = "25th percentile", marker = list(color = '#ff7f0e'))
    fig <- fig %>% add_markers(x = ~th75_Percentile, y = ~Country, name = "75th percentile", marker = list(color = '#ff7f0e') )
    fig <- fig %>% add_markers(x = ~th95_Percentile, y = ~Country, name = "95th percentile", marker = list(color = '#1f77b4'))
    
    
    
    fig <- fig %>% layout(height = 1000,
                          xaxis = list(title = "Score"), yaxis = list(title = "", autoranged = F, autoranged = "reversed"))
    
    
    
  
    
    

    
    
    fig <- fig %>% layout(yaxis = list(autorange = "reversed"))
    fig
    
  })
  
  dane <- reactive({
    
  })
  
  output$resultsTrends<- renderPlotly({
    
    if (input$subject == "Mathematics" & input$grade == "4"){
      data_score <- M4_trends
    } else if (input$subject == "Mathematics" & input$grade == "8") {
      data_score <- M8_trends
      
    }else if (input$subject == "Science" & input$grade == "8") {
      data_score <- S8_trends
      
    } else{
      data_score <- S4_trends
    }
    
    

    
    data <- data_score %>% filter(Country == input$country)
    values <- as.numeric(data[1,2:7])
    df <- data.frame("year" = c(2019, 2015, 2011, 2007, 2003, 1995),
                      "score" = values)
    
    
    fig <- plot_ly(df, type = 'scatter', mode = 'lines')
    fig <- fig %>% add_trace(x=~year, y=~score, mode = "lines+markers", showlegend = FALSE)
    
    
    fig<- fig %>% layout(xaxis = list(title = "Year", range = c(1990, 2024)), yaxis = list(title = "Average score",range = c(280, 650)))
    
    fig
    
    
    
  })
  
output$warning <- renderText("Please, bear in mind, that for some countires there are no data to be shown. Therefore plot will be blank.\nIf points are not connetced, the country didn't take part in TIMSS research between particular years.")

output$warning2 <- renderText("Please, bear in mind, that you will not highlight country if there is no data for it.\nZoom in if country label on yaxis isn't plotted (That is for pure aesthetics).")
  
  
}



shinyApp(ui, server)
