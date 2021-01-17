library(shiny)
library(ggplot2)
library(plotly)
library(tidyr)

shinyServer(function(input, output, session) {
  
  # loading data
  math <- read.csv("./dane/math.csv") %>% filter(Country != "TIMSS Scale Centerpoint")
  science <- read.csv("./dane/science.csv") %>% filter(Country != "TIMSS Scale Centerpoint")
  
  observe({
    if(input$subject == 0) dane_temp = math
    else dane_temp = science
    
    if(input$grade == "4th") grade = "four"
    else grade = "eight"
    
    dane_temp <- dane_temp %>% select("Country", grade) %>% na.omit() 
    updateSelectInput(session, "country", choices = sort(dane_temp$Country))
  })
  
  output$barplot <- renderPlotly({
    
    if(input$subject == 0) dane_temp = math
    else dane_temp = science
    
    if(input$grade == "4th") grade = "four"
    else grade = "eight"
    
    dane_temp <- dane_temp %>% select("Country", grade) %>% na.omit() 
    colnames(dane_temp) <- c("Country", "Grade")
    dane_temp <- dane_temp %>% arrange(desc(Grade)) %>%
      mutate(sel =ifelse (Country %in% input$country, "red", "blue"))
    
    #ggplotly(p)
    p <- ggplot(dane_temp, aes(x= reorder(Country, Grade), y = Grade ,
                               fill = sel, text=sprintf("Country: %s<br>Score: %s", Country, Grade))) + 
      geom_bar(stat = "identity") +
      scale_fill_manual(values=c("deepskyblue1", "darkgoldenrod2")) +
      coord_flip() +
      theme_set(theme_minimal()) +
      theme(legend.position = "none") +
      ylab("") + xlab("Score")
    ggplotly(p, tooltip="text") %>%
      layout(xaxis = list(title = "Score"), yaxis = list(title = "")) 
  })
  
  
  
  output$scatterplot <- renderPlotly({
    
    if(input$subject == 0) dane_temp = math
    else dane_temp = science
    
    if(input$grade == "4th") grade = "four"
    else grade = "eight"
    
    dane_temp <- dane_temp %>% select("Country", grade, "Affluent") %>% na.omit() 
    colnames(dane_temp) <- c("Country", "Grade", "Affluent")
    dane_temp <- dane_temp %>% mutate(sel =ifelse (Country %in% input$country, "red", "blue"))
    
    
    #ggplotly(p)
    fig <- plot_ly(dane_temp, x = ~Grade, y = ~Affluent, 
                   type = 'scatter', mode = 'markers', 
                   hoverinfo = 'text',
                   text = ~paste('</br> Score: ', Grade,
                                 '</br> Affluent: ', Affluent,
                                 '</br> Country: ', Country),
                   transforms = list(
                     list(
                       type = 'groupby',
                       groups = dane_temp$sel,
                       styles = list(
                         list(target = "red", value = list(marker =list(color = 'darkgoldenrod2', size = 12))),
                         list(target = "blue", value = list(marker =list(color = 'deepskyblue1')))
                         
                       )
                     )
                   )
            ) %>%
      layout(xaxis = list(title = "Score"), yaxis = list(title = "Students attending more affluent schools in %")) 
    fig
  })
  
  
})
  