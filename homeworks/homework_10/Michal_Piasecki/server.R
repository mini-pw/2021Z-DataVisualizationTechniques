function(input, output, session){
output$wykres1 <- renderPlotly({
  
  # which data you choose:
  if (input$Subject == "Mathematics") {
    if(input$Grade == "IV") {
      df <- Math_4
    }
    else {
      df <- Math_8
    }
  }
  else {
    if(input$Grade == "IV") {
      df <- Science_4
    }
    else {
      df <- Science_8
    }
  }
  
  # how many
  if (input$top == "10 best countries") {
    df <- head(df,10)
  }
  else if (input$top == "30 best countries") {
    df <- head(df,30)
  }
  else if (input$top == "10 worst countries") {
    df <- tail(df,10)
  }
  else if (input$top == "30 worst countries") {
    df <- tail(df,30)
    
  }
  else {
    df <- df %>% 
      arrange(desc(Score))
  }
  result <- ggplot(data=df, aes(x = Country, y = Score)) +
    geom_bar(stat = "identity", width= 0.8) +
    scale_fill_manual(name = "Country", values=c("#ECDD7B","#561D25")) +
    theme(panel.background = element_blank(),
          axis.text.x = element_text(size=10, angle=70),
          axis.title.x = element_blank())
  ggplotly(result, tooltip = "Score", dynamicTicks = T)  })
output$text1 <- renderText({ 
  "Graph shows average results for particular countries"})
}
