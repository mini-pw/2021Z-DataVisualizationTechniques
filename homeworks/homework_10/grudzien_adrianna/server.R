library(DT)
library(ggplot2)
library(dplyr)


function(input, output, session){

  output$wykres1 <- renderPlotly({
    
    # Wybieramy ramkę:
    if (input$przedmiot == "matematyka") {
      if(input$klasa == "IV") {
        wybranaRamka <- M4
      }
      else {
        wybranaRamka <- M8
      }
    }
    else {
      if(input$klasa == "IV") {
        wybranaRamka <- S4
      }
      else {
        wybranaRamka <- S8
      }
    }
    
    pom <- wybranaRamka %>% 
      arrange(desc(Score))
    ymax <- pom$Score[1]
      
    
    #Formatujemy ramkę:
    if (input$top == "najlepsze 30") {
      wybranaRamka <- wybranaRamka %>% 
        arrange(desc(Score))
      wybranaRamka <- head(wybranaRamka,30)
    }
    else if (input$top == "najlepsze 50") {
        wybranaRamka <- wybranaRamka %>% 
          arrange(desc(Score))
        wybranaRamka <- head(wybranaRamka,50)
      }
    else if (input$top == "najgorsze 30") {
          wybranaRamka <- wybranaRamka %>% 
            arrange(Score)
          wybranaRamka <- head(wybranaRamka,30)
        }
    else if (input$top == "najgorsze 50") {
            wybranaRamka <- wybranaRamka %>% 
              arrange(Score)
            wybranaRamka <- head(wybranaRamka,50)
          }
    else {
            wybranaRamka <- wybranaRamka %>% 
              arrange(desc(Score))
          }
        
    
    
    wybranyKraj <- input$kraj
    
    p <- ggplot(data=wybranaRamka, aes(x=reorder(Country,-Score),y=Score, fill = 
                                         factor(ifelse(Country==wybranyKraj,"wybranyKraj","innyKraj")))) +
      geom_bar(stat = "identity", width = 0.8) +
      scale_fill_manual(name = "Country", values=c("#ECDD7B","#561D25")) +
      xlab("") +
      scale_y_continuous(name="średnia liczba punktów", limits=c(0, ymax)) +
      theme(panel.background = element_blank(),
            legend.position = "none",
            axis.text.x = element_text(angle = 70))
    ggplotly(p, tooltip = "Score", dynamicTicks = T)
    
  })
  
  
  
  output$wykres2 <- renderPlotly({
    
    wybranyKraj <- input$kraj
    
    # Wybieramy ramkę:
    if (input$przedmiot == "matematyka") {
      if(input$klasa == "IV") {
        wybranaRamka <- disM4
      }
      else {
        wybranaRamka <- disM8
      }
    }
    else {
      if(input$klasa == "IV") {
        wybranaRamka <- disS4
      }
      else {
        wybranaRamka <- disS8
      }
    }
    
    #Który rodzaj problemu:
    if(input$problem == "prawie żadnych problemów") {
      colnames(wybranaRamka)[2] <- "percent"
      colnames(wybranaRamka)[3] <- "average"
    }
    else if(input$problem == "drobne problemy") {
        colnames(wybranaRamka)[4] <- "percent"
        colnames(wybranaRamka)[5] <- "average"
      }
    
    
    
    p <- ggplot(wybranaRamka, aes(y = reorder(Country,average), x = average, group = percent)) +
      geom_point(aes(color = percent), 
                 size=ifelse(wybranaRamka$Country==wybranyKraj,4,2)) +
      xlab("średnia liczba punktów") + ylab("") +
      labs(color = "% uczniów", location = "bottom") +
      scale_color_gradient(low = "#ECDD7B", high = "#561D25") +
      theme(legend.position = "bottom")

    ggplotly(p, dynamicTicks = F, height = 800)
    
  })
  
  
}

