library(plotly)
library(ggplot2)
library(data.table)
math <- read.csv(file="math.csv");
science <-  read.csv(file="science.csv");
mathG <- read.csv(file="math gender.csv");
scienceG <- read.csv(file="science gender.csv");
countries <- levels(math$Country)
COUNTRIES = length(countries)


server <- function(input, output) {
  output$average <- renderPlotly({
      type <- input$choice
      lower <- input$amount[1]
      upper <- input$amount[2]
      highlight <- input$highlight
      if(type == "Math"){
        data = math[order(math$AVG,decreasing = TRUE),]
      }else{
        data = science[order(science$AVG,decreasing = TRUE),]
      }
      n = upper - lower
      if(highlight != "All"){
        h <- which(data$Country == highlight)
        if (lower < h  && h < upper){
          col <- c(rep(NA,h-lower),"red",rep(NA,upper-h));
        }else{
          col <- NULL
        }
      }else{
        col = NULL
      }
      data  = data[lower:upper,]
      plot <- ggplot(data = data, aes(x = reorder(Country, -AVG), y = AVG,fill=col)) + geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
      plot <- plot + labs(x="",y="Average 2019 score") + theme(legend.position = "none")
      plot <- ggplotly(plot)
      plot
  })
  
  output$gender <- renderPlotly({
    type <- input$choice
    lower <- input$amount[1]
    upper <- input$amount[2]
    n = upper - lower
    highlight <- input$highlight
    if(type == "Math"){
      data = mathG
    }else{
      data = scienceG
    }
    if(highlight != "All"){
      h <- which(data$Country == highlight)
      if (h < n){
        col <- c(rep(NA,h-1),"red",rep(NA,n - h + 1));
      }else{
        col <- NULL
      }
    }else{
      col = NULL
    }
    data  = data[lower:upper,]
    df <- melt(as.data.table(data), id.vars = "Country", variable.name = "category",
               value.name="scores")
    plot <- ggplot(data = df,aes(x=Country, y=scores,fill=category)) + geom_bar(position="dodge",stat='identity')  + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    plot <- plot +  labs(x="",y="Score by gender") + theme(legend.position = "none")
    ggplotly(plot)
    
  })
  
}