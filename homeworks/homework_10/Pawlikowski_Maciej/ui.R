library(DT)
library(shiny)
library(plotly)

fluidPage(
  titlePanel("Singapore"),
  
  
  sidebarLayout(
  sidebarPanel(
    sliderInput("plot_1_sample",
                label="Forgot where the Singapore is? Press triangle bellow.",
                min=0, max=2, value=0, animate=TRUE),
    checkboxInput(inputId="check1", label="Not enough data? Show boxplot on plot 1", value = FALSE, width = NULL),
    selectInput(
      inputId = "input_1",
      label = "Select plot 2 data",
      choices = c(
        "Math" = "M",
        "Science" = "S",
        "Math+Science" = "MS"
      )
    )
  ),
  mainPanel(
    plotlyOutput("plotly_2"),
    h6("PLOT I", align = "center"),
    h6("A NEW RESULTS", align = "center"),
    h5("It is an era of mathematics.", align = "center"),
    h4("Genius mathematicians, striking", align = "center"),
    h3("from a hidden country, have won", align = "center"),
    h2("yet another victory against the", align = "center"),
    h1("might of strict minds."),
    h6("TIMSS puts its scale centerpoint at 500 and ranked Singapore around 20% higher than that value. ", align = "left"),h6("(In order to see more information on Singapore results click on square in sidebar next to 'Not enough data? Show boxplot on plot ')", align = "left"),
    plotlyOutput("plotly_3"),
    
    h5("During the years", align = "center"),
    h4("singaporeans have managed ", align = "center"),
    h3("to uncover secret plans to ", align = "center"),
    h2("the ultimate way of teaching-", align = "center"),
    h1("more demanding math courses.",allign="center"),
    h6("    Singapore achieves its results by engaging students with diverse interests and learning
needs. For example, secondary school students with the aptitude and interest may opt to take more
demanding mathematics and science courses. But the question is work? Did student that now are in 8th grade scored better 4 years ago or worse? Plot underneth shows percentage growth of that change for all vintages tested by Timms.",allign="center"),h6("(You can change between math, science and both of them on left sidebar on the top of page)", align = "left"),
    plotlyOutput("plotly_4")
  ),
  position = c("left", "right"),
  fluid = TRUE
  )
)









