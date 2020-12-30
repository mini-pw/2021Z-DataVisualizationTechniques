

server <- function(input, output, session){
  
  # Dane dla 1 wykresu
  # Matematyka klasa 4
  M4 <- read_xlsx("data/plot1/1-8_benchmarks-results-M4.xlsx", skip = 5) %>%
    select(3, 5, 8, 11, 14) %>%
    na.omit()
  
  M4 <- M4[-(59:65), ]
  
  colnames(M4) <- c("country", "advanced", "high", "intermediate", "low")
  
  # Matematyka klasa 8
  M8 <- read_xlsx("data/plot1/3-8_benchmarks-results-M8.xlsx", skip = 5) %>%
    select(3, 5, 8, 11, 14) %>%
    na.omit()
  
  M8 <- M8[-(40:47), ]
  
  colnames(M8) <- c("country", "advanced", "high", "intermediate", "low")
  
  # Przyroda klasa 4
  S4 <- read_xlsx("data/plot1/2-8_benchmarks-results-S4.xlsx", skip = 5) %>%
    select(3, 5, 8, 11, 14) %>%
    na.omit()
  
  S4 <- S4[-(59:65), ]
  
  colnames(S4) <- c("country", "advanced", "high", "intermediate", "low")
  
  # Przyroda klasa 8
  S8 <- read_xlsx("data/plot1/4-8_benchmarks-results-S8.xlsx", skip = 5) %>%
    select(3, 5, 8, 11, 14) %>%
    na.omit()
  
  S8 <- S8[-(40:47), ]
  
  colnames(S8) <- c("country", "advanced", "high", "intermediate", "low")
  
  
  output$plot1 <- renderPlot({
    
    if(input$subject == "math"){
      if(input$form == "4th"){
        data <- M4
      } else{
        data <- M8
      }
    } else{
      if(input$form == "4th"){
        data <- S4
      } else{
        data <- S8
      }
    }
    
    data %>% filter(country == input$country) -> tmp
    
    if(length(tmp[[1]]) == 0){
      
      plot <- ggplot(data, aes(x = country, y = !!sym(input$benchmark))) +
        annotate("text", x = 10, y = 30, label = paste("Sorry, there is no data for ", input$country, ".", sep="")) +
        theme(axis.line=element_blank(),axis.text.x=element_blank(),
              axis.text.y=element_blank(),axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),legend.position="none",
              panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),plot.background=element_blank())
      
    } else{
      
      data %>% mutate(color = ifelse(country == input$country, "yes", "no")) -> data
      
      plot <- ggplot(data, aes(x = reorder(country, !!sym(input$benchmark)), 
                               y = !!sym(input$benchmark),
                               fill = color)) +
        geom_bar(stat = "identity") +
        coord_flip(expand = FALSE, ylim = c(0, 100)) +
        scale_fill_manual(values = c("yes"="#800000", "no"="#D3D3D3" ), guide = FALSE) +
        ggtitle(paste("Percent of students reaching", input$benchmark, "benchmark")) +
        labs(y = "students %") +
        xlab(element_blank()) +
        theme_bw()
      
      if (input$show_median){
        plot <- plot +
          geom_hline(yintercept = median(data[[input$benchmark]]), color = "red")
      }
      
    }
    
    plot
    
  
    
  })
  
  # Dane dla 2 wykresu
  # Matematyka klasa 4
  m4 <- read.csv("data/plot2/data_m4.csv") %>%
    select(2:4)
  
  # Przyroda klasa 4
  s4 <- read.csv("data/plot2/data_s4.csv") %>%
    select(2:4)
  
  # Matematyka klasa 8
  m8 <- read.csv("data/plot2/data_m8.csv") %>%
    select(2:4)
  
  # Przyroda klasa 8
  s8 <- read.csv("data/plot2/data_s8.csv") %>%
    select(2:4)
  
  output$plot2 <- renderPlotly({
    
    if(input$subject == "math"){
      if(input$form == "4th"){
        data <- m4
      } else{
        data <- m8
      }
    } else{
      if(input$form == "4th"){
        data <- s4
      } else{
        data <- s8
      }
    }
    
    data %>% mutate(color = ifelse(country == input$country, "#800000", "#D3D3D3")) -> data
    
    data %>% filter(country == input$country) -> tmp
    
    if(length(tmp[[1]]) == 0){
      
      plot <- ggplot(data, aes(x = country, y = !!sym(input$benchmark))) +
        annotate("text", x = 10, y = 30, label = paste("Sorry, there is no data for ", input$country, ".", sep="")) +
        theme(axis.line=element_blank(),axis.text.x=element_blank(),
              axis.text.y=element_blank(),axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),legend.position="none",
              panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),plot.background=element_blank())
      
    }else{
    
    plot <- plot_ly(data, 
                    x = ~mark, 
                    y = ~experience, 
                    type = 'scatter', 
                    mode = 'markers') 
    
    # dlaczegoś nie chciało czasem wyświetlić Belgii
    # więc ją rysujemy oddzielnie
    belgium <- data %>% filter(country == "Belgium (Flemish)")
    
    plot <- plot %>%
      add_trace(
        text = ~country,
        hoverinfo = 'text',
        marker = list(color = ~color),
        showlegend = F
      ) %>% 
      add_trace( 
        x = belgium$mark,
        y = belgium$experience,
        text = belgium$country,
        hoverinfo = 'text',
        marker = list(color = belgium$color),
        showlegend = F
        ) %>%
      layout(
        xaxis = list(
          range=c(0,700),
          title = 'average test result'
        ),
        
        yaxis = list(
          range=c(0,30),
          title = 'average work years'
        ),
        title = 'Teachers work years and average test result'
      )
    }
    
    plot
  })

}
