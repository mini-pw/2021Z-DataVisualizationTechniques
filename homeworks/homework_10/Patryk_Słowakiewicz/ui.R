library(DT)
library(plotly)

source("Load.R", local = F)


pageWithSidebar(
  headerPanel("3 visualizations of TIMSS2019"),
  sidebarPanel(
    
    selectInput("country_select",
                label = "Select country: ",
                choices = M4$Country,
                selected = "Poland"),
    
    textOutput("text1"),
    textOutput("text2"),
    textOutput("text3"),
    
    
    sliderInput("range",
                min = 1, max = length(M4$Country), value = c(1, 65),
                label = "Select Range of Countries: ", step = 1),
    h5("Visualisations shows Score from math and science of chosen countries.
    As a user, you can choose a reference country, marked as the red line.
    The range of countries can be chosen by the slide bar.
       The factor of choice is Score from math.")
    
  ),
  mainPanel(
    plotlyOutput("plotly_1"),
    plotlyOutput("plotly_2"),
    plotlyOutput("plotly_3"),
  )
)

