library(shiny)
library(ggplot2)
library(plotly)
shinyUI(
  fluidPage(
    titlePanel("Year In Review : Our Spotify in 2020"),
    tabsetPanel(
      tabPanel("Main Statistics",fluid = TRUE,
        fluidPage(
          fluidRow(
            column(3,
                   checkboxGroupInput("kto_slucha", 
                                      label = "",
                                      choices = list("Janek" = "Janek", "Szymon" = "Szymon", "Bartek" = "Bartek"),
                                      selected = "Janek")
                   ),
            column(9,
                   (plotlyOutput("bar_year"))
                   )
          ),
          fluidRow(
            column(6, 
                   plotlyOutput("radar_plot")
                   ),
            column(6,tags$h4("    Favourite common artists"),
                   forceNetworkOutput("graph")
                   )
          )
          )
        ),
    tabPanel("Our favourite artists ", fluid = TRUE,
             sidebarPanel(width=2,
                          selectInput("person", "Choose person:",
                                      c("Bartek" = "Sinski",
                                        "Janek" = "Smolen",
                                        "Szymon" = "Szmej"), selectize = FALSE)
             ),
             
             
             mainPanel( 
               
               fluidRow(column(10,
                               plotOutput("q"))),
               
               fluidRow( column( 10,
                                 sliderInput("range",
                                             min = as.Date("2020-01-01"), max = as.Date("2020-11-30"),
                                             label = "",
                                             value = c(as.Date("2020-03-01"), as.Date("2020-06-01")), step=1,
                                             width="80%"))),
               hr(),
               
               fluidRow(column(10,
                               plotOutput("p"))),
               
               fluidRow( column( 10,
                                 sliderInput("date",
                                             min = as.Date("2020-01-01"), max = as.Date("2020-11-30"),
                                             label = "",
                                             value = as.Date("2020-11-30"), step = 2,
                                             width="80%",
                                             animate =
                                               animationOptions(interval = 500, loop = FALSE))))
             )
    )
    )
  )
)
