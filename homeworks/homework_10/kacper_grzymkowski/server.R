library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
    M4 <- read.csv("m4.csv", stringsAsFactors = F) %>% filter(Country != "TIMSS Scale Centerpoint")
    M8 <- read.csv("m8.csv", stringsAsFactors = F) %>% filter(Country != "TIMSS Scale Centerpoint")
    
    S4 <- read.csv("s4.csv", stringsAsFactors = F) %>% filter(Country != "TIMSS Scale Centerpoint")
    S8 <- read.csv("s8.csv", stringsAsFactors = F) %>% filter(Country != "TIMSS Scale Centerpoint")
    
    output$rankingPlot <- renderPlot({
        if(input$grade == 4) {
            slider_range <- input$top4
            if(input$type == "Math") {
                cur <- M4
                color <- "#408cff"
            } else {
                cur <- S4
                color <- "#ff8c40"
            }
        } else {
            slider_range <- input$top8
            if(input$type == "Math") {
                cur <- M8
                color <- "#3b7cd9"
            } else {
                cur <- S8
                color <- "#e67c35"
            }
        }
        
        cur %>% 
            arrange(desc(Score)) %>%
            slice(slider_range[1]:slider_range[2]) %>%
            ggplot(aes(y = reorder(Country, Score), x = Score)) +
            geom_col(fill = color) +
            geom_text(aes(label = Score, x = Score - 20), color = "white") +
            scale_x_continuous(limits = c(0, 650)) + 
            theme_bw() +
            labs(y = "Country") +
            ggtitle("TIMSS ranking")
    })
    
    output$distPlot <- renderPlot({
        if(input$grade == 4) {
            if(input$type == "Math") {
                cur <- M4
                color <- "#408cff"
            } else {
                cur <- S4
                color <- "#ff8c40"
            }
        } else {
            if(input$type == "Math") {
                cur <- M8
                color <- "#3b7cd9"
            } else {
                cur <- S8
                color <- "#e67c35"
            }
        }
        cur %>%
            ggplot(aes(x = Score)) +
            geom_histogram(bins = input$bins, fill = color) +
            labs(y = "Number of countries") +
            ggtitle("Country distribution") + 
            theme_bw()
    })
})
