library(DT)
library(plotly)

pageWithSidebar(
  headerPanel("Iris data"),
  sidebarPanel(
    checkboxInput("plot_1_colors",
                  label = "Show Species",
                  value = TRUE),
    selectInput("plot_1_x",
                label = "X:",
                choices = colnames(iris)[-5],
                selected = "Sepal.Length"),
    selectInput("plot_1_y",
                label = "Y:",
                choices = colnames(iris)[-5],
                selected = "Sepal.Width"),
    sliderInput("plot_1_sample",
                label = "Sample obs:",
                min = 1, 
                max = nrow(iris), 
                value = 90,
                animate = TRUE)
  ),
  mainPanel(
    plotlyOutput("plotly_1"),
    plotOutput("plot_1"),
    DT::dataTableOutput("table_1")
    # verbatimTextOutput("verbatim_1")
  )
)
