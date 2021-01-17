library(DT)
library(ggplot2)
library(plotly)
library(readxl)
library(dplyr)
library(readxl)
library(dplyr)

#data reading and aggregration

M4_2019_read <- read_xlsx("1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 13, 14) %>%
  rename("Score" = "Average \r\nScale Score", "5th_percentile" = "Mathematics Achievement Distribution",
         "25th_percentile" = "...10", "75th_percentile" = "...13", "95th_percentile" = "...14") %>%
  na.omit()

M4_2015_read <- read_xlsx("1_1_math-distribution-of-mathematics-achievement-grade-4.xlsx", skip = 4) %>%
  select(3, 4, 7, 8, 11, 12) %>%
  rename("Score" ="Average\r\nScale Score", "5th_percentile" = "Mathematics Achievement Distribution",
         "25th_percentile" = "...8", "75th_percentile" = "...11", "95th_percentile" = "...12") %>% 
  na.omit()


M4_countries <- M4_2015_read[M4_2015_read$Country %in% M4_2019_read$Country, c("Country")]

M4_2019 <- merge(x = M4_countries, y = M4_2019_read, by = "Country", all.x = TRUE)
M4_2015 <- merge(x = M4_countries, y = M4_2015_read, by = "Country", all.x = TRUE)

M4_2019 <- mutate(M4_2019, "Year" = "2019") 
M4_2015 <- mutate(M4_2015, "Year" = "2015") 

M4_merge15 <- rename(M4_2015, "Score2015" = "Score", 
                     "5th_percentile2015" = "5th_percentile",
                     "25th_percentile2015" = "25th_percentile",
                     "75th_percentile2015" = "75th_percentile",
                     "95th_percentile2015" = "95th_percentile")

M4_merge19 <- rename(M4_2019,
                     "Score2019" = "Score",
                     "5th_percentile2019" = "5th_percentile",
                     "25th_percentile2019" = "25th_percentile",
                     "75th_percentile2019" = "75th_percentile",
                     "95th_percentile2019" = "95th_percentile")

M4_table <- merge(x = M4_merge15, y = M4_merge19, by = "Country")

M4 <- rbind(M4_2015, M4_2019)



S4_2019_read <- read_xlsx("2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 13, 14) %>%
  rename("Score" = "Average \r\nScale Score", "5th_percentile" = "Science Achievement Distribution",
         "25th_percentile" = "...10", "75th_percentile" = "...13", "95th_percentile" = "...14") %>%
  na.omit()

S4_2015_read <- read_xlsx("1_1_science-distribution-of-science-achievement-grade-4.xlsx", skip = 4) %>%
  select(3, 4, 7, 8, 11, 12) %>%
  rename("Score" ="Average\r\nScale Score", "5th_percentile" = "Science Achievement Distribution",
         "25th_percentile" = "...8", "75th_percentile" = "...11", "95th_percentile" = "...12") %>% 
  na.omit()


S4_countries <- S4_2015_read[S4_2015_read$Country %in% S4_2019_read$Country, c("Country")]

S4_2019 <- merge(x = S4_countries, y = S4_2019_read, by = "Country", all.x = TRUE)
S4_2015 <- merge(x = S4_countries, y = S4_2015_read, by = "Country", all.x = TRUE)

S4_2019 <- mutate(S4_2019, "Year" = "2019") 
S4_2015 <- mutate(S4_2015, "Year" = "2015") 


S4_merge15 <- rename(S4_2015, "Score2015" = "Score", 
                     "5th_percentile2015" = "5th_percentile",
                     "25th_percentile2015" = "25th_percentile",
                     "75th_percentile2015" = "75th_percentile",
                     "95th_percentile2015" = "95th_percentile")

S4_merge19 <- rename(S4_2019,
                     "Score2019" = "Score",
                     "5th_percentile2019" = "5th_percentile",
                     "25th_percentile2019" = "25th_percentile",
                     "75th_percentile2019" = "75th_percentile",
                     "95th_percentile2019" = "95th_percentile")

S4_table <- merge(x = S4_merge15, y = S4_merge19, by = "Country")

S4 <- rbind(S4_2015, S4_2019)







function(input, output, session){
  
  output$plot_1 <- renderPlot({
    
    
    
    if(input$subject == "Math"){
      if(length(input$checkGroup) == 1){
        if(input$checkGroup == "2015"){
          data <- M4_2015[M4_2015$Country %in% input$country_selection, c("Country", "Score")]
          ggplot(data, aes(x = Country, y = Score)) +
            geom_bar(fill = "salmon", stat = "identity") +
            coord_flip() +
            ylab("Score in 2015") +
            ggtitle("Mathematics Achievement") +
            theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 20))
        }
        else {
          data <- M4_2019[M4_2019$Country %in% input$country_selection, c("Country", "Score")]
          ggplot(data, aes(x = Country, y = Score)) +
            geom_bar(fill = "turquoise3", stat = "identity") +
            coord_flip() +
            ylab("Score in 2019") +
            ggtitle("Mathematics Achievement") +
            theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 20))
        }
      }
      else if(length(input$checkGroup) == 2){
        data <- M4[M4$Country %in% input$country_selection, c("Country", "Score", "Year")]
        ggplot(data, aes(x = Country, y = Score, fill = Year)) +
          geom_bar(position="dodge", stat = "identity") +
          coord_flip() +
          ggtitle("Mathematics Achievement") +
          theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 20))
      }
    }
    
    else {
      if(length(input$checkGroup) == 1){
        if(input$checkGroup == "2015"){
          data <- S4_2015[S4_2015$Country %in% input$country_selection, c("Country", "Score")]
          ggplot(data, aes(x = Country, y = Score)) +
            geom_bar(fill = "salmon", stat = "identity") +
            coord_flip() +
            ylab("Score in 2015") +
            ggtitle("Science Achievement") +
            theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 20))
        }
        else {
          data <- S4_2019[S4_2019$Country %in% input$country_selection, c("Country", "Score")]
          ggplot(data, aes(x = Country, y = Score)) +
            geom_bar(fill = "turquoise3", stat = "identity") +
            coord_flip() +
            ylab("Score in 2019") +
            ggtitle("Science Achievement") +
            theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 20))
        }
      }
      else if(length(input$checkGroup) == 2){
        data <- S4[S4$Country %in% input$country_selection, c("Country", "Score", "Year")]
        ggplot(data, aes(x = Country, y = Score, fill = Year)) +
          geom_bar(position="dodge", stat = "identity") +
          coord_flip() +
          ggtitle("Science Achievement") +
          theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 20))
      }
    }
    
  })
  
  output$table_1 <- DT::renderDataTable({
    if(input$subject == "Math"){
      if(length(input$checkGroup) == 1){
        if(input$checkGroup == "2015"){
          data <- M4_2015[M4_2015$Country %in% input$country_selection, c("Country", "Score", "5th_percentile", "25th_percentile", "75th_percentile", "95th_percentile")]
          DT::datatable(data)
        }
        else if(input$checkGroup == "2019"){
          data <- M4_2019[M4_2019$Country %in% input$country_selection, c("Country", "Score", "5th_percentile", "25th_percentile", "75th_percentile", "95th_percentile")]
          DT::datatable(data)
        }
      }
      else if(length(input$checkGroup) == 2){
        data <- M4_table[M4_table$Country %in% input$country_selection, c("Country", "Score2015", "5th_percentile2015", "25th_percentile2015",
                                                                          "75th_percentile2015", "95th_percentile2015",
                                                                          "Score2019", "5th_percentile2019",
                                                                          "25th_percentile2019", "75th_percentile2019",
                                                                          "95th_percentile2019")]
        DT::datatable(data)
      }
    }
    else {
      if(length(input$checkGroup) == 1){
        if(input$checkGroup == "2015"){
          data <- S4_2015[S4_2015$Country %in% input$country_selection, c("Country", "Score", "5th_percentile", "25th_percentile", "75th_percentile", "95th_percentile")]
          DT::datatable(data)
        }
        else if(input$checkGroup == "2019"){
          data <- S4_2019[S4_2019$Country %in% input$country_selection, c("Country", "Score", "5th_percentile", "25th_percentile", "75th_percentile", "95th_percentile")]
          DT::datatable(data)
        }
      }
      else if(length(input$checkGroup) == 2){
        data <- S4_table[S4_table$Country %in% input$country_selection, c("Country", "Score2015", "5th_percentile2015", "25th_percentile2015",
                                                                          "75th_percentile2015", "95th_percentile2015",
                                                                          "Score2019", "5th_percentile2019",
                                                                          "25th_percentile2019", "75th_percentile2019",
                                                                          "95th_percentile2019")]
        DT::datatable(data)}
      
    }
  })
  
}

