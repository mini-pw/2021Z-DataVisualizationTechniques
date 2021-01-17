library(shiny)
library(plotly)
library(ggplot2)
library(tidyr)
library(shinythemes)

function(input, output, session) {
  
  
  get_df <- reactive({
    df <- get(paste0(input$subject, input$grade))
    df$Country <- factor(df$Country, levels = rev(df$Country))
    df
  })
  
  
  get_countries <- reactive({
    get_df()$Country
  })
  

  observeEvent(input$grade,
    {updateSliderInput(session, "how_many",
                        max = nrow(get_df()), 
                        value = c(1, nrow(get_df())))
  })
  
  observeEvent(input$how_many,
               {updateSelectInput(session, "country",
                                 choices = get_countries()[input$how_many[1]:input$how_many[2]],
                                 selected = input$country)})
  
  
  
  output$barplot <- renderPlotly({
    df <- get_df() 
    df <- df[input$how_many[1]:input$how_many[2],]
    if(is.null(input$country)){
      df <- df %>% mutate(color = "moccasin")
    }  
    else{
      df <- df %>% mutate(color = ifelse(Country == input$country, "orange", "moccasin"))
    }
    plot <-  ggplot(df, aes(Country, Score)) +
      geom_bar(stat = "identity", fill = df$color) + 
      scale_y_continuous(expand = c(0, 0)) +
      coord_flip() + 
      theme_minimal() +
      theme(plot.background = element_rect(fill="transparent"),
            panel.background = element_rect(fill="transparent"),
            legend.position = "none", 
            axis.title.y = element_blank(),
            plot.title = element_text(hjust = 0.5)) +
      ggtitle(paste("Average score by country"))
    

   ggplotly(plot) %>% config(displayModeBar = FALSE)
  })


  output$scatterplot <- renderPlotly({
    df <- get_df() 
    if(is.null(input$country)){
      df <- df %>% mutate(color = "moccasin", size = 2)
    }  
    else{
      df <- df %>% mutate(color = ifelse(Country == input$country, "orange", "moccasin"), 
                          size = ifelse(Country == input$country, 3, 2))
    }
    df <- df[input$how_many[1]:input$how_many[2], ]
    df$text <- paste0("Country: ", df$Country, "<br>", 
                     "Score: ", df$Score, "<br>",
                     "Computer availability: ", df$`Computer availability`, "%")
    plot <- ggplot(df, aes_string("`Computer availability`", "Score", text = "text")) +
      geom_point(color = df$color, size = df$size) + 
      scale_x_continuous(limits = c(0, 100), breaks = seq(0, 100, 20), labels = function(x){paste0(x, "%")}) +
      theme_minimal() +
      theme(plot.background = element_rect(fill="transparent"),
            panel.background = element_rect(fill="transparent"),
            legend.position = "none",
            plot.title = element_text(hjust = 0.5)) +
      ggtitle("Students' results and computer availability") +
      xlab("Percent of students who have access to a computer during the lessons") 
    
    
    ggplotly(plot, tooltip = c("text")) %>% config(displayModeBar = FALSE)
  })
  
   
  output$barplot2 <- renderPlotly({
      df <- get_df() %>% filter(Country == input$country) %>% pivot_longer(cols = 4:6, names_to = "Answers", values_to ="Percent")
      df$text <- paste0("Percent of students with\nthis type of computer access: ", df$Percent, "%")
      plot <- ggplot(df, aes(Answers, Percent, label = Country, text = text)) +
        geom_bar(stat = "identity", fill = "sandybrown") +
        scale_y_continuous(expand = c(0.01, 0), labels = function(x){paste0(x, "%")}) +
        scale_x_discrete(labels = unlist(lapply(strwrap(c("Each student has a computer",
                                                         "The class has computers that students can share",
                                                         "The school has computers that the class can sometimes use"), 
                                                        20, simplify = FALSE), paste, collapse="\n"))) +
        theme_minimal() +
        theme(plot.background = element_rect(fill="transparent"),
              panel.background = element_rect(fill="transparent"),
              panel.grid.major.x = element_blank(),
              legend.position = "none",
              plot.title = element_text(hjust = 0.5)) +
        ggtitle(paste("Percent of students in", input$country, "by type of computer access")) +
        xlab("Type of computer access")
        
      ggplotly(plot, tooltip = "text") %>% config(displayModeBar = FALSE) 
    
  })
  
  
  
}
