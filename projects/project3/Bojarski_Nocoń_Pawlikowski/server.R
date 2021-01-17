library(plotly)
library(dplyr)
library(ggplot2)
library(gridExtra)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source("autocorrelation.R")
source("weekly.R")

blank_theme <- theme_minimal()+
  theme(
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=18, face="bold", color = "darkgreen"),
    axis.text = element_text(color = "darkgreen", size = 10),
    axis.title = element_text(color = "darkgreen", size = 10)
  )
weekDay <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
monthVec <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

function(input, output, session){
  data<-read.csv("Source_data/plot_data.csv")
  data<-data%>%
    mutate(speed=1000*distance_km/3600/time_h)
  bool<-reactiveVal(TRUE)
  
    output$plotly<-renderPlot({
    if (input$input_1=="t"){
      plt<-data%>%
        ggplot(aes(x=precipitation_type,y=time_h))+
        theme(
          title = element_text(color = "darkgreen", size = 30),
          axis.title = element_text(color = "darkgreen", size = 18),
          axis.text = element_text(color = "darkgreen", size = 18), 
          panel.background = element_blank(),
          axis.line = element_line(colour = "darkgreen"),
          panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
          axis.ticks = element_line(color = "darkgreen")
        ) +
       stat_boxplot(geom='errorbar')+ geom_boxplot(fill="#57a800") + ylab("running time (h)") + xlab("precipitation type") +
        ylim(0,2.5)+
        ggtitle("Time")
    }else if(input$input_1=="s"){
      plt<-data%>%
        ggplot(aes(x=precipitation_type,y=distance_km))+
        stat_boxplot(geom='errorbar')+geom_boxplot(fill="#57a800")+
        
        ylab("distance run (km)")+
        xlab("precipitation type") +
        ylim(0,24)+
        theme(
          title = element_text(color = "darkgreen", size = 30),
          axis.title = element_text(color = "darkgreen", size = 18),
          axis.text = element_text(color = "darkgreen", size = 18), 
          panel.background = element_blank(),
          axis.line = element_line(colour = "darkgreen"),
          panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
          axis.ticks = element_line(color = "darkgreen")
        ) +
        ggtitle("Distance")
    }else if(input$input_1=="v"){
      plt<-data%>%
        ggplot(aes(x=precipitation_type,y=speed))+
        theme(
          title = element_text(color = "darkgreen", size = 30),
          axis.title = element_text(color = "darkgreen", size = 18),
          axis.text = element_text(color = "darkgreen", size = 18), 
          panel.background = element_blank(),
          axis.line = element_line(colour = "darkgreen"),
          panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
          axis.ticks = element_line(color = "darkgreen")
        ) +
        ylab("running speed (m/s)")+
        xlab("precipitation type") +
        stat_boxplot(geom='errorbar')+
        geom_boxplot(fill="#57a800")+
        ylim(0,3.75)+
        ggtitle("Running speed")
    }
      plt
  })
  
    output$plotly4<-renderPlotly({
      if(is.null(input$test$x)){
      if(input$input_1=='v'){
        plt<-data%>%
          ggplot(aes(x=temperature,y=speed))+
          ylab("running speed (m/s)")+
          ylim(0,3.75)+
          xlab("temperature (\u00B0C)")+
          theme(
            title = element_text(color = "darkgreen", size = 30),
            axis.title = element_text(color = "darkgreen", size = 14),
            axis.text = element_text(color = "darkgreen", size = 14), 
            panel.background = element_blank(),
            axis.line = element_line(colour = "darkgreen"),
            panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
            axis.ticks = element_line(color = "darkgreen")
          ) +
          geom_point(color="#57a800") +
          scale_x_continuous(breaks = seq(-10, 40, 4))
      }else if(input$input_1=='s'){
        plt<-data%>%
          ggplot(aes(x=temperature,y=distance_km))+
          geom_point(color="#57a800")+
          ylab("distance run (km)")+
          xlab("temperature  (\u00B0C)")+
          theme(
            title = element_text(color = "darkgreen", size = 30),
            axis.title = element_text(color = "darkgreen", size = 14),
            axis.text = element_text(color = "darkgreen", size = 14), 
            panel.background = element_blank(),
            axis.line = element_line(colour = "darkgreen"),
            panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
            axis.ticks = element_line(color = "darkgreen")
          )+
          scale_x_continuous(breaks = seq(-10, 40, 4))
      }else if(input$input_1=='t'){
        plt<-data%>%
          ggplot(aes(x=temperature,y=time_h))+
          ylab("running time (h)")+
          xlab("temperature (\u00B0C)")+
          theme(
            title = element_text(color = "darkgreen", size = 30),
            axis.title = element_text(color = "darkgreen", size = 14),
            axis.text = element_text(color = "darkgreen", size = 14), 
            panel.background = element_blank(),
            axis.line = element_line(colour = "darkgreen"),
            panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
            axis.ticks = element_line(color = "darkgreen")
          ) +
          geom_point(color="#57a800")+
          scale_x_continuous(breaks = seq(-10, 40, 4))}
      ggplotly(plt)
      }else{
        if(input$test$x<1.5){
          data<-data%>%
            mutate(color=ifelse(precipitation_type=="dry","darkgreen","#57a800"),
                   alpha=ifelse(precipitation_type=="dry",1,0.2))
        }
        if(input$test$x>=1.5&input$test$x<2.5){
          data<-data%>%
            mutate(color=ifelse(precipitation_type=="rain","darkgreen","#57a800"),
                   alpha=ifelse(precipitation_type=="rain",1,0.2))
        }
        if(input$test$x>=2.5){
          data<-data%>%
            mutate(color=ifelse(precipitation_type=="snow","darkgreen","#57a800"),
                   alpha=ifelse(precipitation_type=="snow",1,0.2))
        }
        if(input$input_1=='v'){
          plt<-data%>%
            ggplot(aes(x=temperature,y=speed))+
            geom_point(color=data$color, alpha=data$alpha)+
            ylab("running speed (m/s)")+
            ylim(0,3.75)+
            xlab("temperature (\u00B0C)")+
            theme(
              title = element_text(color = "darkgreen", size = 30),
              axis.title = element_text(color = "darkgreen", size = 14),
              axis.text = element_text(color = "darkgreen", size = 14), 
              panel.background = element_blank(),
              axis.line = element_line(colour = "darkgreen"),
              panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
              axis.ticks = element_line(color = "darkgreen")
            ) +
            scale_x_continuous(breaks = seq(-10, 40, 4))
        }else if(input$input_1=='s'){
          plt<-data%>%
            ggplot(aes(x=temperature,y=distance_km))+
            geom_point(color=data$color, alpha=data$alpha)+
            ylab("distance run (km)")+
            xlab("temperature (\u00B0C)")+
            theme(
              title = element_text(color = "darkgreen", size = 30),
              axis.title = element_text(color = "darkgreen", size = 14),
              axis.text = element_text(color = "darkgreen", size = 14), 
              panel.background = element_blank(),
              axis.line = element_line(colour = "darkgreen"),
              panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
              axis.ticks = element_line(color = "darkgreen")
            ) +
            scale_x_continuous(breaks = seq(-10, 40, 4))
          }else if(input$input_1=='t'){
            plt<-data%>%
              ggplot(aes(x=temperature,y=time_h))+
              geom_point(color=data$color, alpha=data$alpha)+
              ylab("running time (h)")+
              xlab("temperature (\u00B0C)")+
              theme(
                title = element_text(color = "darkgreen", size = 30),
                axis.title = element_text(color = "darkgreen", size = 14),
                axis.text = element_text(color = "darkgreen", size = 14), 
                panel.background = element_blank(),
                axis.line = element_line(colour = "darkgreen"),
                panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
                axis.ticks = element_line(color = "darkgreen")
              ) +
              scale_x_continuous(breaks = seq(-10, 40, 4))
            }
        ggplotly(plt) %>% config(displayModeBar = F)
        
      }
    })

    output$autocorrelation_plot <- renderPlot({
      grid.arrange(autocorrelation(input$correlation_lag,
                                   running_data$distance_km/running_data$time_h),
                   correlation(input$correlation_lag, 
                               running_data$distance_km/running_data$time_h),
                   ncol = 2)
    })
    
    output$autocorrelation_random_plot <- renderPlot({
      set.seed(2)
      grid.arrange(autocorrelation(input$correlation_lag,
                                   sample(running_data$distance_km/running_data$time_h)),
                   correlation(input$correlation_lag, 
                               sample(running_data$distance_km/running_data$time_h)),
                   ncol = 2)
    })
  
    df1 <- reactive({
      dfDay <- df %>% filter(as.integer(input$sliderData[1]) <= as.integer(df$date) &
                               as.integer(df$date) <= as.integer(input$sliderData[2])) %>%  
        group_by(day) %>% summarise(count = length(day))
      x <- dfDay$day
      x <- as.vector(x)
      sortDays <-weekDay[sort(as.vector(na.omit(match(x,weekDay))))]
      dfDay$day <- factor(dfDay$day, 
                          levels = sortDays)
      dfDay
    })
    output$p1 <- renderPlotly({
      plot_df <- df1()
      p <- ggplot(plot_df, aes(x = day, y = count)) +
        geom_bar(stat="identity", fill = "#57a800") + blank_theme
      ggplotly(p) %>% config(displayModeBar = F)
    })
    
    observeEvent(input$p1, {
      df1 <- reactive({
        dfDay <- df %>% filter(as.integer(input$sliderData[1]) <= as.integer(df$date) &
                                 as.integer(df$date) <= as.integer(input$sliderData[2])) %>%  
          group_by(day) %>% summarise(count = length(day))
        x <- dfDay$day
        x <- as.vector(x)
        sortDays <-weekDay[sort(as.vector(na.omit(match(x,weekDay))))]
        dfDay$day <- factor(dfDay$day, 
                            levels = sortDays)
        dfDay
      })
      output$pl3 <- renderPlotly({
        plot_df <- df1()
        p <- ggplot(plot_df, aes(x = day, y = count)) +
          geom_bar(stat="identity", fill = "#57a800") + blank_theme +
          scale_y_continuous(breaks= seq(0, max(as.vector(plot_df$count)+2),2)) +
          xlab("day of the week") +
          ylab("number of trainings")
        
        ggplotly(p)
      })
    })
    observeEvent(input$p2, {
      df1 <- reactive({
        dfMonth <- df %>% filter(as.integer(input$sliderData[1]) <= as.integer(df$date) &
                                   as.integer(df$date) <= as.integer(input$sliderData[2])) %>%  
          group_by(month) %>% summarise(count = length(month))
        dfMonth <- cbind(dfMonth, as.data.frame(substr(dfMonth$month, 1,3)))
        colnames(dfMonth) <- c("month", "count", "mon")
        x <- dfMonth$mon
        x <- as.vector(x)
        sortMonths <-monthVec[sort(as.vector(na.omit(match(x,monthVec))))]
        sortMonths
        dfMonth$mon <- factor(dfMonth$mon, 
                              levels = sortMonths)
        dfMonth
      })
      output$pl3 <- renderPlotly({
        plot_df <- df1()
        p <- ggplot(plot_df, aes(x = mon, y = count)) +
          geom_bar(stat="identity", fill = "#57a800") + 
          blank_theme +
          scale_y_continuous(breaks= seq(0, max(as.vector(plot_df$count)+2),2)) +
          ylab("number of trainings") +
          xlab("month")
        
        ggplotly(p)
      })
    })
}