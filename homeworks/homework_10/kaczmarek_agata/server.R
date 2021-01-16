library(DT)
library(ggplot2)
library(gridExtra)
library(ggalt)


function(input, output, session){
  
  output$barchart_1<- renderPlotly({
    
    if(input$grade_choice=="4th" && input$subject_choice=="Math"){
      M4<-read.csv("math_4_grade_score.csv")
    }else if(input$grade_choice=="8th" && input$subject_choice=="Math"){
      M4<-read.csv("math_8_grade_score.csv")
    }else if(input$grade_choice=="4th" && input$subject_choice=="Science"){
      M4<-read.csv("science_4_grade_score.csv")
    }else{
      M4<-read.csv("science_8_grade_score.csv")
    }
    
    chosen<-1:input$number_countries
    chosen_country <- rep("rgba(19,82,211,1)", length(M4$Country))
    chosen_country
    chosen_country[M4$Country==input$country_choice]<-'rgba(255,130,0,1)'
    df <- data.frame(M4,chosen_country, stringsAsFactors = FALSE)
    data<-df[chosen, ]
    Country <-data$Country
    Score<-data$Score
    f <- list(family = "Courier New, monospace",
              size = 20,
              color = "#012345"
    )
    x <- list(title = "Country",
              titlefont = f
    )
    y <- list(title = "Score",
              titlefont = f
    )
    fig <- plot_ly(data, x = ~factor(data$Country, levels =data$Country), y = ~Score, type = 'bar',
                   marker = list(color = chosen_country))
    fig <- fig %>% layout(title = "Average score in different countries",xaxis = x, yaxis = y)
    
    fig
    
    
    
  })
  
  
  output$linegraph_1<- renderPlotly({
    
    if(input$grade_choice=="4th" && input$subject_choice=="Math"){
      M4<-read.csv("gender_math_4.csv")
    }else if(input$grade_choice=="8th" && input$subject_choice=="Math"){
      M4<-read.csv("gender_math_8.csv")
    }else if(input$grade_choice=="4th" && input$subject_choice=="Science"){
      M4<-read.csv("gender_science_4.csv")
    }else{
      M4<-read.csv("gender_science_8.csv")
    }
    M4
    df<-M4
    x <- c(1:length(df$Countries))
    data <- data.frame(x,df)
    f <- list(family = "Courier New, monospace",
              size = 20,
              color = "#012345"
    )
    x <- list(title = "Country",
              titlefont = f
    )
    if(input$gender_choice=="Girls"){
      y <- list(title = "Average Score - Girls",
                titlefont = f
      )
      fig <- plot_ly(data, x=~Countries, y= ~Girls, name = 'Girls',  type = 'scatter', mode = 'markers', marker = list(color = c('rgba(19,82,211,1)'))) 
      fig <- fig %>%
        layout(hovermode = "x unified",xaxis = x, yaxis = y)
      fig
    }else if(input$gender_choice=="Boys"){
      y <- list(title = "Average Score - Boys",
                titlefont = f
      )
      fig <- plot_ly(data, x=~Countries, y= ~Boys, name = 'Girls',  type = 'scatter', mode = 'markers', marker = list(color = c('rgba(255,130,0,1)')) )
      fig <- fig %>%
        layout(hovermode = "x unified",xaxis = x, yaxis = y)
      fig
    }else{
      y <- list(title = "Average Score by Gender",
                titlefont = f
      )
      fig <- plot_ly(data, x=~Countries, y= ~Girls, name = 'Girls',  type = 'scatter', mode = 'markers') 
      fig <- fig %>% add_trace(y = ~Boys, name = 'Boys', mode = 'markers')
      fig <- fig %>%
        layout(hovermode = "x unified",xaxis = x, yaxis = y, title = "Average score in different countries by gender")
      fig 
    }
  })
  
}

