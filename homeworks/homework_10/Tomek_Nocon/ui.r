library(DT)
library(shiny)
library(plotly)
library(shinyWidgets)
library(tidyr)

fluidPage(
  setBackgroundColor(color="skyblue"),
  
  titlePanel(h1("TIMSS 2019 - Trends in International Mathematics and Science Study",
                style='color:white;
                padding-left: 15px')),
  tags$style(HTML("
                  .tabbable > .nav > li > a                  {background-color: white;  color:skyblue}
                  .tabbable > .nav > li[class=active]    > a {background-color: skyblue; color:white}
                  ")),
  tabsetPanel(
    
    tabPanel("Math", icon = icon("calendar-alt"), fluid = TRUE,
             style="color:white; background-color: white; border-color: white",
             sidebarLayout(
               sidebarPanel(setSliderColor("skyblue", 1), 
                            sliderInput("sliderData", "Choose data period", 
                                        min = 1995, max = 2019, value = c(1995,2019)),
                            tags$style(type = "text/css",
                                       HTML(
                                         ".irs-from, .irs-to, .irs-single { color: black; background: skyblue }")
                            ),
                            tags$style(".well {background-color:white;}"),
                            actionButton(inputId="boys",label="Boys",width=200,
                                         style="color: white; background-color: skyblue; border-color: white"),
                            actionButton(inputId="girls",label="Girls",width=200,
                                         style="color: white; background-color: skyblue; border-color: white"),
                            selectInput(
                              inputId = "input_1",
                              label = "Select plot data",
                              choices = c(
                                "Armenia" = "Armenia",
                                "Australia" = "Australia",
                                "Austria" = "Austria",
                                "Azerbaijan" = "Azerbaija",
                                "Bahrain" = "Bahrain",
                                "Belgium (Flemish)" = "Belgium (Flemish)",
                                "Bulgaria" = "Bulgaria",
                                "Canada" = "Canada",
                                "Chile" = "Chile",
                                "Chinese Taipei" = "Chinese Taipe",
                                "Croatia" = "Croatia",
                                "Cyprus" = "Cyprus",
                                "Czech Republic" = "Czech Republic",
                                "Denmark" = "Denmar",
                                "England" = "England",
                                "Finland" = "Finland",
                                "France" = "France",
                                "Georgia" = "Georgia",
                                "Germany" = "Germany",
                                "Hong Kong SAR" = "Hong Kong SAR",
                                "Hungary" = "Hungary",
                                "Iran, Islamic Rep. of" = "Iran, Islamic Rep. of",
                                "Ireland" = "Ireland",
                                "Italy" = "Italy",
                                "Japan" = "Japan",
                                "Kazakhstan" = "Kazakhstan",
                                "Korea, Rep. of" = "Korea, Rep. of",
                                "Kuwait" = "Kuwait",
                                "Latvia" = "Latvia",
                                "Lithuania" = "Lithuania",
                                "Malta" = "Malta",
                                "Morocco" = "Morocco",
                                "Netherlands" = "Netherlands",
                                "New Zealand" = "New Zealand",
                                "Northern Ireland" = "Northern Ireland",
                                "Oman" = "Oman",
                                "Philippines" = "Philippines",
                                "Poland" = "Poland",
                                "Portugal" = "Portuga",
                                "Qatar" = "Qatar",
                                "Russian Federation" = "Russian Federation",
                                "Saudi Arabia" = "Saudi Arabia",
                                "Serbia" = "Serbia",
                                "Singapore" = "Singapore",
                                "Slovak Republic" = "Slovak Republic",
                                "South Africa (5)" = "South Africa (5)",
                                "Spain" = "Spain",
                                "Sweden" = "Sweden",
                                "United Arab Emirates" = "United Arab Emirate",
                                "United States" = "United States",
                                "Ontario, Canada" = "Ontario, Canada",
                                "Quebec, Canada" = "Quebec, Canada",
                                "Abu Dhabi, UAE" = "Abu Dhabi, UAE",
                                "Dubai, UAE" = "Dubai, UAE"
                              ))),
               
               mainPanel(plotlyOutput("pl3")
               )
             )
    )
  )
  )