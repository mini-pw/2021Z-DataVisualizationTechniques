library(DT)
library(plotly)
pageWithSidebar(
  headerPanel("Iris data"),
  sidebarPanel(
    checkboxInput("plot_1_colors", 
                  label = "Show Species",
                  value = TRUE),
    selectInput("plot_1_x_selection",
                label = "X:",
                choices = colnames(iris)[-5],
                selected = "Sepal.Length"),
    selectInput("plot_1_y_selection",
                label = "Y:",
                choices = colnames(iris)[-5],
                selected = "Sepal.Width"),
    sliderInput("plot_1_sample",
                label = "Sample observations",
                min = 1, max = nrow(iris), value = 100,
                animate = TRUE)
  ),
  mainPanel(
    plotlyOutput("plotly_1"),
    plotOutput("plot_1"),
    DT::dataTableOutput("table_1")
    # verbatimTextOutput("text_1")
  )
)