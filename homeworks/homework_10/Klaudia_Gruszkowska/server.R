library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(readxl)

function(input,output,session){
  M4_trends <- read_xlsx("./TIMSS-2019/1-3_achievement-trends-M4.xlsx",skip = 4) %>%
    select(3,5,7,9)%>%
    na.omit()
  M8_trends <- read_xlsx("./TIMSS-2019/3-3_achievement-trends-M8.xlsx",skip = 4) %>%
    select(2,4,6,8)%>%
    na.omit
  S4_trends <- read_xlsx("./TIMSS-2019/2-3_achievement-trends-S4.xlsx",skip = 4) %>%
    select(3,4,6,8)%>%
    na.omit()
  S8_trends <- read_xlsx("./TIMSS-2019/4-3_achievement-trends-S8.xlsx",skip = 4) %>%
    select(2,4,6,8)%>%
    na.omit()
    
  M4_gender <- read_xlsx("./TIMSS-2019/1-6_achievement-gender-trends-M4.xlsx",skip=6)%>%
    select(3,5,7,9,11,13,15)%>%
    na.omit
  colnames(M4_gender)<- c("Country","Score_2019_G","Score_2019_M","Score_2015_G","Score_2015_M","Score_2011_G","Score_2011_M")
  S4_gender <- read_xlsx("./TIMSS-2019/2-6_achievement-gender-trends-S4.xlsx",skip = 6)%>%
    select(3,5,7,9,11,13,15)%>%
    na.omit
  colnames(S4_gender)<- c("Country","Score_2019_G","Score_2019_M","Score_2015_G","Score_2015_M","Score_2011_G","Score_2011_M")
  M8_gender <- read_xlsx("./TIMSS-2019/3-6_achievement-gender-trends-M8.xlsx",skip = 6)%>%
    select(2,4,6,8,10,12,14)%>%
    na.omit()
  colnames(M8_gender)<- c("Country","Score_2019_G","Score_2019_M","Score_2015_G","Score_2015_M","Score_2011_G","Score_2011_M")
  S8_gender <- read_xlsx("./TIMSS-2019/4-6_achievement-gender-trends-S8.xlsx",skip = 6)%>%
    select(2,4,6,8,10,12,14)%>%
    na.omit()
  colnames(S8_gender)<- c("Country","Score_2019_G","Score_2019_M","Score_2015_G","Score_2015_M","Score_2011_G","Score_2011_M")
  
  
  
  output$boxplot <- renderPlotly({
    years <- input$years
    if(length(years)==0){
      ggplot() + 
        xlim(0, 10) +
        ylim(0, 10) +
        theme_light() +
        geom_text(aes(5, 5, label = 'Zaznacz jakiś rok!'), size = 10) +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank())
    }else{
    
    country_1 <- input$country_1
    if(input$przedmiot=="Matematyka"){
      if(input$klasa=="4"){
        y <- M4_trends%>%
          filter(Country == country_1)
      }
      else{
        y <- M8_trends%>%
          filter(Country == country_1)
      }}
    
    else{
      if(input$klasa=="4"){
        y <- S4_trends%>%
          filter(Country == country_1)}
      else{
        y <- S8_trends%>%
          filter(Country == country_1)
      }
    }
    scores<- c()
    for(year in years){
      scores<- c(scores,y%>%pull(year))
    }
    df <- data.frame(scores = scores,years = years)%>%
      rename("rok" = "years")%>%
      rename("wynik" = "scores")
    p <- ggplot(df,aes(x = rok,y = wynik))+
      geom_bar(stat = "identity",fill = "#F8766D")+
      theme_light()+
      ggtitle("Wyniki TIMSS dla państwa 1 w wybranych latach")
    ggplotly(p)}
  })
  
  output$boxplot_2 <- renderPlotly({
    years <- input$years
    if(length(years)==0){
      ggplot() + 
        xlim(0, 10) +
        ylim(0, 10) +
        theme_light() +
        geom_text(aes(5, 5, label = 'Zaznacz jakiś rok!'), size = 10) +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank())
    }else{
    
    country_2 <- input$country_2
    if(input$przedmiot=="Matematyka"){
      if(input$klasa=="4"){
        y <- M4_trends%>%
          filter(Country == country_2)}
      else{
        y <- M8_trends%>%
          filter(Country == country_2)
      }}
    
    else{
      if(input$klasa=="4"){
        y <- S4_trends%>%
          filter(Country == country_2)}
      else{
        y <- S8_trends%>%
          filter(Country == country_2)
      }
    }
    scores<- c()
    for(year in years){
      scores<- c(scores,y%>%pull(year))
    }
    df <- data.frame(scores = scores,years = years)%>%
      rename("rok" = "years")%>%
      rename("wynik" = "scores")
    p <- ggplot(df,aes(x = rok,y = wynik))+
      geom_bar(stat = "identity",fill = "#00BFC4")+
      theme_light()+
      ggtitle("Wyniki TIMSS dla państwa 2 w wybranych latach")
    ggplotly(p)}
  })
  
  
  output$boxplot_3 <- renderPlotly({
    country <- c()
    years <- input$years
    if(input$country_1==input$country_2){
      ggplot() + 
        xlim(0, 10) +
        ylim(0, 10) +
        theme_light() +
        geom_text(aes(5, 5, label = 'Zmień państwa na różne!'), size = 10) +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank())
    }else if(length(years)==0){
      ggplot() + 
        xlim(0, 10) +
        ylim(0, 10) +
        theme_light() +
        geom_text(aes(5, 5, label = 'Zaznacz jakiś rok!'), size = 10) +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank())
    }else{
    
    
    for(year in years){
      country <- c(country,input$country_1,input$country_2)
    }
    
    
    if(input$przedmiot=="Matematyka"){
      if(input$klasa=="4"){
        y_1 <- M4_trends%>%
          filter(Country == country[1])
      y_2 <- M4_trends%>%
        filter(Country == country[2])}
      else{
        y_1 <- M8_trends%>%
          filter(Country == country[1])
        y_2 <- M8_trends%>%
          filter(Country == country[2])
      }}
    
    else{
      if(input$klasa=="4"){
        y_1 <- S4_trends%>%
          filter(Country == country[1])
        y_2 <- S4_trends%>%
          filter(Country == country[2])}
      else{
        y_1 <- S8_trends%>%
          filter(Country == country[1])
        y_2 <- S8_trends%>%
          filter(Country == country[2])
      }
    }
    
    
    scores<- c()
    for(year in years){
      scores<- c(scores,y_1%>%pull(year),y_2%>%pull(year))
    } 
    
    years_2 <- c()
    a <- 1:length(years)
    for(j in a){
      for(i in c(1,2)){
        years_2 <- c(years_2,years[j])
    }}
    
    
    df <- data.frame(country = country, scores = scores, years_2 = years_2)%>%
      rename("rok" = "years_2")%>%
      rename("wynik" = "scores")
    
    panstwo <- factor(country,levels = c(country[1],country[2]))
    
    
    
    p <- ggplot(df,aes(x = rok,y = wynik,fill = panstwo))+
      geom_bar(stat = "identity",position=position_dodge())+
      theme_light()+
      theme(legend.title = element_blank())+
      ggtitle("Porównanie wyników TIMSS dla wybranych państw")
    ggplotly(p)}
  })
  
  
  output$gender_plot <- renderPlotly({
    country_1 <- input$country_1
    country_2 <- input$country_2
    years <- input$years
    
    if(input$country_1==input$country_2){
      ggplot() + 
        xlim(0, 10) +
        ylim(0, 10) +
        theme_light() +
        geom_text(aes(5, 5, label = 'Zmień państwa na różne!'), size = 10) +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank())
    }else if(length(years)==0){
      ggplot() + 
        xlim(0, 10) +
        ylim(0, 10) +
        theme_light() +
        geom_text(aes(5, 5, label = 'Zaznacz jakiś rok!'), size = 10) +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank())
    }else{
      
    
    if(input$przedmiot=="Matematyka"){
      if(input$klasa=="4"){
        y_1 <- M4_gender%>%
          filter(Country == country_1)
        y_2 <- M4_gender%>%
          filter(Country == country_2)
        
      }else{
        y_1 <- M8_gender%>%
          filter(Country == country_1)
        y_2 <- M8_gender%>%
          filter(Country == country_2)
      }
    }else{
      if(input$klasa == "4"){
        y_1 <- S4_gender%>%
          filter(Country == country_1)
        y_2 <- S4_gender%>%
          filter(Country == country_2)
      }else{
        y_1 <- S8_gender%>%
          filter(Country == country_1)
        y_2 <- S8_gender%>%
          filter(Country == country_2)
      }
    }
    country <- c()
    for(year in years){
      country <- c(country,input$country_1,input$country_1)
    }
    for(year in years){
      country <- c(country,input$country_2,input$country_2)
    }
    
    years_2 <- c()
    a <- 1:length(years)
    for(j in a){
      for(i in c(1,2)){
        years_2 <- c(years_2,years[j])
      }}
    for(j in a){
      for(i in c(1,2)){
        years_2 <- c(years_2,years[j])
      }}
    gender <- c()
    for(j in a){
      for(i in c("dziewczynki","chłopcy")){
        gender <- c(gender,i)
      }}
    for(j in a){
      for(i in c("dziewczynki","chłopcy")){
        gender <- c(gender,i)
      }}
    scores <- c()
    for(year in years){
      if(year == "2019"){
        scores <- c(scores,y_1%>%pull("Score_2019_G"),y_1%>%pull("Score_2019_M"))
      }else if(year == "2015"){
        scores <- c(scores,y_1%>%pull("Score_2015_G"),y_1%>%pull("Score_2015_M"))
      }else if(year == "2011")
        scores <- c(scores,y_1%>%pull("Score_2011_G"),y_1%>%pull("Score_2011_M"))
    }
    for(year in years){
      if(year == "2019"){
        scores <- c(scores,y_2%>%pull("Score_2019_G"),y_2%>%pull("Score_2019_M"))
      }else if(year == "2015"){
        scores <- c(scores,y_2%>%pull("Score_2015_G"),y_2%>%pull("Score_2015_M"))
      }else if(year == "2011")
        scores <- c(scores,y_2%>%pull("Score_2011_G"),y_2%>%pull("Score_2011_M"))
    }
    df <- data.frame(country = country, scores = scores, years_2 = years_2,gender = gender)%>%
      rename("rok" = "years_2")%>%
      rename("wynik" = "scores")
    
    panstwo <- factor(country,levels = c(country_1,country_2))
    plec <- factor(gender,levels = c("dziewczynki","chłopcy"))
    
    p <- ggplot(df,aes(x = rok,y = wynik,color = panstwo,shape = plec))+
      geom_point()+
      theme_light()+
      theme(legend.title = element_blank())+
      ggtitle("Wyniki TIMSS dla wybranych państw z podziałem na płeć")
    ggplotly(p)}
  })
  
}