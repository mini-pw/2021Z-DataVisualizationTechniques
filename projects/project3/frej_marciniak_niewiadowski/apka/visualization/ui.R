library(shiny)
library(shinyWidgets)
library(DT)
library(png)
library(plotly)

shinyUI(fluidPage(
    
    titlePanel(h1("Our usage of PCs", align = "center")),

    fluidRow(
        
        column(
            plotlyOutput("application", height = 500),
            plotlyOutput("app_activity"),
            width = 6
        ),
        column(
            sliderInput("DatesMerge",
                        "Time range:",
                        min = as.Date("2020-12-20","%Y-%m-%d"),
                        max = as.Date("2021-01-15","%Y-%m-%d"),
                        value=c(as.Date("2020-12-20"), as.Date("2021-01-15")),
                        timeFormat="%Y-%m-%d",
                        animate = TRUE,
                        width = 900),
            checkboxGroupButtons(
                inputId = "nameButton", label = "People: ",
                choiceNames = c(HTML("<p style=\"color:black;font-size:20px;background-color:#E69F00\">Adam</p>"),
                                HTML("<p style=\"color:black;font-size:20px;background-color:#009E73\">Paweł</p>"),
                                HTML("<p style=\"color:black;font-size:20px;background-color:#56B4E9\">Piotr</p>")),
                choiceValues = c("Adam", "Pawel", "Piotr"),
                justified = TRUE, status = "primary",
                checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon")),
                selected = c("Adam", "Pawel", "Piotr"),
            ),
            plotlyOutput("plot_clicks"),

            fluidRow(
                column(6, align="center", imageOutput("mouse", height = 350, click = "mouse_click")),
                column(6, align="center", "Click me!",imageOutput("key", height = 350, click = "key_click")),
                
            ),
            
            
            width = 6

        )

    )
))
