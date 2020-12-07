library(DT)

pageWithSidebar(
  headerPanel("Iris data"),
  sidebarPanel(
    checkboxInput(inputId = "plot_1_colors",
                  label = strong("Show Species"),
                  value = TRUE),
    selectInput("plot_1_x_selection", "Choose X:",
                choices = colnames(iris)[-5], 
                selected = "Sepal.Length"),
    selectInput("plot_1_y_selection", "Choose X:",
                choices = colnames(iris)[-5],
                selected = "Sepal.Width"),
    sliderInput("plot_1_sample",
                "Sample observations",
                min = 1,  max = nrow(iris), value = 100, 
                animate = TRUE)
  ),
  mainPanel(
    verbatimTextOutput("verbatim_1"),
    DT::dataTableOutput("table_1"),
    plotOutput("plot_1")
  )
)