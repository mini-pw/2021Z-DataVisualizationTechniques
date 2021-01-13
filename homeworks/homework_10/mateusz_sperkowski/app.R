library(shiny)
library(DT)
library(ggplot2)
library(plotly)
library(tidyr)
source("timss-get-data.R")

shinyApp(
  ui = pageWithSidebar(
    headerPanel("TIMMS 2019 Dashboard"),
    sidebarPanel(
      checkboxInput("plot_genders", 
                    label = "Show Genders",
                    value = TRUE),
      selectInput("plot_country",
                  label = "Country:",
                  choices = M4TG[order(M4TG$Country),]$Country,
                  selected = "New Zealand"),
      h4("TIMMS is an international assessment that measures students achievements in grades 4 and 8, every four years. 
         On this dashboard we can select a country and check how scores have been changing through the years. 
         Additionaly we can choose to compare how boys and girls scored in comparison."),
      htmlOutput("dataSource"),
      h5("Author: Mateusz Sperkowski")
    ),
    mainPanel(
      h1("Trends in International Mathematics and Science Study"),
      plotOutput("plot_math"),
      plotOutput("plot_science"),
      # verbatimTextOutput("text_1")
    )
  ),
  server = function(input, output, session){
    output$dataSource <- renderUI({
      tags$a(href = "https://timss2019.org/reports/download-center/", "TIMMS Download Page")
    })

    output$plot_math <- renderPlot({
      
      if (input$plot_genders){
        country_data <- M4TG[M4TG$Country == input$plot_country,] %>% gather(type, Score, -Country) %>% drop_na(Score)
        country_data$Year <- sapply(strsplit(as.character(country_data$type),'_'), "[", 1)
        country_data$Gender <- sapply(strsplit(as.character(country_data$type),'_'), "[", 2)
        
        ggplot(data = country_data, aes(x=Year, y=as.numeric(Score), fill = Gender)) + geom_bar(position = 'dodge', 
                                                                                                stat='identity') + 
          scale_y_continuous(expand = c(0, 0), limits = c(0, 650)) + theme(text = element_text(size=20)) + ylab("Math Score") +
          scale_fill_manual(labels = c("Male", "Female"), values = c("#FFB14E", "#CD34B5")) + 
          ggtitle(paste("TIMMS Maths Score in ", input$plot_country, " (Grade 4)")) + 
          geom_text(aes(label=Score), position=position_dodge(width=0.9), vjust=-0.25)
      } else {
        country_data <- M4T[M4T$Country == input$plot_country,] %>% gather(Year, Score, -Country) %>% drop_na(Score)
        ggplot(data = country_data, aes(x=Year, y=Score)) + geom_bar(stat='identity', fill = "#361AE5") + 
          scale_y_continuous(expand = c(0, 0), limits = c(0, 650)) + theme(text = element_text(size=20)) + ylab("Math Score") +
          ggtitle(paste("TIMMS Maths Score in ", input$plot_country, " (Grade 4)")) +
          geom_text(aes(label=Score), position=position_dodge(width=0.9), vjust=-0.25)
      }
    }
    )
    
    output$plot_science <- renderPlot({
      
      if (input$plot_genders){
        country_data <- S4TG[S4TG$Country == input$plot_country,] %>% gather(type, Score, -Country) %>% drop_na(Score)
        country_data$Year <- sapply(strsplit(as.character(country_data$type),'_'), "[", 1)
        country_data$Gender <- sapply(strsplit(as.character(country_data$type),'_'), "[", 2)
        
        ggplot(data = country_data, aes(x=Year, y=as.numeric(Score), fill = Gender)) + geom_bar(position = 'dodge', 
                                                                                                stat='identity') + 
          scale_y_continuous(expand = c(0, 0), limits = c(0, 650)) + theme(text = element_text(size=20)) + ylab("Science Score") +
          scale_fill_manual(labels = c("Male", "Female"), values = c("#FFB14E", "#CD34B5")) + 
          ggtitle(paste("TIMMS Science Score in ", input$plot_country, " (Grade 4)")) + 
          geom_text(aes(label=Score), position=position_dodge(width=0.9), vjust=-0.25)
      } else {
        country_data <- M4T[M4T$Country == input$plot_country,] %>% gather(Year, Score, -Country) %>% drop_na(Score)
        ggplot(data = country_data, aes(x=Year, y=Score)) + geom_bar(stat='identity', fill = "#361AE5") + 
          scale_y_continuous(expand = c(0, 0), limits = c(0, 650)) + theme(text = element_text(size=20)) + ylab("Science Score") +
          ggtitle(paste("TIMMS Science Score in ", input$plot_country, " (Grade 4)")) +
          geom_text(aes(label=Score), position=position_dodge(width=0.9), vjust=-0.25)
      }
    }
    )
    

  }
)

