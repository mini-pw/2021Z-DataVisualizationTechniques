library(shinythemes)

ui <- fluidPage(
                theme=shinytheme("flatly"),
 

    
    titlePanel("Analysis of TIMSS 2019 data"),

    tabsetPanel(
        tabPanel("Results by country",
                 sidebarLayout(
                     sidebarPanel(
                         radioButtons("radioSubject", label ="Choose the subject to compare",
                                      choices = list("Math" = 1, "Science" = 2), 
                                      selected = 1),
                         hr(),
                         radioButtons("radioGrade", label ="Choose the grade to compare",
                                      choices = list("Grade 4" = 1, "Grade 8" = 2), 
                                      selected = 1),
                         hr(),
                         radioButtons("radioCompare", label ="Compare",
                                      choices = list("5th percentile" = 1, "Average score" = 2, "95th percentile" = 3), 
                                      selected = 2),
                         hr(),
                         uiOutput("highlight1")
                     ),
                     mainPanel(plotOutput("plot1",  height = "1400px")),
                     fluid=TRUE
                 )
                 ),
        tabPanel("Relation between confidence in given subject and average score",
                 sidebarLayout(
                     sidebarPanel(
                         radioButtons("radioSubject2", label ="Choose the subject to compare",
                                      choices = list("Math" = 1, "Science" = 2), 
                                      selected = 1),
                         hr(),
                         radioButtons("radioGrade2", label ="Choose the grade to compare",
                                      choices = list("Grade 4" = 1, "Grade 8" = 2), 
                                      selected = 1),
                         hr(),
                         uiOutput("highlight")
                     ),
                     mainPanel(plotOutput("plot2",  height = "800px", click = "plot2_click"))
                 )),
        tabPanel("About project",
                h2("About author"),
                p("This app was created by Mikołaj Spytek as part of Data Visualisation Techniques course at the Warsaw University of Technology."),
                h2("About TIMSS"),
                p("Trends in International Mathematics and Science Study is an organisation gathering data about education worldwide. They publish a report around every four years containing data from exams in different subjects. They cover more factors than just the score, such as students' confidence, technical abilities, teachers' education etc.")
    )
    )
    

    
    
)

 
    
    

