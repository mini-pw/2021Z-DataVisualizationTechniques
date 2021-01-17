library(DT)
library(plotly)
fluidPage(
  headerPanel("TIMSS 1995-2019"),
  sidebarPanel(
    selectInput("country",
                label = "Country",
                choices = c("All","Poland"),
                selected = "Poland"),
    selectInput("age",
                label = "Grade",
                choices = c(4,8),
                selected = 3),
    selectInput("category",
                label = "Category",
                choices = c("Math","Science"),
                selected = "Math"),
  ),
  mainPanel(
    plotlyOutput("plotly_1"),
    plotlyOutput("plotly_2"),
    "data source:",a("https://timssandpirls.bc.edu/timss2019/")
  )
  
)