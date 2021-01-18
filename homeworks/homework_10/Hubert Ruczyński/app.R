library(ggplot2)
library(plotly)
library(shiny)
library(hrbrthemes)
######################################################################################################## 
ui <- fluidPage(
  
  titlePanel("Insight in TIMSS 2019"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(inputId = "subject",label =  "Choose subject:",
                  choices = c("Mathematics", "Science")),
      
      selectInput(inputId = "grade",label =  "Choose students grade:",
                  choices = c("4th", "8th")),
      
      
      helpText("Choose country to browse through its data. 'Default' option doesn't specify any country."),
      
      selectizeInput(inputId = "country",
                     label="Choose country",
                     choices = c("Default"),
                     selected = "Default",
                     options = list(maxItems = 1,
                                    maxOptions = 200)),
      actionButton("updateData", "Update Data"),
      
      helpText("Depending on grade and subject, some coutries on the list might be unavailable in current dataset.
               In achievements analysis, please remember to select other country than default."),
      
    ),
    
    #Main Panel
    mainPanel(
      tabsetPanel(
        tabPanel("Time spent on subjects in 2019", 
                 h3("Amount of time in hours at school dedicated for chosen subject"),
                 
                 plotlyOutput(outputId = "timeplot",height = 800)
        ),
        
        tabPanel("Analysis of achievements for countries", 
                 h3("Distribution of scores in selected coutry for 2019 showed in comparison with previous years"),
                 
                 plotlyOutput(outputId = "boxplot",height = 800)
        ),
        tabPanel("About TIMSS", 
                 h3("What are TIMSS?"),
                 p("The IEA's Trends in International Mathematics and Science Study (TIMSS) is a series of
                   international assessments of the mathematics and science knowledge of students around the world. 
                   The participating students come from a diverse set of educational systems (countries or regional 
                   jurisdictions of countries) in terms of economic development, geographical location, and population size. 
                   In each of the participating educational systems, a minimum of 4,500 to 5,000 students is evaluated. 
                   Contextual data about the conditions in which participating students learn mathematics and science are 
                   collected from the students and their teachers, their principals, and their parents via questionnaires."),
                 
                 h5("Official and full analysis of data: "),
                 a("https://www.iea.nl/sites/default/files/2020-12/TIMSS-2019-International-Results-in-Mathematics-and-Science_0.pdf"),
                 h5("Data source: "),
                 a("https://timss2019.org/reports/download-center/"),
        ),
        tabPanel("About Author", 
                 h3("Hubert Ruczynski"),
                 p("Student of Faculty of Mathematics and Information Science in Warsaw University of Technology."),
                 p("Field of study: data engineering and analysis"),
                 p("Graduate from top polish highschool Gimnazjum i Liceum Akademickie, Torun in 2019."),
                 p("Contact e-mail: hruczynski21@interia.pl"),
                 p("GitHub: "),
                 a("https://github.com/HubertR21")
        )
        
      )
    )
  )
)

######################################################################################################## 
Server<- function(input, output, session){
  fileExtension <- ".csv"
  path <- "finalData/"
  timeMath4    <- read.csv(paste(path,"12-2_instruction-time-M4",fileExtension,sep=""))
  timeMath8    <- read.csv(paste(path,"12-3_instruction-time-M8",fileExtension,sep=""))
  timeScience4 <- read.csv(paste(path,"13-2_instruction-time-S4",fileExtension,sep=""))
  timeScience8 <- read.csv(paste(path,"13-3_instruction-time-S8",fileExtension,sep=""))
  
  AchivementMath4   <- read.csv(paste(path,"1-4_achievement-trends-M4Sheet2",fileExtension,sep=""))
  AchivementMath8   <- read.csv(paste(path,"2-4_achievement-trends-S4Sheet2",fileExtension,sep=""))
  AchivementScience4 <- read.csv(paste(path,"3-4_achievement-trends-M8Sheet2",fileExtension,sep=""))
  AchivementScience8 <- read.csv(paste(path,"4-4_achievement-trends-S8Sheet2",fileExtension,sep=""))
  
  
  findRightDataset <- function(timeOrAvg) {
    entry <- paste(input$subject,input$grade,sep="_")
    print(entry)
    if(timeOrAvg == "time"){
      switch (entry,
              "Mathematics_4th" = timeMath4,
              "Mathematics_8th" = timeMath8,
              "Science_4th" = timeScience4,
              "Science_8th" = timeScience8
      )
    }
    else if(timeOrAvg == "achievement"){
      switch (entry,
              "Mathematics_4th" = AchivementMath4,
              "Mathematics_8th" = AchivementMath8,
              "Science_4th" = AchivementScience4,
              "Science_8th" = AchivementScience8
      )
    }
  }
  
  ######################################################################################################## 
  plotTime <- function(df, selectedCountry) {
    validate(
      need((any(df$Country == selectedCountry)||(selectedCountry == "Default")),
           "Selected country is not available, please select another one")
    )
    if(colnames(df)[4]=="MathsHours"){
      color="lightblue"
      colname<-"MathsHours"
    }else{
      color="lightgreen"
      colname<-"ScienceHours"
    }
    df<-df[order(df[,4]),]
    df<-df%>%
      mutate(Country = factor(x=Country,levels=Country))
    
      
    if(colnames(df)[4]=="MathsHours"){
      plot <- ggplot(df) +
        geom_bar(aes(x=Country, y=TotalHours), stat="identity", fill="grey", alpha=0.3)+
        geom_bar(aes(x=Country, y=MathsHours), stat="identity", fill=color)+
        coord_flip() +
        theme_bw() +
        xlab(" ")
                    
    }else{
      plot <- ggplot(df) +
        geom_bar(aes(x=Country, y=TotalHours), stat="identity", fill="grey", alpha=0.3)+
        geom_bar(aes(x=Country, y=ScienceHours), stat="identity", fill=color)+
        coord_flip() +
        theme_bw() +
        xlab(" ")
    }
    
    if(selectedCountry != "Default"){
      y_max=max(df[,3])
      print(y_max)
      plot <- plot + 
        geom_bar(aes(x=selectedCountry,y=y_max/nrow(df)), stat="identity", fill="red",alpha=0.1)
    }
    fig<-ggplotly(plot)
    fig
  }
  
  
  
  output$timeplot <- renderPlotly({
    rightDataset <- findRightDataset("time")
    plotTime(rightDataset,input$country)
  })
  
  ######################################################################################################## 
  plotAchievement <- function(df, selectedCountry) {
    validate(
      need((any(df$Country == selectedCountry)),
           "Please select another country, because we have no data about this one")
    )
    
    if(input$subject=="Mathematics"){
      color="blue"
    }else{
      color="darkgreen"
    }
    
    data<-df[df$Country==selectedCountry, ]
    fig<-plot_ly(y=data$Year, 
                 type = "box", lowerfence=data$X5P, q1=data$X25P, median=data$AVG.50P, q3=data$X75P, upperfence=data$X95P, 
                 color = I(color)
    )
    x<-list(title="Score", range=c(0,850))
    y<-list(title="Year")
    fig<-fig%>% layout(xaxis = x, yaxis = y) 
    fig
  }
  ?layout
  
  output$boxplot <- renderPlotly({
    rightDataset <- findRightDataset("achievement")
    plotAchievement(rightDataset,input$country)
  })
  ######################################################################################################## 
  
  
  observeEvent(input$updateData, {
    myUpdateCountriesSelection <- function(newChoices) {
      newSelected <- ifelse(any(input$country == newChoices),
                            input$country,
                            "Default")
      updateSelectizeInput(session, "country",
                           choices = c("Default",sort(newChoices)),
                           selected = newSelected,
      )
    }
    currentlyUsedDataSet <- findRightDataset("time")
    currentlyUsedDataSet2 <- findRightDataset("achievement")
    
    ops1<-currentlyUsedDataSet$Country
    ops2<-currentlyUsedDataSet$Country
    ops<-c(ops1,ops2)
    ops<-unique(ops)
    
    myUpdateCountriesSelection(ops)
  })
  
}

shinyApp(ui=ui,server=Server)

