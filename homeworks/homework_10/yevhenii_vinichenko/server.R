

server <- function(input, output, session){
  
  no_country <- FALSE
  
  M4 <- read_xlsx("1-8_benchmarks-results-M4.xlsx", skip = 5) %>%
    select(3, 5, 8, 11, 14) %>%
    na.omit()
  
  M4 <- M4[-(59:65), ]
  
  colnames(M4) <- c("country", "advanced", "high", "intermediate", "low")
  
  M8 <- read_xlsx("3-8_benchmarks-results-M8.xlsx", skip = 5) %>%
    select(3, 5, 8, 11, 14) %>%
    na.omit()
  
  M8 <- M8[-(40:47), ]
  
  colnames(M8) <- c("country", "advanced", "high", "intermediate", "low")
  
  
  output$plot1 <- renderPlot({
    
    if(input$subject == "math"){
      if(input$form == "4th"){
        data <- M4
      } else{
        data <- M8
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
        coord_flip() +
        scale_y_discrete(expand = c(0, 0)) +
        scale_fill_manual(values = c( "yes"="#800000", "no"="#D3D3D3" ), guide = FALSE ) +
        ggtitle(paste("Percent of students reachind", input$benchmark, "benchmark")) +
        ylab("student %") +
        xlab(element_blank()) +
        theme_bw()
      
      if (input$show_median){
        plot <- plot +
          geom_hline(yintercept = median(data[[input$benchmark]]), color = "red")
      }
      
    }
    
    plot
    
  
    
  })
  

  

  
}