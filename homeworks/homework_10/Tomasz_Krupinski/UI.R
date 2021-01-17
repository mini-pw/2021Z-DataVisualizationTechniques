library(shiny)
library(ggplot2)


ui <- fluidPage(
  
  titlePanel("TIMSS 2019 - average score summary"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("subject", 
                  label = h3("Subject"),
                  choices = c("Mathematics", "Science"),
                  selected = "Mathematics"),
      radioButtons("grade", h3("Grade"),
                   choices = list("Grade 4" = 1, "Grade 8" = 2), selected = 1),
      radioButtons("sex", h3("Sex"),
                   choices = list("Girls" = 3, "Boys" = 4, "Both" = 2), selected = 2),
      radioButtons("plottype", h3("Plot type"),
                   choices = list("Barplot" = 1, "Density" = 2)),
      width = 2),
    mainPanel(
      plotOutput("plot", height = 900, width = 1500)
    )
  )
)