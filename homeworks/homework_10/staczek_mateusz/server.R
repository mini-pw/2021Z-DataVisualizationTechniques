library(ggplot2)
library(plotly)

function(input, output, session){
  fileExtension <- ".csv"
  path <- "processedData/"
  maths4bench   <- read.csv(paste(path,"1-8_benchmarks-results-M4",fileExtension,sep=""))
  maths8bench   <- read.csv(paste(path,"3-8_benchmarks-results-M8",fileExtension,sep=""))
  science4bench <- read.csv(paste(path,"2-8_benchmarks-results-S4",fileExtension,sep=""))
  science8bench <- read.csv(paste(path,"4-8_benchmarks-results-S8",fileExtension,sep=""))
  
  maths4avg   <- read.csv(paste(path,"1-1_achievement-results-M4",fileExtension,sep=""))
  maths8avg   <- read.csv(paste(path,"3-1_achievement-results-M8",fileExtension,sep=""))
  science4avg <- read.csv(paste(path,"2-1_achievement-results-S4",fileExtension,sep=""))
  science8avg <- read.csv(paste(path,"4-1_achievement-results-S8",fileExtension,sep=""))
  
  
  findRightDataset <- function(benchOrAvg) {
    entry <- paste(input$subject,input$grade,sep="_")
    if(benchOrAvg == "benchmark"){
      switch (entry,
              "Mathematics_4th" = maths4bench,
              "Mathematics_8th" = maths8bench,
              "Science_4th" = science4bench,
              "Science_8th" = science8bench
      )
    }
    else if(benchOrAvg == "average"){
      switch (entry,
              "Mathematics_4th" = maths4avg,
              "Mathematics_8th" = maths8avg,
              "Science_4th" = science4avg,
              "Science_8th" = science8avg
      )
    }
  }
  
  
  plotbench <- function(df,highlightedCountry,sortingColumn) {
    if(sortingColumn == "Low")         { dfSorted <- df %>% arrange(Low) }
    if(sortingColumn == "Intermediate"){ dfSorted <- df %>% arrange(Intermediate) }
    if(sortingColumn == "High")        { dfSorted <- df %>% arrange(High) }
    if(sortingColumn == "Advanced")    { dfSorted <- df %>% arrange(Advanced) }

    validate(
      need((any(df$Country == highlightedCountry)||(highlightedCountry == "None")),
           "Selected country is not available, please update list of countries or select None")
    )
    
    p <- ggplot(dfSorted, aes(x=factor(x=Country,levels=Country), y=0)) +
      geom_segment(aes(xend=Country, y=0, yend=Low), color="gray85")
      
    if(highlightedCountry != "None"){
      p <- p + geom_segment(aes(x=highlightedCountry, xend=highlightedCountry, y=0, yend=100),
                   size = 2, color="green4",alpha=0.01)
    }
    p + geom_point(aes(y=Advanced),    color="black", size=3, alpha=0.6) +
        geom_point(aes(y=High),        color="black", size=3, shape=1,alpha=1) +
        geom_point(aes(y=Intermediate),color="blue", size=3, alpha=0.6) +
        geom_point(aes(y=Low),         color="steelblue2", size=3, alpha=0.6) +
        theme_minimal() +
        coord_flip() +
        theme(
          panel.grid.major.y = element_blank(),
          panel.border = element_blank(),
          axis.ticks.y = element_blank(),
          axis.ticks.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          text = element_text(size=15),
          axis.text.y = element_text(margin=margin(0,-30,0,0))
        ) +
        ylab("Percentage of students") +
        xlab("Country")
  }
  
  output$benchplot <- renderPlot({
    
    rightDataset <- findRightDataset("benchmark")
    plotbench(rightDataset,input$country,input$sortingByColumn)
  })

  
  plotavg <- function(df,highlightedCountry) {
    validate(
      need((any(df$Country == highlightedCountry)||(highlightedCountry == "None")),
           "Selected country is not available, please update list of countries or select None")
    )
    
    dfSorted <- df %>%
      mutate(Country = factor(x=Country,levels=Country))
    
    colors <- rep('lightgrey',nrow(dfSorted))
    colors[dfSorted$Country==highlightedCountry] <- 'lightgreen'
    
    plot_ly(dfSorted, x = ~Country, y = ~Average, type = 'bar', 
            marker = list(color = colors)) %>% 
      layout(title = "Average score",
             xaxis = list(title = "",tickangle = 60),
             yaxis = list(title = ""),
             hoverlabel=list(bgcolor="lightgrey"),
             hovermode = 'x')
  }
  
  output$avgplot <- renderPlotly({
    rightDataset <- findRightDataset("average")
    plotavg(rightDataset,input$country)
  })
  
  

  observeEvent(input$updateCountriesList, {
    myUpdateCountriesSelection <- function(newChoices) {
      
      newSelected <- ifelse(any(input$country == newChoices),
                            input$country,
                            "None")
      updateSelectizeInput(session, "country",
                           choices = c("None",sort(newChoices)),
                           selected = newSelected,
      )
    }
    
    currentlyUsedDataSet <- findRightDataset("benchmark")
    myUpdateCountriesSelection(currentlyUsedDataSet$Country)
  })
}