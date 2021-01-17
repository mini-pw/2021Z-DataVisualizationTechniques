library(shiny)

shinyUI(fluidPage(
    titlePanel("TIMSS data"),
    sidebarLayout(
        sidebarPanel(
            conditionalPanel(
                condition = "input.grade == 4",
                sliderInput("top4",
                            "Show how many:",
                            min = 1,
                            max = 64,
                            value = c(0, 10)
                )
            ),
            conditionalPanel(
                condition = "(input.top4[1] - input.top4[0] > 20) && (input.grade == 4)",
                h5("For best results, pick ranges smaller than 20"),
            ),
            conditionalPanel(
                condition = "input.grade == 8",
                sliderInput("top8",
                            "Show how many:",
                            min = 1,
                            max = 46,
                            value = c(0, 10)
                ),
            ),
            conditionalPanel(
                condition = "(input.top8[1] - input.top8[0] > 20) && (input.grade == 8)",
                h5("For best results, pick ranges smaller than 20"),
            ),
            radioButtons(
                "grade", 
                choiceValues = c(4, 8),
                choiceNames = c("4th grade", "8th grade"),
                selected = 4,
                inline = T,
                label = "Choose grade"
            ),
            radioButtons(
                "type", 
                choices = c("Math", "Science"),
                selected = "Math",
                inline = T,
                label = "Choose type"
            ),
            sliderInput(
                "bins",
                "Number of bins:",
                min = 1,
                max = 50,
                value = 30
            )
        ),
        mainPanel(
            plotOutput("rankingPlot"),
            plotOutput("distPlot")
        )
    )
))
