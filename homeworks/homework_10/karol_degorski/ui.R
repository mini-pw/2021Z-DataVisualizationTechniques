library(shiny)
library(plotly)

source("timss-get-data.R")
source("top10_data.R")

navbarPage("Results of TIMSS",
           tabPanel("Summary results of TIMSS 2019",
pageWithSidebar(
    headerPanel("Summary results of TIMSS 2019 on country level"),
    sidebarPanel(
        selectInput("Kraje",
                    label = "Countries:",
                    choices = c("all", "European Union"),
                    selected = "all"),
        helpText("Note: not all of the countries have eighth grade"),
        helpText("There is data about 58 countries for students in fourth grade and 39 for students in eighth grade"),
        selectInput("Klasa",
                    label = "Class:",
                    choices = c("fourth", "eighth"),
                    selected = "fourth"),
        selectInput("Przedmiot",
                    label = "Subject:",
                    choices = c("mathematics", "science"),
                    selected = "mathematics"),
        uiOutput("Polska")
    ),
    mainPanel(
        plotlyOutput("plotly_1", height = 700)
    )
)
),
tabPanel("Results of TIMSS 2019 - comparision",
         pageWithSidebar(
             headerPanel("Comparision of TIMSS 2019 results by countries and gender"),
             sidebarPanel(
                 helpText("Note: not all of the countries have eighth grade"),
                 selectInput("Klasa22",
                             label = "Class:",
                             choices = c("fourth", "eighth"),
                             selected = "fourth"),
                 selectInput("Przedmiot22",
                             label = "Subject:",
                             choices = c("mathematics", "science"),
                             selected = "mathematics"),
                 uiOutput("Kraj22"),
                 uiOutput("Kraj23"),
             ),
             mainPanel(
                 plotlyOutput("plotly_22")
             )
         )
),
tabPanel("TOP 10 TIMSS",
         pageWithSidebar(
             headerPanel("TOP 10 TIMSS scores on country level"),
             sidebarPanel(
                 selectInput("Rok3",
                             label = "Year:",
                             choices = c("2011", "2015", "2019"),
                             selected = "2019"),
                 selectInput("Klasa3",
                             label = "Class:",
                             choices = c("fourth", "eighth"),
                             selected = "fourth"),
                 selectInput("Przedmiot3",
                             label = "Subject:",
                             choices = c("mathematics", "science"),
                             selected = "mathematics"),
                 helpText("Note: in case that two countires have the same score, their score is shown in different bars")
             ),
             mainPanel(
                 plotlyOutput("plotly_3")
             )
         )
),
tabPanel("About me and data",
         h3("About me"),
         "My name is Karol Degórski and I am a Data Science student at Warsaw University of Technology.
         This Shiny app has been prepared as a homework for one of my subjects - Data Visualization Techniques.",
         
         h3("About data"),
         "TIMSS is an international assessment of student achievement in mathematics and science.
         The data used to prepared this Shiny app comes from the official website:", 
         tags$a(href="https://timss2019.org/reports/download-center/", "https://timss2019.org/reports/download-center/"),
         "and from Wikipedia:", 
         tags$a(href="https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study", "https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study")
         
)
)