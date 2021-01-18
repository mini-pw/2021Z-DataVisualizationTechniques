library(shiny)
library(plotly)
library(ggplot2)
library(tidyr)
library(shinythemes)

function(input, output, session) {
  

  
  getData <- reactive({
    if(input$Subject=='m' && input$Grade=='4') df <- M4
    if(input$Subject=='s' && input$Grade=='4') df <- S4
    if(input$Subject=='m' && input$Grade=='8') df <- M8
    if(input$Subject=='s' && input$Grade=='8') df <- S8
    if(is.null(input$Countries)){
      df <- df %>% mutate(Color = "1")
    } else{
      df <- df %>% mutate(Color = ifelse(Country %in% input$Countries, "2", "1"))
    }
    if(input$Show){
      df <- df %>% 
        filter(Color==2)
    }
    df
  })
  
  getData2 <- reactive({
    if(input$Subject=='m' && input$Grade=='4') df <- M4learning
    if(input$Subject=='s' && input$Grade=='4') df <- S4learning
    if(input$Subject=='m' && input$Grade=='8') df <- M8learning
    if(input$Subject=='s' && input$Grade=='8') df <- S8learning
    if(is.null(input$Countries)){
      df <- df %>% mutate(Color = "1")
    } else{
      df <- df %>% mutate(Color = ifelse(Country %in% input$Countries, "2", "1"))
    }
    if(input$Show){
      df <- df %>% 
        filter(Color==2)
    }
    df
  })
  
  output$scorePlot <- renderPlotly({
    plot <-  ggplot(getData(), aes(x=reorder(Country,!!sym(input$Gender)), !!sym(input$Gender), fill=Color)) +
      geom_bar(stat = "identity") + 
      coord_flip() + 
      theme_minimal() +
      scale_y_continuous(expand = c(0, 0)) +
      theme(plot.background = element_rect(fill="transparent"),
            panel.background = element_rect(fill="transparent"),
            legend.position = "none", 
            axis.title.y = element_blank(),
            axis.title.x = element_blank()
            )
    
    ggplotly(plot)
  })
  
  output$learningPlot <- renderPlotly({
    plot <-  ggplot(getData2(), aes(x=reorder(Country,Score), Score, fill=Color)) +
      geom_bar(stat = "identity") + 
      coord_flip() + 
      theme_minimal() +
      scale_y_continuous(expand = c(0, 0)) +
      theme(plot.background = element_rect(fill="transparent"),
            panel.background = element_rect(fill="transparent"),
            legend.position = "none", 
            axis.title.y = element_blank(),
            axis.title.x = element_blank())
    
    ggplotly(plot)
    
  })
  
}