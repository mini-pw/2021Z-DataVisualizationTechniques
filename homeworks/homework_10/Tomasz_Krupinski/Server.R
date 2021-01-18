library(shiny)
library(dplyr)
library(ggplot2)

function(input, output) {
  m4Results <- read.csv("m4Results.csv")
  m4Results <- m4Results[-1]
  s4Results <- read.csv("s4Results.csv")
  s4Results <- s4Results[-1]
  m8Results <- read.csv("m8Results.csv")
  m8Results <- m8Results[-1]
  s8Results <- read.csv("s8Results.csv")
  s8Results <- s8Results[-1]
  
  
  output$plot <- renderPlot({

    
    df <- switch(
      input$subject,
      "Mathematics" = {
        if(input$grade == 1) {
          select(m4Results, 1, as.numeric(input$sex))
        }
        else {
          select(m8Results, 1, as.numeric(input$sex))
        }
      },
      "Science" = {
        if(input$grade == 1) {
          select(s4Results, 1, as.numeric(input$sex))
        }
        else {
          select(s8Results, 1, as.numeric(input$sex))
        }
      }
    )
    if(input$plottype == 1) {
      df <- mutate(df, cond = if_else(df[2] > mean(df[[2]]), "Higher\nthan\naverage","Lower\nthan\naverage"))
      print(head(df))
      ggplot(data=df, aes_string(x = names(df)[1],y = names(df)[2], fill=names(df)[3])) +
        geom_bar(stat="identity") +
        theme_minimal() +
        theme(
          panel.grid.major.x = element_blank(),
          axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
          text = element_text(size = 20),
          axis.title.x = element_blank(),
          legend.title = element_blank()
        ) +
        ylab("Average score")+
        scale_fill_manual(values=c("#2f8f49", "#8f2f2f"))
    }
    else {
      ggplot(data=df, aes_string(x=names(df)[2])) +
        geom_density(fill="#369e52", alpha=0.6) +
        theme_minimal() +
        theme(
          text = element_text(size = 20)
        ) +
        xlab("Average score") +
        ylab("Kernel density estimation")
    }
  })
}