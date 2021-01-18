library(DT)
library(plotly)
library(shinythemes)

fluidPage(theme = shinytheme("darkly"), style="padding: 0;",
  navbarPage("TIMSS 2019", id="tabs",
             tabPanel("4th graders"),
             tabPanel("8th graders")
  ),
  fluidRow(class="well", style="margin: -10px 15px 7px; padding: 4px 7px;", 
      column(6, selectInput("country_primary",
                            label = "Selected country:",
                            choices = c("Please wait, loading may take a while..."),
                            selected = "Please wait, loading may take a while..."),
             textOutput("error_primary") %>% tagAppendAttributes(class="text-danger", style="margin-top: -18px; margin-bottom: -2px;"),
             tags$style("#country_primary ~ div .items {background-color: #b6e3ac;}")),
      
      column(6, selectInput("country_secondary",
                            label = "Comparing with:",
                            choices = c("Please wait, loading may take a while..."),
                            selected = "Please wait, loading may take a while..."),
             textOutput("error_secondary") %>% tagAppendAttributes(class="text-danger", style="margin-top: -18px; margin-bottom: -2px;"),
             tags$style("#country_secondary ~ div .items {background-color: #f0e0b6;}"))
  ),
  fluidRow(style="margin-left: 15px; margin-right: 15px;", 
     column(4, fluidRow(class="well", id="item_image", style="padding: 0; overflow: hidden; background: WHITE; height:800px; margin-bottom: 0;",
        h4("Hover over an item to display it", id="item_name", style="margin-top: 6px; text-align: center; color: #141414; margin-bottom: 4px;"),
        div(id="item_desc", style="color: #141414; margin-bottom: 6px; white-space: pre-wrap;"),
      )),
     column(8, 
        fluidRow(
            column(6, plotlyOutput("compare_maths")),
            column(6, plotlyOutput("all_maths"))
        ),
        fluidRow(
          column(6, plotlyOutput("compare_science")),
          column(6, plotlyOutput("all_science"))
        )
  ))
)

