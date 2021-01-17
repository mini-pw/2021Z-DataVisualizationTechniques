#library(jsonlite)
library(dplyr)
#library(packcircles)
library(ggplot2)
#library(plotly)
library(shiny)
library(RColorBrewer)


SmolenAnim <- read.csv("SmolenAnim.csv")
SmolenRange <- read.csv("SmolenRange.csv")
SinskiAnim <- read.csv("SinskiAnim.csv")
SinskiRange <- read.csv("SinskiRange.csv")
SinskiAnim$date<-as.Date(SinskiAnim$date)
SinskiRange$endTime<-as.Date(SinskiRange$endTime)
SmolenRange$endTime<-as.Date(SmolenRange$endTime)
SmolenAnim$date<-as.Date(SmolenAnim$date)
SmolenColor <- read.csv("SmolenColor.csv")
SinskiColor <- read.csv("SinskiColor.csv")
SzmejRange <- read.csv("SzmejRange.csv")
SzmejAnim <- read.csv("SzmejAnim.csv")
SzmejColor <- read.csv("SzmejColor.csv")
ui <- fluidPage(
  

  titlePanel("Sliders"),
  
  
  sidebarPanel(
   selectInput("person", "Choose person:",
                         c("Siński" = "Sinski",
                           "Smoleń" = "Smolen",
                           "Szmaja" = "Szmej"), selectize = FALSE)
  ),
  
 
  mainPanel(fluidRow( column( 10,
    sliderInput("date",
                min = as.Date("2020-01-01"), max = as.Date("2020-11-30"),
                label = "Top artists since 01 Jan 2020",
                value = as.Date("2020-11-30"), step = 2,
                width="80%",
                animate =
                animationOptions(interval = 500, loop = FALSE)))),     #no nie bardzo płynne niestety
  fluidRow(column(10,
                  plotOutput("p"))),


fluidRow( column( 10,
                  sliderInput("range",
                              min = as.Date("2020-01-01"), max = as.Date("2020-11-30"),
                              label = "Top artists in given time period",
                              value = c(as.Date("2020-01-01"), as.Date("2020-06-30")), step=1,
                              width="80%"))),
fluidRow(column(10,
                plotOutput("q")))))



      



server <- function(input, output, session){
      
      #dataAnim <- reactive({
       # read.csv(paste(input$person, "Anim.csv", sep="")
        
      #})
      
  
      output$p <- renderPlot({
      z <- get(paste(input$person, "Anim", sep=""))
      a<-(z %>% filter(date==input$date))   # tu z
      ggplot(a, aes(x=-pos, y=no, fill=color  ))+geom_bar(stat="identity")+
      geom_text(aes(x=-pos, y=no*1.1, label=artistName))+
      coord_flip()+theme_bw()
  })
      output$q <- renderPlot({
        b <- get(paste(input$person, "Range", sep=""))
        aa <- b %>% filter(endTime>=input$range[1] & as.Date(endTime) <=input$range[2])   # tu b
        aa <- aa %>% count(artistName) %>% arrange(n) %>% top_n(10)
        aa <- left_join(aa, get(paste(input$person, "Color", sep="")))
        ggplot(aa, aes(x=reorder(artistName, n), y=n, fill=color))+geom_bar(stat="identity")+
          geom_text(aes(x=artistName, y=n*1.05, label=artistName))+
          coord_flip()+theme_bw()
        
      })
  }








shinyApp(ui = ui, server = server)




