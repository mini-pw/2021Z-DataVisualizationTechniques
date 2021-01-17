library(shiny)
library(ggplot2)
library(plotly)

countries <- read.csv("countries.csv", stringsAsFactors = FALSE)
countries <- countries[-1, ]
countries <- sort(countries)

shinyUI(fluidPage(

    titlePanel("A glimpse of TIMSS data"),

    sidebarLayout(
        sidebarPanel(
            helpText("Hint: Try to type in text!"),
            
            selectizeInput("grade", 
                        label = "Select grade:", 
                        choices = list("4th grade" = "4", "8th grade" = "8"), 
                        selected = 1),
            
            selectizeInput("subject", 
                        label = "Select subject:", 
                        choices = list("mathematics" = "M", "science" = "S"), 
                        selected = 1),
            
            selectizeInput("country",
                           label = "Select country:",
                           choices = countries,
                           selected = "Poland")
        ),

        mainPanel(
            tabsetPanel(
                tabPanel("Boxplot",
                         h4("Plot shows how the TIMSS results have changed over the past few years."),
                         plotlyOutput("boxplot", height = 600, width = 800)),
                
                tabPanel("Barplot",
                         h4("Plot shows how the TIMSS results have changed over the past few years by gender."),
                         plotlyOutput("barplot", height = 600, width = 800)),
                
                tabPanel("Sources",
                         tags$a(href="https://timss2019.org/reports/download-center/", target="_blank", 
                                "TIMSS 2019 Mathematics and Science"),
                         verbatimTextOutput("newline1"),
                         tags$a(href="http://timssandpirls.bc.edu/timss2015/international-results/timss-2015/mathematics/appendices/", target="_blank", 
                                "TIMSS 2015 Mathematics"),
                         verbatimTextOutput("newline2"),
                         tags$a(href="http://timssandpirls.bc.edu/timss2015/international-results/timss-2015/science/appendices/", target="_blank", 
                                "TIMSS 2015 Science"),
                         verbatimTextOutput("newline3"),
                         tags$a(href="https://timssandpirls.bc.edu/timss2011/international-results-mathematics.html", target="_blank", 
                                "TIMSS 2011 Mathematics"),
                         verbatimTextOutput("newline4"),
                         tags$a(href="https://timssandpirls.bc.edu/timss2011/international-results-science.html", target="_blank", 
                                "TIMSS 2011 Science"),
                         verbatimTextOutput("newline5"),
                         tags$a(href="https://pdftables.com/", target="_blank", 
                                "PDF tables converter")),
                
                tabPanel("Author",
                         "Hi, I'm Adrian and this is my Shiny app for Data Visualization course for Data Science studies at MiNI, WUT.",
                         verbatimTextOutput("newline6"),
                         tags$a(href="https://github.com/adrianstando/Various-Data-Visualisation/tree/main/TIMSS_2019", target="_blank", 
                                "Link to the source code of this app."))
            )
        )
    )
))
