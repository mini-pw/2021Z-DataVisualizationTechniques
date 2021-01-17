library(DT)
library(shiny)
library(plotly)
library(shinyWidgets)

fluidPage(
  setBackgroundColor(color="#57a800"),
  
  titlePanel(h1("Running data",
                style='color:white;
                     padding-left: 15px')),
  tags$style(HTML("
    .tabbable > .nav > li > a                  {background-color: white;  color:#57a800}
    .tabbable > .nav > li[class=active]    > a {background-color: #57a800; color:white}
  ")),
    tabsetPanel(
      
      tabPanel("Training days", icon = icon("calendar-alt"), fluid = TRUE,style="color:white; background-color: white; border-color: white",
               sidebarLayout(
                 sidebarPanel(setSliderColor("#57a800", 1), sliderInput("sliderData", "Choose data period", 
                                                                        min = tail(df$date,1), max = head(df$date, 1), value = c(tail(df$date,1), head(df$date,1))),
                              tags$style(type = "text/css",
                                         HTML(
                                           ".irs-from, .irs-to, .irs-single { color: black; background: #57a800 }")
                              ),
                              tags$style(".well {background-color:white;}"),
                              actionButton(inputId="p1",label="Days",width=200,style="color: white; background-color: #57a800; border-color: white"),
                              actionButton(inputId="p2",label="Months",width=200,style="color: white; background-color: #57a800; border-color: white")),
                 mainPanel(plotlyOutput("pl3")
                 )
               )
      ),
      tabPanel("Weather", icon = icon("cloud-sun-rain"), fluid = TRUE, class = 'rightAlign',style="color:#57a800; background-color: white; border-color: #D2CFCF",
               sidebarLayout(
                 sidebarPanel(
                              selectInput(
                                inputId = "input_1",
                                label = "Select plot data",
                                choices = c(
                                  "Distance" = "s",
                                  "Time" = "t",
                                  "Speed" = "v"
                                ))
                 ),
                
                 mainPanel(
                   plotOutput("plotly",click="test"),
                   h5("Click on the boxplot with chosen precipitation type and discover which training sessions bellow took place on the day choosen type of precipitation was recorded."),
                   plotlyOutput("plotly4")
                 )
               )
      ),
      tabPanel("Autocorelation", 
               icon = icon("chart-line"), 
               fluid = TRUE, 
               style="color:#57a800; background-color: white; border-color: #D2CFCF",
               
               sidebarPanel(
                 tags$style(type = "text/css",
                            HTML(
                              ".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar { color: black; background: #57a800 }")),
                 sliderInput("correlation_lag", "Lag between trainings",
                             min = 0, max = 22,
                             value = 1)
                 ),
               hr(),
               plotOutput("autocorrelation_plot"),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               plotOutput("autocorrelation_random_plot")
               )
      )
  )