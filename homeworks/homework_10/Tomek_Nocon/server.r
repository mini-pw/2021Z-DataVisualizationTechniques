library(plotly)
library(dplyr)
library(ggplot2)
library(gridExtra)

blank_theme <- theme_minimal()+
  theme(
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )

source("data_tooling.R")

function(input, output, session){
  
  observeEvent(input$boys, {
    df1 <- reactive({
      x <-  as.integer(colnames(boys)[2:7]) <= input$sliderData[2]
      y <- input$sliderData[1] <= as.integer(colnames(boys)[2:7])
      z <- c(1,x*y)
      z <- as.logical(z)
      dfb <- boys %>% select(colnames(boys)[z]) %>% filter(Country == input$input_1)
      n <- dim(dfb)
      df1 <- as.data.frame(unlist(matrix(dfb)[2:n[2]]))
      df2 <- as.data.frame(colnames(dfb)[2:n[2]])
      dfb <- cbind(df2, df1)
      colnames(dfb) <- c("year", "score")
      dfb <- dfb %>% na.omit()
      dfb
      
    })
    output$pl3 <- renderPlotly({
      plot_df <- df1()
      p <- ggplot(plot_df, aes(x = year, y = score)) + 
        geom_bar(stat = "identity", fill = "skyblue") + blank_theme
      ggplotly(p)
    })
  })
  observeEvent(input$girls, {
    df2 <- reactive({
      x <-  as.integer(colnames(girls)[2:7]) <= input$sliderData[2]
      y <- input$sliderData[1] <= as.integer(colnames(girls)[2:7])
      z <- c(1,x*y)
      z <- as.logical(z)
      dfg <- girls %>% select(colnames(girls)[z]) %>% filter(Country == input$input_1)
      n <- dim(dfg)
      df1 <- as.data.frame(unlist(matrix(dfg)[2:n[2]]))
      df2 <- as.data.frame(colnames(dfg)[2:n[2]])
      dfg <- cbind(df2, df1)
      colnames(dfg) <- c("year", "score")
      dfg <- dfg %>% na.omit()
      dfg
      
    })
    output$pl3 <- renderPlotly({
      plot_df <- df2()
      p <- ggplot(plot_df, aes(x = year, y = score)) + 
        geom_bar(stat = "identity", fill = "skyblue") + blank_theme
      ggplotly(p)
    })
  })
}