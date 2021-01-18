library(shiny)
library(dplyr)
library(readxl)
library(ggplot2)
library(plotly)

data <- read_excel("d1.xlsx")

shinyServer(function(input, output, session){
  
  output$barplot <- renderPlotly({
    choice_country <- paste0("country-", input$subject, input$grade, "-", input$year)
    choice_result <- paste0("result-", input$subject, input$grade, "-", input$year)
    
    df <- my_data[c(choice_country, choice_result)]
    colnames(df) <- c("country", "result")
    df$country <- factor(df$country, levels = rev(df$country))
    
    p <- ggplot(df, aes(x = country, y = result)) +
      geom_bar(stat = "identity", fill = "dodgerblue") +
      xlab("") +
      scale_y_continuous(limits=c(0,650), expand = c(0, 0)) +
      ylab("average result") +
      coord_flip() +
      theme_bw()
   
    
    ggplotly(p)
  })
  
  output$scatterplot <- renderPlotly({
    choice_x_country <- paste0("country-", input$xsubject, input$xgrade, "-", input$xyear)
    choice_x_result <- paste0("result-", input$xsubject, input$xgrade, "-", input$xyear)
    
    choice_y_country <- paste0("country-", input$ysubject, input$ygrade, "-", input$yyear)
    choice_y_result <- paste0("result-", input$ysubject, input$ygrade, "-", input$yyear)
    
    df1 <- data[c(choice_x_country, choice_x_result)]
    df2 <- data[c(choice_y_country, choice_y_result)]
    
    colnames(df1) <- c("country", "result")
    colnames(df2) <- c("country", "result")
    
    df <- df1 %>%
              full_join(df2, by = "country") %>% 
              filter(!is.na(result.x)) %>%
              filter(!is.na(result.y))
    
    df <- df %>% mutate(info = paste(country, "\nx axis:", result.x, "\ny axis:", result.y))
    
    xAxisText <- paste0("result in ",
                        ifelse(input$xsubject == "m", "mathematics", "science"),
                        ", ",
                        ifelse(input$xgrade == "4", "4th grade", "8th grade"),
                        ", ",
                        ifelse(input$xyear == "2019", "2019", "2015"))
    
    yAxisText <- paste0("result in ",
                        ifelse(input$ysubject == "m", "mathematics", "science"),
                        ", ",
                        ifelse(input$ygrade == "4", "4th grade", "8th grade"),
                        ", ",
                        ifelse(input$yyear == "2019", "2019", "2015"))
    
    p <- ggplot(df, aes(x = result.x, y = result.y)) +
      geom_point() +
      xlab(xAxisText) +
      ylab(yAxisText) +
      theme_bw()
    
    ggplotly(p) %>% add_trace(data = df,
                              x = ~result.x,
                              y = ~result.y,
                              text = ~info,
                              hoverinfo = "text",
                              type = "scatter",
                              mode = "markers")
    
      })
  
})
