# Define UI for app that draws a histogram ----
library(plotly)
math <- read.csv(file="math.csv");
science <-  read.csv(file="science.csv");
mathG <- read.csv(file="math gender.csv");
scienceG <- read.csv(file="science gender.csv");
countries <- levels(math$Country)
ui <- fluidPage(
  
  # App title ----
  titlePanel("Trends in International Mathematics and Science Study"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      fluidRow(
        selectInput(inputId ="choice",
                           label = "Select field",
                           choices = c("Math", "Science"))
      ),
      sliderInput(inputId = "amount",
                  label = "Number of countries to display:",
                  min = 1,
                  max = 65,
                  value = c(15,30)),
      selectInput(inputId ="highlight",
                  label = "Highlight country",
                  choices = c("All",countries), selected = "Poland")
  
    ),
    mainPanel(
      plotlyOutput(outputId = "average"),
      plotlyOutput(outputId = "gender")
      
    )
  )
)