library(ggplot2)
library(plotly)
library("readxl")
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
source("Data.R")

shinyApp(
  ui =pageWithSidebar(
    headerPanel("TIMSS Dashboard"),
    sidebarPanel(
      selectInput("plot_country",
                  label = "Country:",
                  choices = M4%>%pull(Country),
                  selected = 1),
      selectInput("plot_grade",
                  label = "Grade:",
                  choices = list("4th" = 4, "8th" = 8),
                  selected = 1),
      
    ),
    mainPanel(
      plotOutput("plot_1"),
      plotOutput("plot_2"),
      plotOutput("plot_3")
    )
  ),
  server =function(input, output, session){
    output$plot_1 <- renderPlot({
      if(input$plot_grade==4){
        plot_data<-M4[M4$Country==input$plot_country,]
        plot_data<-gather(plot_data,Year,Value,2:7,factor_key=FALSE)%>%drop_na(Value)
        p<-ggplot(plot_data, aes(x = Year, y = Value)) +
          ggtitle("Math Score at 4th grade")+
          geom_bar(stat="identity",fill="steelblue")+
          geom_text(aes(x=Year,y=Value,label=Value),vjust=-0.5) +
          theme_classic()+
          scale_y_continuous(expand = c(0, 0), limits = c(0, 650)) + theme(text = element_text(size=15)) + ylab("Score")
      }else{
        plot_data<-M8[M8$Country==input$plot_country,]
        plot_data<-gather(plot_data,Year,Value,2:7,factor_key=FALSE)%>%drop_na(Value)
        p<-ggplot(plot_data, aes(x = Year, y = Value)) +
          ggtitle("Math Score in 8th grade")+
          geom_bar(stat="identity",fill="steelblue")+
          geom_text(aes(x=Year,y=Value,label=Value),vjust=-0.5) +
          theme_classic()+
          scale_y_continuous(expand = c(0, 0), limits = c(0, 650)) + theme(text = element_text(size=15)) + ylab("Score")
      }
      if(nrow(plot_data)==0)
        p<-ggplot() + 
          xlim(0, 10) +
          ylim(0, 10) +
          theme_void() +
          geom_text(aes(5, 5, label = 'We don\'t have this data :('), size = 10)
      p
    })
    
    output$plot_2 <- renderPlot({
      if(input$plot_grade==4){
        plot_data<-S4[S4$Country==input$plot_country,]
        plot_data<-gather(plot_data,Year,Value,2:7,factor_key=FALSE)%>%drop_na(Value)
        p<-ggplot(plot_data, aes(x = Year, y = Value)) +
          ggtitle("Sciene Score in 4th grade")+
          geom_bar(stat="identity",fill="Orange")+
          geom_text(aes(x=Year,y=Value,label=Value),vjust=-0.5) +
          theme_classic()+
          scale_y_continuous(expand = c(0, 0), limits = c(0, 650)) + theme(text = element_text(size=15)) + ylab("Score")
      }else{
        plot_data<-S8[S8$Country==input$plot_country,]
        plot_data<-gather(plot_data,Year,Value,2:7,factor_key=FALSE)%>%drop_na(Value)
        p<-ggplot(plot_data, aes(x = Year, y = Value)) +
          ggtitle("Science Score at 8th grade")+
          geom_bar(stat="identity",fill="Orange")+
          geom_text(aes(x=Year,y=Value,label=Value),vjust=-0.5) +
          theme_classic()+
          scale_y_continuous(expand = c(0, 0), limits = c(0, 650)) + theme(text = element_text(size=15)) + ylab("Score")
      }
      if(nrow(plot_data)==0)
        p<-ggplot() + 
          xlim(0, 10) +
          ylim(0, 10) +
          theme_void()
      p})
    
    output$plot_3 <- renderPlot({
      if(input$plot_grade==4){
        plot_dataM<-M4[M4$Country==input$plot_country,]
        plot_dataS<-S4[S4$Country==input$plot_country,]
        plot_dataM<-gather(plot_dataM,Year,Value,2:7,factor_key=FALSE)%>%drop_na(Value)
        plot_dataS<-gather(plot_dataS,Year,Value,2:7,factor_key=FALSE)%>%drop_na(Value)
        Diff<-plot_dataS
        Diff[,"Value"]=plot_dataM[,"Value"]-plot_dataS[,"Value"]
        Diff<- Diff[seq(dim(Diff)[1],1),]
        p<-ggplot(Diff, aes(x = Year, y = Value,fill=Value)) +
          ggtitle("Diffrence in scores (Math Score - Science Score)")+
          geom_bar(stat="identity")+
          geom_text(aes(x=Year,y=Value,label=Value),vjust=-0.5) +
          theme_classic()+
          scale_y_continuous(expand = c(0, 0), limits = c(-50, 50)) + theme(text = element_text(size=15)) + ylab("Score diffrence")+
          scale_fill_gradient2(low="red", mid='snow3', 
                               high="darkgreen", space='Lab')+ 
          theme(legend.position = "none")
      }else{
        plot_dataM<-M8[M8$Country==input$plot_country,]
        plot_dataS<-S8[S8$Country==input$plot_country,]
        plot_dataM<-gather(plot_dataM,Year,Value,2:7,factor_key=FALSE)%>%drop_na(Value)
        plot_dataS<-gather(plot_dataS,Year,Value,2:7,factor_key=FALSE)%>%drop_na(Value)
        Diff<-plot_dataS
        Diff[,"Value"]=plot_dataM[,"Value"]-plot_dataS[,"Value"]
        Diff<- Diff[seq(dim(Diff)[1],1),]
        p<-ggplot(Diff, aes(x = Year, y = Value,fill=Value)) +
          ggtitle("Diffrence in scores (Math Score - Science Score)")+
          geom_bar(stat="identity")+
          geom_text(aes(x=Year,y=Value,label=Value),vjust=-0.5) +
          theme_classic()+
          scale_y_continuous(expand = c(0, 0), limits = c(-50, 50)) + theme(text = element_text(size=15)) + ylab("Score diffrence")+
          scale_fill_gradient2(low="red", mid='snow3', 
                               high="darkgreen", space='Lab')+ 
          theme(legend.position = "none")
      }
      if(nrow(plot_dataM)==0)
        p<-ggplot() + 
          xlim(0, 10) +
          ylim(0, 10) +
          theme_void()
      p})
  }
)
