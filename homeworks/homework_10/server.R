library(DT)
library(ggplot2)
library(plotly)


server <- function(input, output, session){

  #reading data
  grade_4 <- readxl::read_excel("8-13_student-bullying-S4.xlsx", range = "C6:X64", col_types = c("text","text", 
                                                                                                 "text", "numeric","text", 
                                                                                                 "text" ,"numeric", "text", 
                                                                                                 "text", "numeric", "text",
                                                                                                 "text", "numeric", "text",
                                                                                                 "text", "numeric", "text",
                                                                                                 "text", "numeric", "text",
                                                                                                 "text", "numeric"
                                                                                                 
  ))
  grade_4 <- grade_4[ , c(1, 4, 7, 10,  13, 16, 19, 22)]
  colnames(grade_4) <- c("Country", "Never_percent", "Never_avg","Monthly_percent", "Monthly_avg", "Weekly_percent", "Weekly_avg", "Avg_score")                                                                                                              
  
  grade_8 <- readxl::read_excel("8-16_student-bullying-S8.xlsx", range = "C6:X44", col_types = c("text","text", 
                                                                                                 "text", "numeric","text", 
                                                                                                 "text" ,"numeric", "text", 
                                                                                                 "text", "numeric", "text",
                                                                                                 "text", "numeric", "text",
                                                                                                 "text", "numeric", "text",
                                                                                                 "text", "numeric", "text",
                                                                                                 "text", "numeric"
                                                                                                 
  ))
  grade_8 <- grade_8[ , c(1, 4, 7, 10,  13, 16, 19, 22)]
  colnames(grade_8) <- c("Country", "Never_percent", "Never_avg","Monthly_percent", "Monthly_avg", "Weekly_percent", "Weekly_avg", "Avg_score")                                                                                                              
  
  
  #ranking
  ranking_4th <- grade_4 %>% arrange(desc(Avg_score))  %>% head(5) %>% select(c("Country", "Avg_score"))
  colnames(ranking_4th) <- c("Country", "Average score")
  ranking_8th <- grade_8 %>% arrange(desc(Avg_score)) %>% head(5)%>% select(c("Country", "Avg_score"))
  colnames(ranking_8th) <- c("Country", "Average score")

  
  #render tables
  output$table1 <- renderTable({ranking_4th})
 
  output$table2 <- renderTable({ranking_8th})
  
  
  
  #render 4th grade plot
  output$grade_4th_plot <- renderPlotly({
    if(input$radio4th == "Never or almost Never") {
      grade_4 <- grade_4 %>% arrange(Never_avg) 
    } 
    else if(input$radio4th == "About Monthly"){ 
      grade_4<- grade_4 %>% arrange(Monthly_avg) 
    }
    else{ 
      grade_4 <- grade_4 %>% arrange(Weekly_avg) 
    }
    
    a <- grade_4 %>% filter(Never_avg != -1)
    b <- grade_4 %>% filter(Monthly_avg != -1)
    c <- grade_4 %>% filter(Weekly_avg != -1) 
    min <- min(c(c$Never_avg, c$Monthly_avg, c$Weekly_avg)) - 20
    max <- max(c(c$Never_avg, c$Monthly_avg, c$Weekly_avg)) + 20
    
    p <- ggplot(grade_4, aes(x=factor(x=Country,levels=Country), y=0)) + 
      geom_point(aes(y=Never_avg),color="green", size=2) +
      geom_point(aes(y=Monthly_avg), color="yellow", size=2) +
      geom_point(aes(y=Weekly_avg), color="red", size=2) +
      coord_flip() + scale_y_continuous(limits = c(min, max)) + 
      ggtitle("Student bullying - average achievement among countries")+ 
      xlab("Country") + ylab("Average achievement") +
      theme_light() +
      theme(
        text = element_text(size=10),
      )
    ggplotly(p)
  })
  
 
 
  
  #render 8th grade plot
  output$grade_8th_plot <- renderPlotly({
    if(input$radio8th == "Never or almost Never") {
      grade_8 <- grade_8 %>% arrange(Never_avg) 
    } 
    else if(input$radio8th == "About Monthly"){ 
      grade_8<- grade_8 %>% arrange(Monthly_avg) 
    }
    else{ 
      grade_8 <- grade_8 %>% arrange(Weekly_avg) 
    }
    
    a <- grade_8 %>% filter(Never_avg != -1)
    b <- grade_8 %>% filter(Monthly_avg != -1)
    c <- grade_8 %>% filter(Weekly_avg != -1) 
    min <- min(c(a$Never_avg, b$Monthly_avg, c$Weekly_avg)) - 20
    max <- max(c(a$Never_avg, b$Monthly_avg, c$Weekly_avg)) + 20
    
    p <- ggplot(grade_8, aes(x=factor(x=Country,levels=Country))) +
      geom_point(aes(y=Never_avg),color="green", size=2) +
      geom_point(aes(y=Monthly_avg), color="yellow", size=2) +
      geom_point(aes(y=Weekly_avg), color="red", size=2) +
      coord_flip() + scale_y_continuous(limits = c(min, max)) + ggtitle("Student bullying - average achievement among countries") +  
      xlab("Country") + ylab("Average achievement") + 
      theme_light()+ theme(
        text = element_text(size=10),
      )
    ggplotly(p)
  })
  

}