library(DT)
library(plotly)
library(ggplot2)
library(rsconnect)
library(shiny)
library(plotly)


ui <- fluidPage(
 
  titlePanel("Bullying rate at school around the world"),
  
  sidebarLayout(
    
    sidebarPanel(
                  uiOutput("link1"),
                  uiOutput("link2"),
                  img(src='stop_bullying.png', align = "center"),
                  h5("School bullying is a type of bullying that occurs in any educational 
        setting and can happen on any educational level. Victims of school bullying 
        are primarily targeted for their sexual orientation, stereotype, race, 
        learning disabilities, and sexual behavior among others."),
                  
                  h5("It doesn't matter if you are a student, educator, 
        parent of a child or adolescent, or a community member. 
        Everyone has a role in the prevention of school bullying, and most people have 
        directly or indirectly participated in, witnessed, or experienced some form of 
        bullying in schools."),
                  
                  h5("Here are some interesting articules about bullying at school:"),
                  
                  actionButton(inputId ="bullyingButton1", label = "Link no. 1" ,onclick = "window.open('https://en.wikipedia.org/wiki/School_bullying', '_blank')"),
                  actionButton(inputId = "bullyingButton2", label = "Link no. 2" , onclick = "window.open('https://www.uopeople.edu/blog/definition-of-bullying/', 
                               '_blank')"), 
    
                  h2("Countries with lowest bullying rates:"),
                  splitLayout(
                      verticalLayout(
                      h4("4th grade"),
                      tableOutput("table1")
                      )
                    ,
                    verticalLayout(
                      h4("8th grade"),
                      tableOutput("table2")
                    )
                  )
          ),
    
    mainPanel(
      navbarPage(
        title = "Choose grade:",
        tabPanel(title = "4th grade", 
                 h3("Plot shows bullying rate among countries around the world"),
                 helpText("You can use diffrent options of sorting data, including sorting by diffrent types of frequency"),
                 radioButtons(inputId = "radio4th",label =  "Select frequency to be sorted by",
                              choices = c("Never or almost Never", "About Monthly", "About Weekly")),
                 
                 plotlyOutput(outputId = "grade_4th_plot",height = 700),
                 
        ),
        tabPanel("8th grade", 
                 h3("Plot shows bullying rate among countries around the world"),
                 helpText("You can use diffrent options of sorting data, including sorting by diffrent types of frequency"),
                 radioButtons(inputId = "radio8th",label =  "Select frequency to be sorted by",
                              choices = c("Never or almost Never", "About Monthly", "About Weekly")),
                 
                 plotlyOutput(outputId = "grade_8th_plot",height = 700))        )       )
    
    )
)
     