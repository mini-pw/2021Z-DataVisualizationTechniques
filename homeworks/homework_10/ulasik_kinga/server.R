library(shiny)
library(ggplot2)
library(plotly)
library(tidyr)
library(ggthemes)
library(dplyr)

function(input, output, session){
  
  M4_cognitive_2019 <- read.csv("./processeddata/M4_cognitive_2019.csv") %>%
    rename("Overall Average" = "Overall.Average") %>%
    na.omit()
  M4_cognitive_trends <- read.csv("./processeddata/M4_cognitive_trends.csv") %>%
    na.omit()
  M4_content_2019 <- read.csv("./processeddata/M4_content_2019.csv") %>%
    rename("Overall Average" = "Overall.Average") %>%
    rename("Measurement and Geometry" = "Measurement.and.Geometry") %>%
    na.omit()
  M4_content_trends <- read.csv("./processeddata/M4_content_trends.csv") %>%
    rename("Measurement and Geometry" = "Measurement.and.Geometry") %>%
    na.omit()
  
  M8_cognitive_2019 <- read.csv("./processeddata/M8_cognitive_2019.csv") %>%
    rename("Overall Average" = "Overall.Average") %>%
    na.omit()
  M8_cognitive_trends <- read.csv("./processeddata/M8_cognitive_trends.csv") %>%
    na.omit()
    
  M8_content_2019 <- read.csv("./processeddata/M8_content_2019.csv") %>%
    rename("Overall Average" = "Overall.Average") %>%
    rename("Data and Probability" = "Data.and.Probability") %>%
    na.omit()
  M8_content_trends <- read.csv("./processeddata/M8_content_trends.csv") %>%
    rename("Data and Probability" = "Data.and.Probability") %>%
    na.omit()
  
  Countries <- read.csv("./processeddata/Countries.csv")

  
  output$plotly_1 <- renderPlotly({
    
    if(input$plotly_math_class == "4th"){
      if(input$plotly_math_type == "Content"){
        df <- M4_content_trends %>%
          filter(Country == input$plotly_country)
      }else{
        df <- M4_cognitive_trends %>%
          filter(Country == input$plotly_country)
      }
    }else{
      if(input$plotly_math_type == "Content"){
        df <- M8_content_trends %>%
          filter(Country == input$plotly_country)
      }else{
        df <- M8_cognitive_trends %>%
          filter(Country == input$plotly_country)
      }
    }
    
    if(length(df$Year) == 0){
      fig <- ggplot() + 
        xlim(0, 10) +
        ylim(0, 10) +
        theme_void() +
        geom_text(aes(5, 5, label = 'No data avaiable :('), size = 10) +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank())
      fig <- ggplotly(fig)
    
    }else{
    
    if (input$plotly_math_type == "Content") {
      #df <- M4_content_trends %>%
      #  filter(Country == input$plotly_country)
      if(input$plotly_math_class == "4th"){
        fig <- plot_ly(df, x = ~Year, y = ~Number, type = 'bar', name = 'Number', color=I("#A481DE"))%>% 
          add_trace(y = ~`Measurement and Geometry`, name = 'Measurement and Geometry', color=I("#5587DE"))%>%
          add_trace(y = ~Data, name = 'Data', color=I("#6A5787")) %>% 
          layout(yaxis = list(rangemode = "tozero", title="Score"),barmode = 'group')
      }else{
        fig <- plot_ly(df, x = ~Year, y = ~Number, type = 'bar', name = 'Number',color=I("#A481DE"))%>% 
          add_trace(y = ~Algebra, name = 'Algebra',color=I("#5587DE"))%>%
          add_trace(y = ~Geometry, name = 'Geometry',color=I("#6A5787")) %>% 
          add_trace(y = ~`Data and Probability`, name = 'Data and Probability', color=I("#D5CABD")) %>% 
          layout(yaxis = list(rangemode = "tozero",title="Score"),barmode = 'group')
      }
      
        
      
    } else {
      
      #df <- M4_cognitive_trends %>%
      #  filter(Country == input$plotly_country)
      
      fig <- plot_ly(df, x = ~Year, y = ~Knowing, type = 'bar', name = 'Knowing',color=I("#A481DE"))%>% 
        add_trace(y = ~Applying, name = 'Applying', color=I("#5587DE"))%>% 
        add_trace(y = ~Reasoning, name = 'Reasoning',color=I("#6A5787")) %>% 
        layout(yaxis = list(rangemode="tozero",title = 'Count'), barmode = 'group')
        
    }
    }
      
    fig
      
  #####scatter
    
  })
  output$plotly_scatter_all <- renderPlotly({
    
    if(input$plotly_math_class == "4th"){
      if(input$plotly_math_type == "Content"){
        data <- M4_content_2019
      }else{
        data<- M4_cognitive_2019
      }
      
    }else{
      if(input$plotly_math_type == "Content"){
        data <- M8_content_2019
      }else{
        data<- M8_cognitive_2019
      }
    }
    
    
    if(input$plotly_scatter_all_sort == "Yes"){
      chosen_type = 2
      data <-  data[order(data[chosen_type]),]
      data$Country <- factor(data$Country, levels = data$Country)
      
    }
    
      if (input$plotly_scatter_choice == "Overall Average"){
        
        figa <- plot_ly(data = data, x = ~Country, y = ~`Overall Average`, name="Overall Average" ,
                        type = "scatter", mode = "markers", color=I("#6A5787")) %>%
          layout(yaxis=list(rangemode = "tozero",title="Score"))
        
      }else{
        
        if(input$plotly_math_type == "Content"){
          if (input$plotly_math_class == "4th"){
            figa <- plot_ly(data = data, x = ~Country, y = ~Number, name = colnames(data)[3],
                            type = "scatter", mode = "markers", color=I("#6A5787")) %>% 
              add_trace(y = ~`Measurement and Geometry`, name = colnames(data)[4], type = "scatter", mode = 'markers', color=I("#FFCE68")) %>%
              add_trace(y = ~Data, name = colnames(data)[5], type = "scatter", mode = 'markers',color=I("#B0A8B9")) %>%
              layout(yaxis=list(rangemode = "tozero",title="Score"))
          }else{
            figa <- plot_ly(data = data, x = ~Country, y = ~Number, name = colnames(data)[3],
                            type = "scatter", mode = "markers",color=I("#6A5787")) %>% 
              add_trace(y = ~Algebra, name = colnames(data)[4], type = "scatter", mode = 'markers',color=I("#FFCE68")) %>%
              add_trace(y = ~Geometry, name = colnames(data)[5], type = "scatter", mode = 'markers',color=I("#B0A8B9")) %>%
              add_trace(y = ~`Data and Probability`, name = colnames(data)[5], type = "scatter", mode = 'markers', color=I("#0087CC")) %>%
              layout(yaxis=list(rangemode = "tozero",title="Score"))
          }
          
          
        
          
        }else{
          figa <- plot_ly(data = data, x = ~Country, y = ~Knowing, name = colnames(data)[3],
                          type = "scatter", mode = "markers",color=I("#6A5787")) %>% 
            add_trace(y = ~Applying, name = colnames(data)[4], type = "scatter", mode = 'markers',color=I("#FFCE68")) %>%
            add_trace(y = ~Reasoning, name = colnames(data)[5], type = "scatter", mode = 'markers',color=I("#B0A8B9")) %>%
            layout(yaxis=list(rangemode = "tozero",title="Score"))
          
        }
        }
      
    
    figa
    
  })
  

}