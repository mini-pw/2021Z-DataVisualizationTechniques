navbarPage("TIMSS 2019", theme = my_theme,
  tabPanel("What is TIMMS?",
    fluidPage(
      fluidRow(
        column(6, offset = 3, align = "center",
               h1("What is TIMSS?"),
               hr(),
               p("TIMSS (",em("Trends in International Mathematics and Science Study"),") is international cyclic
               survey that provides data about math and science abilities of 4-grade and 8-grade students across the world.
               Students came from diverse enviroments (economic and education system development, population size, support at home).
               There are about 4,000 - 5,000 recorded participats for each country that took part in this study.",
                 style="text-align: justify;"),
               h2("Scoring"),
               p("For each category studends faced with various questions. For example 4-grade math consists of three areas
               - prealgebra (50%); measurement and geometry (30%); and data (20%). At each scoring category, cetner of scale (500) is located at the mean of the overall achivement distribution.
                 100 score points ware set to correspond to standard deviation.",
                 style="text-align: justify;"),
               br(),
               p("More info at ", a("TIMSS site", href="https://timssandpirls.bc.edu/timss2019/")," and ",
                 a("Wikipedia.", href="https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study"),
                 style="text-align: justify;")
               
        )
      )
    )
  ),
  tabPanel("General scores",
           sidebarLayout(
             sidebarPanel(
               p("General scores", style = "font-size:35px;"),
               radioGroupButtons(inputId = "category_input",
                                 label = "Select test category:", 
                                 choices = c("Maths 4-grade", "Maths 8-grade",
                                             "Science 4-grade", "Science 8-grade"),
                                 status = "primary"),
               selectInput("country_input", label = "Select country:", choices = NULL),
               hr(),
               em("Country picked above:"),
               h4(textOutput("picked_country_name")),
               textOutput("picked_country_score"),
               hr(),
               em("Click on barplot to compare:"),
               h4(textOutput("clicked_country_name")),
               textOutput("clicked_country_score")
             ),
             mainPanel(
                 plotOutput("country_bars", click = "barplot_click_pos"),
                 hr(),
                 div(class = "ui divider"),
                 plotOutput("country_lines")
               )
             )
           
  ),
  tabPanel("Score distributions",
    sidebarLayout(
      sidebarPanel(
        p("Score distributions", style = "font-size:35px;"),
        radioGroupButtons(inputId = "category_input_dists",
                          label = "Select test category:", 
                          choices = c("Maths 4-grade", "Maths 8-grade",
                                      "Science 4-grade", "Science 8-grade"),
                          status = "primary")
      ),
      mainPanel(
        plotlyOutput("distributions_plot")
      )
    )
  )
)