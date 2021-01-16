library(shiny)
library(plotly)
library(ggplot2)
library(tidyr)
library(shinyjs)
library(shinythemes)


navbarPage(
    "TIMSS 2019",
    theme  = shinytheme("sandstone"),
    tabPanel(
        "Results",
        tags$style(type="text/css",
                        ".shiny-output-error { visibility: hidden; }",
                        ".shiny-output-error:before { visibility: hidden; }"
        ),
        
        pageWithSidebar(
            headerPanel("Trends in International Mathematics and Science Study - 2019"),
            sidebarPanel(
                selectInput(
                    "subject",
                    label = "Subject:",
                    choices = c("Math" = "M", "Science" = "S"),
                ),
                selectInput(
                    "grade",
                    label = "Grade:",
                    choices = c("4th" = "4", "8th" = "8"),
                ),
                sliderInput(
                    "how_many",
                    label = "Countries to display (by ranking):",
                    min = 1,
                    max = 58,
                    value = c(1, 58)
                ),
                selectInput("country",
                            label = "Country to highlight:",
                            M4$Country,
                            character(0)),
                
                h2("About project"),
                "This Shiny app is a project for my Data Visualization Techniques course.", 
                "The app enables the analysis of data from Trends in 
                International Mathematics and Science Study 2019 Report.",
                "You can find more info and data", a("here.", href="https://timssandpirls.bc.edu/timss2019/index.html")
            ),
            
            mainPanel(
                tabsetPanel(
                    tabPanel(align = "center", icon = icon("graduation-cap"),
                        "Countries' Achievment",
                        plotlyOutput("barplot", height = "800px")
                    ),
                    tabPanel(align = "center", icon = icon("laptop"),
                        "Computer access",
                        plotlyOutput("scatterplot", height = "800px", width = "80%"),
                        br(),
                        hr(),
                        br(),
                        plotlyOutput("barplot2", height = "500px", width = "60%"),
                        "Note that teachers could indicate the class having more than one type of computer access."
                    )
                )
            )
        )
    )
)
