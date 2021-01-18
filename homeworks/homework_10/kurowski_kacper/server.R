

library(dplyr)
library(ggplot2)


library( shiny)
function( input, output){
    
    filtered <- reactive({
      filtered <- df2 %>% 
        filter( Country %in% input$CountrySelection ) %>%
        group_by( Country) %>%
        mutate(
          lab_ypos = cumsum( Percentage) - 0.5 * Percentage,
          lab_ypos2 = 0.75 * Score
          )
    })
  
    output$CountrySelection <- {(
      renderText( input$CountrySelection, sep = ", " )
    )}
    output$GenderPercentage <- renderPlot({
      
      if( input$GraphPercentages  ) {      
            
            ggplot( filtered(), aes(x = Country, y = Percentage))+
              geom_col(aes(fill = Gender), width = 0.7)+
              geom_text(aes( y = lab_ypos,
                            label = paste0( Percentage, " %"),
                            group = Gender),
                            color = "white", 
                          size= 40 / nrow( filtered())
                        
                        )+
              xlab("") +
              ylab("" ) + 
              ggtitle( "Gender percentages between countries") +
              theme_minimal() +
              scale_y_continuous(labels = function(x) {paste0(x, '%')})+
              theme(
                legend.title=element_blank(),
                axis.text.x = element_text(size = 10 + 20/ nrow( filtered())),
                axis.text.y = element_text(size = 10),
                axis.title = element_text(size = 16),
                panel.grid.major.x = element_blank(),
                panel.grid.minor.x = element_blank(),
                panel.grid.minor.y = element_blank(),
                plot.title = element_text(size = 18)
              )+ 
              scale_fill_manual(values=c("slateblue4", "#E69F00"))
      }
    })

    output$GenderScores <- renderPlot({
      
      if( input$GraphScores  ) {  

          ggplot(filtered(), aes( x = Country, y = Score, fill = Gender)) +
            geom_bar( stat='identity',
                      position = position_dodge2(preserve = 'single')) +
            geom_text(aes(label=Score, y = lab_ypos2),
                      hjust = rep( c(-0.35,1.4), nrow( filtered())/2),
                      color="white", 
                     size= 40 / nrow( filtered())
                      )+
            theme_minimal() +
            ggtitle( "Average score between countries and genders") +
            xlab("") +
            theme(
              legend.title=element_blank(),
              axis.text.x = element_text(size = 10 + 20/ nrow( filtered())),
              axis.text.y = element_text(size = 16),
              axis.title = element_text(size = 16),
              panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank(),
              plot.title = element_text(size = 18)
            )+ 
          scale_fill_manual(values=c("slateblue4", "#E69F00"))
      } 
    })
}
  

