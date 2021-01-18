library(ggplot2)
library(dplyr)
library(plotly)
library(patchwork)

function(input, output, session){
  
  output$plot_1 <- renderPlotly({
    
    if (input$subject == "mathematics") {
      if (input$year == "4") {
        df <- M4
      }
      if (input$year == "8") {
        df <- M8
      }
    }
    if (input$subject == "science") {
      if (input$year == "4") {
        df <- S4
      }
      if (input$year == "8") {
        df <- S8
      }
    }
    df <- mutate(df,Color = ifelse(Country == input$country, "red", "gray"))
    
    
    p <- ggplot(df, aes(x = Country, y = Score, fill = Color)) +
      geom_col() +
      scale_y_continuous(expand = expansion(mult = c(0, 0))) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle=45, hjust = 1),
            legend.position = "none") +
      scale_fill_manual(name = "Country", values=c("gray","red")) +
      labs(x = "")
    ggplotly(p, tooltip = "Score", dynamicTicks = T) %>%
      config(displayModeBar = FALSE)
  })
  
  output$plot_2 <- renderPlot({
    
    if (input$subject == "mathematics") {
      if (input$year == "4") {
        df <- M4
      }
      if (input$year == "8") {
        df <- M8
      }
    }
    if (input$subject == "science") {
      if (input$year == "4") {
        df <- S4
      }
      if (input$year == "8") {
        df <- S8
      }
    }
    df <- filter(df, Country == input$country)
    if (nrow(df) == 1) {
      df1 <- data.frame(Gender = c("girls", "boys"), y = c(df$Girls_pc,df$Boys_pc))
      
      p1 <- ggplot(df1, aes(x = "", y = y, fill = Gender)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar("y", start=0)+
        scale_fill_manual(values=c("lightblue","pink")) +
        theme(panel.background = element_blank(),
              axis.text.x=element_blank()) +
        labs(x = "", y = "")
      
      df2 <- data.frame(Gender = c("girls", "boys"), Score = c(df$Girls_score,df$Boys_score))
      p2 <- ggplot(df2,aes(x = Gender, y = Score)) +
        geom_bar(stat = "identity", fill = "gray") +
        theme(panel.background = element_blank())
      
      p1 + p2
    }
    
    
  })
  
}