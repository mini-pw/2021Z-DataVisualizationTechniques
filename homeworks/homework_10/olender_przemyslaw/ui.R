library(shiny)
library(ggplot2)
library(plotly)

url = "https://timssandpirls.bc.edu/timss2019/index.html"

fluidPage(
  headerPanel('TIMSS results overview'),
  tagList("Based on data from TIMSS: ", url),
  h6("author of the app: Przemysław Olender"),
  tabsetPanel(
    tabPanel("TIMSS ranking",
             sidebarPanel(
               selectInput("year",
                           label = "select year",
                           choices = list("2015", "2019"),
                           selected = 1
                 
               ),
               selectInput("grade",
                           label = "select grade",
                           choices = list("4th grade" = "4", "8th grade" = "8"),
                           selected = 1
                 
               ),
               selectInput("subject",
                           label = "select subject",
                           choices = list("mathematics" = "m", "science" = "s"),
                           selected = 1
               )
             ),
             mainPanel(
               plotlyOutput("barplot", width = "100%", height = "600px")
             )
              
    ),
    tabPanel("Results comparison",
             sidebarPanel(
                h4("Chose data for X axis:"),
                selectInput("xyear",
                            label = "select year",
                            choices = list("2015", "2019"),
                            selected = 1
                            
                ),
                selectInput("xgrade",
                            label = "select grade",
                            choices = list("4th grade" = "4", "8th grade" = "8"),
                            selected = 1
                            
                ),
                selectInput("xsubject",
                            label = "select subject",
                            choices = list("mathematics" = "m", "science" = "s"),
                            selected = 1
                ),
                h4("Chose data for Y axis:"),
                selectInput("yyear",
                            label = "select year",
                            choices = list("2015", "2019"),
                            selected = 1
                            
                ),
                selectInput("ygrade",
                            label = "select grade",
                            choices = list("4th grade" = "4", "8th grade" = "8"),
                            selected = 1
                            
                ),
                selectInput("ysubject",
                            label = "select subject",
                            choices = list("mathematics" = "m", "science" = "s"),
                            selected = 1
                )
    ),
            mainPanel(
              plotlyOutput("scatterplot", width = "100%", height = "100%")
            )
    
    )
  )
)
