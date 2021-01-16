#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(ggrepel)

function(input, output, session){
  
    output$plot_1 <- renderPlot({
      if(input$plot_selection == 1){
        
      ggplot(math4avg[1:input$number_of_countries,], aes(x = Country, y = Score)) + 
        geom_bar(stat = "identity") + theme_bw() +
        theme(axis.title.x= element_blank(), 
              axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 15), 
              axis.text.y = element_text(size = 15), axis.title.y = element_text(size = 20))
      }
      else if(input$plot_selection == 2){
        ggplot(math8avg[1:input$number_of_countries,], aes(x = Country, y = Score)) + 
          geom_bar(stat = "identity") + theme_bw() +
          theme(axis.title.x= element_blank(), 
                axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 15),
                axis.text.y = element_text(size = 15), axis.title.y = element_text(size = 20))
      }
      else if(input$plot_selection == 3){
        ggplot(science4avg[1:input$number_of_countries,], aes(x = Country, y = Score)) + 
          geom_bar(stat = "identity") + theme_bw() +
          theme(axis.title.x= element_blank(), 
                axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 15),
                axis.text.y = element_text(size = 15), axis.title.y = element_text(size = 20))
      }
      else if(input$plot_selection == 4){
        ggplot(science8avg[1:input$number_of_countries,], aes(x = Country, y = Score)) + 
          geom_bar(stat = "identity") + theme_bw() +
          theme(axis.title.x= element_blank(), 
                axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 15),
                axis.text.y = element_text(size = 15), axis.title.y = element_text(size = 20))
      }
    })
    output$plot_2 <- renderPlot({
      if(input$plot_selection == 1){
    m4avg = math4avg[1:input$number_of_countries,]
    m4stat <- math4stat[math4stat$Country %in% m4avg$Country,]
      ggplot(m4stat, aes(x = Attitude, y = Resources, label = Country)) +
        geom_point(size = 4) + theme_bw() + geom_text_repel() + 
        theme(axis.title = element_text(size = 20), axis.text = element_text(size = 15))
      }
      else if(input$plot_selection == 2){
        m8avg = math8avg[1:input$number_of_countries,]
        m8stat <- math8stat[math8stat$Country %in% m8avg$Country,]
        ggplot(m8stat, aes(x = Attitude, y = Resources, label = Country)) +
          geom_point(size = 4) + theme_bw() + geom_text_repel() + 
          theme(axis.title = element_text(size = 20), axis.text = element_text(size = 15))
      }
      else if(input$plot_selection == 3){
        s4avg = science4avg[1:input$number_of_countries,]
        s4stat <- science4stat[science4stat$Country %in% s4avg$Country,]
        ggplot(s4stat, aes(x = Attitude, y = Resources, label = Country)) +
          geom_point(size = 4) + theme_bw() + geom_text_repel() + 
          theme(axis.title = element_text(size = 20), axis.text = element_text(size = 15))
      }
      else if(input$plot_selection == 4){
        s8avg = science8avg[1:input$number_of_countries,]
        s8stat <- science8stat[science8stat$Country %in% s8avg$Country,]
        ggplot(s8stat, aes(x = Attitude, y = Resources, label = Country)) +
          geom_point(size = 4) + theme_bw() + geom_text_repel() + 
          theme(axis.title = element_text(size = 20), axis.text = element_text(size = 15))
      }
      
      })
    
    
}

