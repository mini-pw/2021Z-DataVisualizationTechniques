library(shiny)
library(ggplot2)
library(plotly)
library(tidyr)
library(ggthemes)

shinyServer(function(input, output) {
    
    # loading data
    M2011_4 <- read.csv("./data/mathematics_2011_grade4.csv")
    M2011_8 <- read.csv("./data/mathematics_2011_grade8.csv")
    M2015_4 <- read.csv("./data/mathematics_2015_grade4.csv")
    M2015_8 <- read.csv("./data/mathematics_2015_grade8.csv")
    M2019_4 <- read.csv("./data/mathematics_2019_grade4.csv")
    M2019_8 <- read.csv("./data/mathematics_2019_grade8.csv")
    
    S2011_4 <- read.csv("./data/science_2011_grade4.csv")
    S2011_8 <- read.csv("./data/science_2011_grade8.csv")
    S2015_4 <- read.csv("./data/science_2015_grade4.csv")
    S2015_8 <- read.csv("./data/science_2015_grade8.csv")
    S2019_4 <- read.csv("./data/science_2019_grade4.csv")
    S2019_8 <- read.csv("./data/science_2019_grade8.csv")
    
    
    output$boxplot <- renderPlotly({
        
        if(input$grade == "4") grade = "_4"
        else grade = "_8"
        
        if(input$subject == "M") subject = "M"
        else subject = "S"
        
        df <- data.frame(X5thPercentile = c(0), X25thPercentile = c(0), X50thPercentile = c(0), 
                         X75thPercentile = c(0), X95thPercentile = c(0), year = c(0))
        
        years <- c("2019", "2015", "2011")
        
        for (year in years){
            name <- paste(subject, year, grade, sep = "")
            data <- eval(parse(text = name))
            data <- as.data.frame(data)
            tmp <- data[data$Country == input$country, c("X5thPercentile", "X25thPercentile", 
                                                         "X50thPercentile", "X75thPercentile", "X95thPercentile")]
            if(nrow(tmp) != 0){
                tmp$year <- year
                colnames(tmp) <- c("X5thPercentile", "X25thPercentile", "X50thPercentile", "X75thPercentile", "X95thPercentile", "year")
                df <- rbind(df, tmp)
            }
        }
        
        df <- df[-1, ]
        
        if(nrow(df) == 0){
            p <- ggplot() + 
                xlim(0, 10) +
                ylim(0, 10) +
                theme_void() +
                geom_text(aes(5, 5, label = 'There is no data!'), size = 10) +
                theme(panel.grid.major = element_blank(), 
                      panel.grid.minor = element_blank())
            
            ggplotly(p)
        } else {
            #p <- ggplot(df, aes(x = as.factor(year),
            #                    ymin = X5thPercentile,
            #                    lower = X25thPercentile,
            #                    middle = X50thPercentile,
            #                    upper = X75thPercentile,
            #                    ymax = X95thPercentile )) +
            #    geom_boxplot(stat = "identity") +
            #    scale_y_continuous("Score", limits = c(0, max(df$X95thPercentile) * 1.05), expand = c(0, 0)) +
            #    xlab("Year")
            
            #ggplotly(p)
            plot_ly(x = df$year,
                    lowerfence = as.list(df$X5thPercentile),
                    q1 = as.list(df$X25thPercentile),
                    median = as.list(df$X50thPercentile),
                    q3 = as.list(df$X75thPercentile),
                    upperfence = as.list(df$X95thPercentile), 
                    type = "box") %>%
                layout(xaxis = list(title = "Year"),
                       yaxis = list(title = "Score", range = c(0, max(df$X95thPercentile) * 1.05)),
                       title = "Comparison of the results over the years")
        }
    })
    
    
    
    output$barplot <- renderPlotly({
        
        if(input$grade == "4") grade = "_4"
        else grade = "_8"
        
        if(input$subject == "M") subject = "M"
        else subject = "S"
        
        df <- data.frame(girls = c(0), boys = c(0), year = c(0))
        
        years <- c("2019", "2015", "2011")
        
        for (year in years){
            name <- paste(subject, year, grade, sep = "")
            data <- eval(parse(text = name))
            data <- as.data.frame(data)
            tmp <- data[data$Country == input$country, c("mean_girls", "mean_boys")]
            if(nrow(tmp) != 0){
                tmp$year <- year
                colnames(tmp) <- c("girls", "boys", "year")
                df <- rbind(df, tmp)
            }
        }
        
        df <- df[-1, ]
        
        if(nrow(df) == 0){
            p <- ggplot() + 
                xlim(0, 10) +
                ylim(0, 10) +
                theme_void() +
                geom_text(aes(5, 5, label = 'There is no data!'), size = 10) +
                theme(panel.grid.major = element_blank(), 
                      panel.grid.minor = element_blank())
            
            ggplotly(p)
        } else {
            colnames(df) <- c("Girls", "Boys", "year")
        
            df <- pivot_longer(df, cols = 1:2, names_to = "gender", values_to = "score")
        
            p <- ggplot(df, aes(x = year, y = score, fill = gender)) +
                     geom_bar(stat='identity', position='dodge') +
                     theme_tufte() +
                     scale_y_continuous("Score", expand = c(0, 0), limits = c(0, max(df$score) * 1.05)) +
                     scale_fill_manual(values=c("#56b4e9", "#e69f00")) +
                     xlab("Year") +
                     ggtitle("Comparison of boys' and girls' mean results") +
                     theme(panel.grid.major.y = element_line(colour = "#eeeeee", size = 0.1),
                           plot.title = element_text(hjust = 0.5),
                           axis.text = element_text(color = "black", size = 10),
                           axis.title = element_text(color = "black", size = 12))
        
            ggplotly(p) %>%
                    layout(legend = list(orientation = 'h', x = 0.35, y = -0.2))
        }
    })

})
