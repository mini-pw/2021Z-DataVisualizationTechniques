#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(leaflet)
library(spData)
library(plotly)
library(sf)

source("timss-get-data.R")


shinyServer(function(input, output, session) {
    
    updateSelectInput(session, "country1", choices = M4_student_bullying%>%select(Country)%>%arrange(Country))
    updateSelectInput(session, "country2", choices =  M4_student_bullying%>%select(Country)%>%arrange(Country))
    
    
    output$map <- renderLeaflet({
        country1 <- input$country1
        country2 <- input$country2
        map <- leaflet() %>% 
            addProviderTiles("OpenStreetMap.Mapnik") %>%
            addPolygons(data = world %>% filter(name_long == min(c(country1,country2))), color = '#F8766D')
        if(country1 != country2){
           map %>% addPolygons(data = world %>% filter(name_long == max(c(country1, country2))), color = '#00BFC4')
        }else{
            map
        }
    })
    

    output$all_countries <- renderPlotly({
        country1 <- input$country1
        country2 <- input$country2
        
        if(input$radio == 1){
            M4_student_like %>%
                rename(avarage = 8) %>%
                inner_join(M4, by = "Country")%>%
                ggplot()+
                geom_point(aes(x = M4, y = avarage, text = Country)) +
                geom_point(data = M4_student_like %>% 
                               rename(avarage = 8) %>% 
                               inner_join(M4, by = "Country") %>% 
                               filter(Country %in% c(country1, country2)),
                           aes(x = M4, y = avarage, colour = Country),
                           size = 3) +
                ylab('How much do Students like Mathematics?')+
                xlab('Avarage score in Mathematics') +
                ggtitle("Does beeing keen on subject affect results?") +
                theme_classic() -> p
        }else if(input$radio == 2){
            M4_student_confident %>%
                rename(avarage = 8) %>%
                inner_join(M4, by = "Country")%>%
                ggplot()+
                geom_point(aes(x = M4, y = avarage, text = Country)) +
                geom_point(data = M4_student_confident %>% 
                               rename(avarage = 8) %>% 
                               inner_join(M4, by = "Country") %>% 
                               filter(Country %in% c(country1, country2)),
                           aes(x = M4, y = avarage, colour = Country),
                           size = 3) +
                ylab('How much are Students confident in Mathematics?')+
                xlab('Avarage score in Mathematics') +
                ggtitle("Does confidance affect results?") +
                theme_classic() -> p
        }else if(input$radio == 3){
            M4_student_bullying %>%
                rename(avarage = 8) %>%
                inner_join(M4, by = "Country")%>%
                ggplot()+
                geom_point(aes(x = M4, y = avarage, text = Country)) +
                geom_point(data = M4_student_bullying %>% 
                               rename(avarage = 8) %>% 
                               inner_join(M4, by = "Country") %>% 
                               filter(Country %in% c(country1, country2)),
                           aes(x = M4, y = avarage, colour = Country),
                           size = 3) +
                ylab('How common is bullying?\nHigher value means less popular bullying')+
                xlab('Avarage score in Mathematics') +
                ggtitle("Does bullying affect results?") +
                theme_classic() ->p 
        }
        ggplotly(p, tooltip = "text")
    })
    
    output$details <- renderPlot({
        country1 <- input$country1
        country2 <- input$country2
        avg1 <-  M4 %>% filter(Country == country1) %>% select(M4)
        avg2 <-  M4 %>% filter(Country == country2) %>% select(M4)
        
        if(input$radio == 1){
            p <- M4_student_like %>%
                filter(Country %in% c(country1, country2))%>%
                select(1,3,5,7)%>%
                rename("Very Much Like" = "like_avg", "Somewhat Like" = "middle_avg", "Do Not Like" = "hate_avg") %>%
                pivot_longer(cols = 2:4, names_to = "name")%>%
                mutate(name = factor(name, levels=c("Very Much Like","Somewhat Like","Do Not Like"))) %>%
                ggplot()+
                geom_bar(aes(x = name, y = value, group = Country, fill = Country), position = "dodge", stat = 'identity')+
                ggtitle("Students\' TISS results")+
                xlab("Do you like Maths?")+
                ylab("Students' achivement")
            
        }else if(input$radio == 2){
            p <- M4_student_confident %>%
                filter(Country %in% c(country1, country2))%>%
                select(1,3,5,7)%>%
                rename("Very Confident" = "confident_avg", "Somewhat Confident" = "middle_avg", "Not Confident" = "not_confident_avg") %>%
                pivot_longer(cols = 2:4, names_to = "name")%>%
                mutate(name = factor(name, levels=c("Very Confident","Somewhat Confident","Not Confident"))) %>%
                ggplot()+
                geom_bar(aes(x = name, y = value, group = Country, fill = Country), position = "dodge", stat = 'identity')+
                ggtitle("Students\' TISS results")+
                xlab("How confident are you in Maths?")+
                ylab("Students' achivement")
            
        }else if(input$radio == 3){
            p <- M4_student_bullying %>%
                filter(Country %in% c(country1, country2))%>%
                select(1,3,5,7)%>%
                rename("Never or Almost Never" = "never_avg", "About Monthly" = "monthly_avg", "About Weekly" = "weekly_avg") %>%
                pivot_longer(cols = 2:4, names_to = "name")%>%
                mutate(name = factor(name, levels=c("Never or Almost Never","About Monthly","About Weekly"))) %>%
                ggplot()+
                geom_bar(aes(x = name, y = value, group = Country, fill = Country), position = "dodge", stat = 'identity')+
                ggtitle("Students\' TISS results")+
                xlab("How often are you bullied?")+
                ylab("Students' achivement")
        }
        if(country1>country2){
            p <- p +
                geom_hline(yintercept =avg2$M4, colour = "red")+
                geom_text(y = avg2$M4+12, x =2.25, colour = "red", label = paste(country2,"average score"))+
                geom_hline(yintercept =avg1$M4, colour = "blue")+
                geom_text(y = avg1$M4+12, x = 2.75, colour = "blue", label = paste(country1,"average score"))
               
        }else if (country1<country2){
            p <- p +
                geom_hline(yintercept =avg1$M4, colour = "red")+
                geom_text(y = avg1$M4+12, x =2.25, colour = "red", label = paste(country1,"average score"))+
                geom_hline(yintercept =avg2$M4, colour = "blue")+
                geom_text(y = avg2$M4+12, x = 2.75, colour = "blue", label = paste(country2,"average score"))
        }else{
            p <- p +
                geom_hline(yintercept =avg1$M4, colour = "red")+
                geom_text(y = avg1$M4+12, x =2.75, colour = "red", label = paste(country1,"average score"))
            
        }
        p + theme_classic()+
            theme(text = element_text(size = 16))+
            scale_y_continuous(expand = c(0,0), limits = c(0,max(avg1,avg2,p$data$value)+20))
        })

})
