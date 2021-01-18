library(DT)
library(ggplot2)
library(readxl)
library(dplyr)
library(tidyr)

function(input, output, session){
  
  trends_M4 <- read_excel("data/1-3_achievement-trends-M4.xlsx", range = "C6:P58")[ -1, rep(c(TRUE,FALSE),7) ]
  trends_S4 <- read_excel("data/2-3_achievement-trends-S4.xlsx", range = "C6:P58")[ -1, rep(c(TRUE,FALSE),7) ]
  trends_M8 <- read_excel("data/3-3_achievement-trends-M8.xlsx", range = "C6:P58")[ -1, rep(c(TRUE,FALSE),7) ]
  trends_S8 <- read_excel("data/4-3_achievement-trends-S8.xlsx", range = "C6:P58")[ -1, rep(c(TRUE,FALSE),7) ]
  gender_trends_M4 <- read_excel("data/1-6_achievement-gender-trends-M4.xlsx", range = "C6:AB58", col_types = c("text", 
                                                                                                                "numeric", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "numeric", "numeric", 
                                                                                                                "text"))[ -1, rep(c(TRUE,FALSE),13) ]
  gender_trends_S4 <- read_excel("data/2-6_achievement-gender-trends-S4.xlsx", range = "C6:AB58", col_types = c("text", 
                                                                                                                "numeric", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "numeric", "numeric", 
                                                                                                                "text"))[ -1, rep(c(TRUE,FALSE),13) ]
  gender_trends_M8 <- read_excel("data/3-6_achievement-gender-trends-M8.xlsx", range = "C6:AB58", col_types = c("text", 
                                                                                                                "numeric", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "numeric", "numeric", 
                                                                                                                "text"))[ -1, rep(c(TRUE,FALSE),13) ]
  gender_trends_S8 <- read_excel("data/4-6_achievement-gender-trends-S8.xlsx", range = "C6:AB58", col_types = c("text", 
                                                                                                                "numeric", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "text", "numeric", 
                                                                                                                "text", "numeric", "numeric", "numeric", 
                                                                                                                "text"))[ -1, rep(c(TRUE,FALSE),13) ]
 
  
  output$plot_1 <- renderPlotly({
    Countries <- trends_M4$Country
    
    
    przedmiot <- input$przedmiot
    kraj <- input$kraj
    klasa <- input$klasa
    
    
    if(przedmiot == "Matematyka"){
      if(klasa == "4"){
        d <- trends_M4

      }
      else{
        d <-trends_M8

      }
    }
    else{
      if(klasa == "4"){
        d <- trends_S4

      }
      else{
        d <-trends_S8

      }
    }
    
    d <- d %>% filter(Country == kraj)
    b <- data.frame(as.numeric(colnames(d)[-1]),t(d[1,-1]))
    colnames(b) <- c("rok","pkt")
    p<- ggplot(b[!is.na(b$pkt),]) +
      geom_line(aes(x=rok,y=pkt), size=2,na.rm = TRUE) +
      ylim(0,700) +
      
      scale_x_continuous(breaks = seq(1995, 2019, by = 4), limits = c(1995,2019))+
      theme_minimal()+
      labs(title = "Wyniki w latach",x="",y="punkty")
    
    ggplotly(p)
  })
  output$plot_2 <- renderPlotly({
    
    Countries <- trends_M4$Country
    
    
    przedmiot <- input$przedmiot
    kraj <- input$kraj
    klasa <- input$klasa
    
    
    if(przedmiot == "Matematyka"){
      if(klasa == "4"){

        q <- gender_trends_M4
      }
      else{

        q <- gender_trends_M8
      }
    }
    else{
      if(klasa == "4"){

        q <- gender_trends_S4
      }
      else{

        q <- gender_trends_S8
      }
    }
    q<-q %>% filter(Country==kraj)
    #jest na odwrót xd
    boys <- data.frame(c(2019,2015,2011,2007,2003,1995),t(q[1,c(rep(c(FALSE,TRUE),6),FALSE)]))
    girls <- data.frame(c(2019,2015,2011,2007,2003,1995),as.numeric(t(q[1,c(rep(c(TRUE,FALSE),6),TRUE)])[-1]))
    colnames(boys) <- c("Rok","pktB")
    colnames(girls) <- c("Rok","pktG")
    bag <- merge(boys,girls)
    
    x<- ggplot(bag[!is.na(bag$pktB),]) +
      geom_line(aes(x=Rok,y=pktB, color="Dziewczyny"), size=1,na.rm = TRUE,alpha=.5) +
      geom_line(aes(x=Rok,y=pktG, color="Chłopcy"), size=1,na.rm = TRUE,alpha=.5) +
      scale_color_manual(values = c(
        'Dziewczyny' = 'red',
        'Chłopcy' = 'blue')) +
      
      ylim(0,700) +
      scale_x_continuous(breaks = seq(1995, 2019, by = 4))+
      xlim(1995,2019)+
      theme_minimal()+
      theme(legend.position="bottom") +
      labs(title = "Wyniki w latach z podziałem na płeć",x="",y="punkty")
    
    f <- ggplotly(x) %>% layout(legend = list(orientation = 'h'))
    f
  })
  
} 


  


