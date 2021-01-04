#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(ggrepel)

pageWithSidebar(
    headerPanel("Average scores (2019)"),
    sidebarPanel(
        selectInput("plot_selection", 
                    label = "Select which average scores you want to see on plot",
                    choices = list("Math - 4th grade" = 1, "Math - 8th grade" = 2,
                                "Science - 4th grade" = 3, "Science - 8th grade" = 4),
                    selected = "Math - 4th grade"),
        sliderInput("number_of_countries",
                    label = "Number of countries",
                    min = 1, max = 40, value= 20),
        h4("Attitude: represents student's average attitude toward the subject. The higher the score, the more students like that subject. 
           Resources: represent things like books, internet access etc."),
        h4("Warning: some data on the scatter plot may be missing"),
        h5("Source:"),
         "https://timss2019.org/reports/download-center/"
        
    ),
    mainPanel(
        plotOutput("plot_1"),
        plotOutput("plot_2")
    )
    
)


