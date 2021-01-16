library(DT)
library(ggplot2)
library(plotly)
library(shiny)
library(shinydashboard)

library("readxl")
library(dplyr)

function(input, output, session){
  
 
  ### Aplikacja ###
  
  x_range <- list(range = c(0, max(M4$Score, S4$Score)+25))
    
  output$plotly_1 <- renderPlotly({
    
    plot_ly(data = M4[(M4$Nr >= input$range[1] & M4$Nr <= input$range[2]), ],
            x = ~Score, y = ~Country, type = "bar") %>%
    layout(xaxis = x_range, title = "Math score", colorway = c("#8ca4cc", "#fa686a")) %>%
    add_trace(x = M4[M4$Country == input$country_select, "Score"], y = ~Country, type = "scatter", mode = "line",
              showlegend = FALSE)
    })
  
  
  
  output$plotly_2 <- renderPlotly(
    plot_ly(data = S4[S4$Nr >= input$range[1] & S4$Nr <= input$range[2], ]
            , x = ~Score, y = ~Country, type = "bar")
    %>% layout(xaxis = x_range, title = "Science score", colorway = c("#63c1a2", "#fa686a")) %>%
    add_trace(x = S4[S4$Country == input$country_select, "Score"], y = ~Country, type = "scatter", mode = "line",
              showlegend = F) 
    )
  
  x_range2 <- c(max(MS4$Diffrence), min(MS4$Diffrence))
  
  output$plotly_3 <- renderPlotly(
    plot_ly(data = MS4[MS4$Nr >= input$range[1] & MS4$Nr <= input$range[2], ]
            , x = ~Diffrence, y = ~Country, type = "bar", color = ~Color)
    %>% layout(
      xaxis = list(range = x_range2, ticktext = c("Math", "Science"),
                            tickvals = c(0.6*unlist(x_range2)[1],0.8*unlist(x_range2)[2])),
      title = "Difference between  score", showlegend = F,
      colorway = c("#2ca02c", "#17becf")) 

  )
  scoresMS <- reactive(MS4[MS4$Country==input$country_select, c("Score.Math", "Score.Science")])
  
  observeEvent(input$country_select, {
    output$text2 <- renderText({
      paste("Math: ", isolate(scoresMS())[1])
    })
    output$text3 <- renderText({
      paste("Science: ", isolate(scoresMS())[2])
    })
    output$text1 <- renderText({
      paste("Choosen country: ", input$country_select)
    })
  })
}
