source("FeaturesJSON.R")
library(jsonlite)
library(plotly)
library(dplyr)
library(ggplot2)
library(shiny)
library(reshape2)
sinskiFeatures <- fromJSON(sinskiTrackJSON)[[1]]
szmejFeatures <- fromJSON(szmejTrackJSON)[[1]]
smolenFeatures <- fromJSON(smolenTrackJSON)[[1]]

sinskiFeatures <- sinskiFeatures %>% 
  select(danceability,acousticness,energy,instrumentalness,liveness,valence,tempo) %>%
  summarise(across(.fns = mean)) %>% mutate(tempo = tempo/300) %>% melt(variable.name = "features")

szmejFeatures <- szmejFeatures %>% 
  select(danceability,acousticness,energy,instrumentalness,liveness,valence,tempo) %>%
  summarise(across(.fns = mean)) %>% mutate(tempo = tempo/300) %>% melt(variable.name = "features")

smolenFeatures <- smolenFeatures %>% 
  select(danceability,acousticness,energy,instrumentalness,liveness,valence,tempo) %>%
  summarise(across(.fns = mean)) %>% mutate(tempo = tempo/300) %>% melt(variable.name = "features")



ui <- fluidPage(
  fluidRow(
    column(4,
           checkboxGroupInput("wybor_ludzia", 
                        label = "",
                        choices = list("Jan Smoleń" = 1, "Szymon Szajdziński" = 2, "Bartosz Siński" = 3))
          
           ),
    column(8,
           plotlyOutput("radar_plot"))
  )
)

server <- function(input,output,session){
  output$radar_plot <- renderPlotly({
    fig <- plot_ly(
      r = rep(0,7),
      theta =smolenFeatures$features,
      showlegend = FALSE,
      fillcolor = 'rgb(0,0,0,0)',
      type = 'scatterpolar',
      fill = 'toself',
      mode = 'markers',
      width = 700, 
      height = 700
    )
    if (length(input$wybor_ludzia) == 1){
      if(input$wybor_ludzia == 1){
        fig <- fig %>%
          add_trace(
            r = as.factor(smolenFeatures$value),
            theta =smolenFeatures$features,
            name = 'Smolen',
            fillcolor = 'rgba(76,175,80,0.4)',
            marker = list(
              color = 'rgba(76,175,80,1)',
              size = 8
            )
          ) 
      } else if(input$wybor_ludzia==2){
        fig <- fig %>%
          add_trace(
            r = as.factor(szmejFeatures$value),
            theta = szmejFeatures$features,
            name = 'Szmaja',
            fillcolor = 'rgba(244,67,54,0.4)',
            marker = list(
              color = 'rgba(244,67,54,1)',
              size = 8
              
            )
          ) 
      } else if(input$wybor_ludzia==3){
        fig <- fig %>%
          add_trace(
            r = as.factor(sinskiFeatures$value),
            theta = sinskiFeatures$features,
            name = 'Sinski',
            fillcolor = 'rgba(120,200,300,0.4)',
            marker = list(
              color = 'rgba(120,200,300,1)',
              size = 8
            )
          ) 
      }
    } else if(length(input$wybor_ludzia) == 2){
      if(all(input$wybor_ludzia== c(1 ,2))){
        fig <- fig %>%
          add_trace(
            r = as.factor(szmejFeatures$value),
            theta = szmejFeatures$features,
            name = 'Szmaja',
            fillcolor = 'rgba(244,67,54,0.4)',
            marker = list(
              color = 'rgba(244,67,54,1)',
              size = 8
            )
          ) 
        fig <- fig %>%
          add_trace(
            r = as.factor(smolenFeatures$value),
            theta =smolenFeatures$features,
            name = 'Smolen',
            fillcolor = 'rgba(76,175,80,0.4)',
            marker = list(
              color = 'rgba(76,175,80,1)',
              size = 8
            )
          )
      } else if(all(input$wybor_ludzia== c(2 ,3))){
        fig <- fig %>%
          add_trace(
            r = as.factor(szmejFeatures$value),
            theta = szmejFeatures$features,
            name = 'Szmaja',
            fillcolor = 'rgba(244,67,54,0.4)',
            marker = list(
              color = 'rgba(244,67,54,1)',
              size = 8
            )
          ) 
        fig <- fig %>%
          add_trace(
            r = as.factor(sinskiFeatures$value),
            theta = sinskiFeatures$features,
            name = 'Sinski',
            fillcolor = 'rgba(120,200,300,0.4)',
            marker = list(
              color = 'rgba(120,200,300,1)',
              size = 8
            )
          ) 
      } else if(all(input$wybor_ludzia== c(1 ,3))){
        fig <- fig %>%
            add_trace(
              r = as.factor(smolenFeatures$value),
              theta =smolenFeatures$features,
              name = 'Smolen',
              fillcolor = 'rgba(76,175,80,0.4)',
              marker = list(
                color = 'rgba(76,175,80,1)',
                size = 8
              )
            ) 
        fig <- fig %>%
          add_trace(
            r = as.factor(sinskiFeatures$value),
            theta = sinskiFeatures$features,
            name = 'Sinski',
            fillcolor = 'rgba(120,200,300,0.4)',
            marker = list(
              color = 'rgba(120,200,300,1)',
              size = 8
            )
          ) 
      } 
      } else if(length(input$wybor_ludzia) == 3){
        fig <- fig %>%
          add_trace(
            r = as.factor(sinskiFeatures$value),
            theta = sinskiFeatures$features,
            name = 'Sinski',
            fillcolor = 'rgba(120,200,300,0.4)',
            marker = list(
              color = 'rgba(120,200,300,1)',
              size = 8
            )
          ) 
        fig <- fig %>%
          add_trace(
            r = as.factor(szmejFeatures$value),
            theta = szmejFeatures$features,
            name = 'Szmaja',
            fillcolor = 'rgba(244,67,54,0.4)',
            marker = list(
              color = 'rgba(244,67,54,1)',
              size = 8
            )
          ) 
        fig <- fig %>%
          add_trace(
            r = as.factor(smolenFeatures$value),
            theta =smolenFeatures$features,
            name = 'Smolen',
            fillcolor = 'rgba(76,175,80,0.4)',
            marker = list(
              color = 'rgba(76,175,80,1)',
              size = 8
            )
          ) 
      } 
    m <- list(
      l = 50,
      r = 50,
      b = 100,
      t = 100,
      pad = 4
    )
    fig <- fig %>%
      layout(
        polar = list(
          radialaxis = list(
            visible = T,
            range = c(0,1)
          )
        ),
        legend = list(
          itemclick = FALSE,
          itemdoubleclick = FALSE
        ),
        autosize = F,
        margin = m
      )
    return(fig)
  })
}
shinyApp(ui = ui, server = server)


