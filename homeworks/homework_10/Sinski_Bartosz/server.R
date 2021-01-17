library(plotly)
library(shiny)
library(dplyr)
library(ggplot2)
library(ggthemes)
source("readingData.R")
function(input,output,session){
  output$plot1 <- renderPlot({
    if(input$grade == 1){
      mplot <- ggplot(filter(Mt,Country == input$Countries,grade=="value4")) + geom_bar(aes(factor(year,levels = sort(year,decreasing=TRUE)),value),fill="darkorange3",stat = "identity")
    }else if(input$grade == 2){
      mplot <- ggplot(filter(Mt,Country == input$Countries,grade=="value8" )) + geom_bar(aes(factor(year,levels = sort(year,decreasing=TRUE)),value),fill="steelblue",stat = "identity")
    }else{
      mplot <- ggplot(filter(Mt,Country == input$Countries)) + geom_bar(aes(x = factor(year,levels = sort(unique(year),decreasing=TRUE)),y = value,fill=grade),stat = "identity",position = "dodge") +
        scale_fill_manual(labels= c("4th","8th"),values=c("darkorange3", "steelblue"))  
    }
    mplot <- mplot + ggtitle("Mathematics Achievement") + labs(x="Year",y ="Average Scale Score",fill="Grade") + theme_bw() + theme(legend.position="bottom")
    return(mplot)
  }) 
  output$plot2 <- renderPlot({
    if(input$grade == 1){
      splot <- ggplot(filter(St,Country == input$Countries,grade=="value4")) + geom_bar(aes(factor(year,levels = sort(year,decreasing=TRUE)),value),fill="darkorange3",stat = "identity")
    }else if(input$grade == 2){
      splot <- ggplot(filter(St,Country == input$Countries,grade=="value8" )) + geom_bar(aes(factor(year,levels = sort(year,decreasing=TRUE)),value),fill="steelblue",stat = "identity")
    }else{
      splot <- ggplot(filter(St,Country == input$Countries)) + geom_bar(aes(x = factor(year,levels = sort(unique(year),decreasing=TRUE)),y = value,fill=grade),stat = "identity",position = "dodge") +
        scale_fill_manual(labels= c("4th","8th"),values=c("darkorange3", "steelblue")) 
    }
    splot <- splot + ggtitle("Science Achievement") + labs(x="Year",y ="Average Scale Score",fill="Grade") + theme_bw() + theme(legend.position="bottom")
    return(splot)
  }) 
    
}