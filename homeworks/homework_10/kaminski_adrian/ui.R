library(shiny)
library(shinyjs)
library(ggiraph)
library(shinythemes)

fluidPage(theme = shinytheme("lumen"),
  tags$head(
    tags$link(
      rel="shortcut icon",
      href="https://i5.walmartimages.com/asr/49872d80-f8cd-4c2d-af8c-089045239ddc_1.1ca82d1da745d57f02e1ca53d3baa402.jpeg"
      )
    ),
  titlePanel(
    h1("TIMSS-2019 Scores in Home and School Contexts", align = "center"), windowTitle = "TIMSS-2019"
    ), hr(),
  useShinyjs(),
  tags$style(
    type='text/css', "ul.nav.nav-tabs{border-color: #f5f5f5;background-color: #f5f5f5;hidden: true;}"),

  tabsetPanel(id="tabs",
    tabPanel(title = "01",value = "panel01",
    fluidPage(
      fluidRow(
        column(width = 2,
               actionButton("prev01", "About data and author",
                            icon = icon("menu-left", lib = "glyphicon"),
                            width = "200px")
        ),
        column(width = 2, offset = 8,
               actionButton("next01",
                            div("About scales", icon("menu-right", lib = "glyphicon")),
                            width = "200px"),
               align = 'right'
        )),
      br(),
      fluidRow(
        column(width = 2,
               style = "background-color:#EDECEB;border-radius:10px 20px 10px 20px;",
               h6(),
               radioButtons("subject", label = "Choose subject:",
                            choices = c("Mathematic", "Science"), inline=F),
               radioButtons("grade", "Choose grade:",
                            choices = c(4, 8), inline = T),
               radioButtons("type", label = "Show scores in the context of:",
                            choices = c(
                              "Home Resources"="Home",
                              "School Discipline"="School"),
                            selected = "Home"),
               selectInput("country", "Chosen countries:",
                           choices = '',
                           multiple = TRUE),
               helpText("Note: second plot is showing only
                        countries that have been chosen.
                        You can choose a country by selecting name (above)
                        or by clicking a dot on a plot.
                        Try using lasso (de)selection
                        (toolbar is in the top right corner of the plot)
                        to select more than one country at once."),
               actionButton("clear", "Clear chosen countries", 
                            style="background-color: #cccaca;border-color: #b7b5b5"),
               helpText("Note: you can use this button
                        to remove all selected countries instead of
                        removing them one by one or using 
                        lasso deselection.")
        ),
        column(width = 10, align="center",
               girafeOutput("plot1", width = "1100px", height = "380px"),
               girafeOutput("plot2", width = "1100px", height = "380px")
        )
      )
    )
    ),
    tabPanel(title = "02", value = "panel02",
             
            fluidPage(
              
              fluidRow(
                column(width = 2,
                       actionButton("prev02", "Main panel",
                                    icon = icon("menu-left", lib = "glyphicon"),
                                    width = "200px")
                ),
                column(width = 2, offset = 8,
                       actionButton("next02",
                                    div("About data and author",
                                        icon("menu-right", lib = "glyphicon")),
                                    width = "200px"),
                       align = 'right'
                )),
              fluidRow(
                column(width = 8, offset = 2, align = "center",
                       tags$h3("Inforamtions about scales comes directly from offical TIMSS website"))
              ),
              fluidRow(
                column(width = 6, align="center",
                       tags$h4("Home Resources for Learning - Scale", align="center"),
                       tags$iframe(style="height:487px; width:650px; overflow: hidden", scrolling="yes", 
                                   src="home-resources-scale.pdf")
                       ),
                column(width = 6, align="center",
                       tags$h4("School Discipline – Principals’ Reports - Scale", align="center"),
                       tags$iframe(style="height:487px; width:650px; overflow: hidden", scrolling="yes", 
                                   src="school-discipline-scale.pdf")
                       )
                )
            )
    ),
    tabPanel(title = "03", value = "panel03",
             
             fluidPage(
               
               fluidRow(
                 column(width = 2,
                        actionButton("prev03", "About scales",
                                     icon = icon("menu-left", lib = "glyphicon"),
                                     width = "200px")
                 ),
                 column(width = 2, offset = 8,
                        actionButton("next03", div("Main panel",
                                                   icon("menu-right", lib = "glyphicon")),
                                     width = "200px"),
                        align = 'right'
                 )),
               fluidRow(
                 column(width = 6, offset = 3,
                        h3("About data"),
                        "TIMSS is an international assessment of
                        the mathematics and science knowledge of students around the world.",
                        h6(),
                        "The data used to prepare this Shiny app comes from the official website: ", 
                        tags$a(href="https://timss2019.org/reports/download-center/", "timss2019.org"),".",
                        br(),
                        tags$a(href="https://timssandpirls.bc.edu/about.html",
                               "More information about TIMSS"),
                        hr(),
                        h3("About author"),
                        "Hi, I'm Adrian Kaminski and I am a second year student 
                        in Faculty of Mathematics and Information Science at Warsaw University of Technology
                        in the field of Engineering and Data Science.",
                        h6(),
                        "This small Shiny app has been prepared as a homework for one of my subjects
                        - Data Visualization Techniques.",
                        h6(),
                        "Code is available here: ",
                        tags$a(href="https://github.com/mini-pw/2021Z-DataVisualizationTechniques/tree/master/homeworks/homework_10/kaminski_adrian",
                               "github.com/mini-pw/2021Z-DataVisualizationTechniques/tree/master/homeworks/homework_10/kaminski_adrian"),
                        )
               )
             )
    )
  )
)
