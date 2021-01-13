library(DT)
library(ggplot2)
library(plotly)
library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(reshape2)


function(input, output, session){

  read_achievement_trends <- function(file){

    path<-"data/"    
    path_file<-paste(path,file,sep="/")
    data <- read_excel(path_file)
    data<-data %>% drop_na(...3) 
    data<-data[c(3,5,7,9,11,13,15)]
    colnames(data)<-data[1,]
    data<-data[2:56,]
    data_long<-gather(data,year,score,2:7)
    data_long %>% arrange(Country) 
    data_clean<- data_long %>% drop_na(score)
    data_clean
  }
  
  read_achievement_trends2 <- function(file){

    path<-"data/" 
    path_file<-paste(path,file,sep="/")
    data <- read_excel(path_file)
    data<-data %>% drop_na(...3) 
    data<-data[c(3,seq(4,14,2))]
    colnames(data)<-data[1,]
    data<-data[2:56,]
    data_long<-gather(data,year,score,'2019':'1995')
    data_long %>% arrange(Country) 
    data_clean<- data_long %>% drop_na(score)
    data_clean
  }
  

  read_achievement_gender_trends <- function(file){

    path<-"./data" 
    path_file=paste(path,file,sep="/")
    data <- read_excel(path_file)
    data<-data %>% drop_na(...3) 
    data<-data[seq(3,27,2)]
    
    girls<-data[c(1,seq(2,12,2))]
    col_names<-girls[1,]
    colnames(girls)<-col_names
    girls<-girls[2:46,]
    girls_long<-gather(girls,year,score,2:7)
    girls_long <- mutate(girls_long,"sex"="girl")
    
    boys<-data[c(1,seq(3,13,2))]
    colnames(boys)<-col_names
    boys<-boys[2:46,]
    boys_long<-gather(boys,year,score,2:7)
    boys_long <- mutate(boys_long,"sex"="boys")
    
    data<-bind_rows(girls_long,boys_long)
    data_clean<- data %>% drop_na(score)
    data_clean
  }
  
  M4<-read_achievement_trends("1-3_achievement-trends-M4.xlsx")
  S4<-read_achievement_trends2("2-3_achievement-trends-S4.xlsx")
  M8<-read_achievement_trends("3-3_achievement-trends-M8.xlsx")
  S8<-read_achievement_trends("4-3_achievement-trends-S8.xlsx")
  
  M4G <-read_achievement_gender_trends("1-6_achievement-gender-trends-M4.xlsx")
  S4G <-read_achievement_gender_trends("2-6_achievement-gender-trends-S4.xlsx")
  M8G <-read_achievement_gender_trends("3-6_achievement-gender-trends-M8.xlsx")
  S8G <-read_achievement_gender_trends("4-6_achievement-gender-trends-S8.xlsx")
  
  
  
  output$plotly_1 <- renderPlotly({
    
    if(input$age==4){
      if(input$category=="Math"){trends<-M4}
      else {trends<-S4}
    }
    else if (input$age==8){
      if(input$category=="Math"){trends<-M8}
      else {trends<-S8}
    }
    
    if (input$country=="Poland"){
      trends<-trends %>% filter(Country=="Poland")
    }

    
    achievement_trends<-plot_ly(data=trends,y=~score,x=~year,color = ~Country,type = 'scatter',mode='lines')
    achievement_trends <- achievement_trends %>% layout(title= paste(" Trend of Average",input$category,"Achievement Across Assessment Years"))
  })
  
  output$plotly_2 <- renderPlotly({
    
    if(input$age==4){
      if(input$category=="Math"){trends<-M4G}
      else {trends<-S4G}
    }
    else if (input$age==8){
      if(input$category=="Math"){trends<-M8G}
      else {trends<-S8G}
    }
    
    if (input$country=="Poland"){
      trends<-trends %>% filter(Country=="Poland")
    }

    achievement_gender_trends <-plot_ly(data=trends,y=~score,x=~year,color = ~Country,type = 'scatter',mode='lines',linetype =~sex) 
    achievement_gender_trends <- achievement_gender_trends %>% layout(title= paste(" by sex"))
  })
  
}