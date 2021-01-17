library(shiny)
library("shinyWidgets")
library("ggplot2")
library("ggrepel")

# ----------- read data ---------- #
data_cale_science <- read.csv("data_cale_science.csv")
data_cale_science <- data_cale_science[, -1]
data_cale <- read.csv("data_cale.csv")
data_cale <- data_cale[, -1]

#------------ UI ------------- #

ui <- fluidPage(
  titlePanel("TIMSS 2019 grade 4 - results comparison"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create plots with the selected information."),
      
      selectInput("subject", 
                  label = h3("Choose a subject"),
                  choices = c("Mathematics", 
                              "Science"),
                  selected = "Mathematics"),
      
      radioButtons("plotType", h3("Choose plot type"),
                   choices = list("Density" = 1, "Scatter plot" = 2,
                                  "Bar plot" = 3),selected = 1),
      
      h3("Group by gender"),
      checkboxInput("Group", "True",  FALSE)
      
      
    ),
    
    mainPanel(
      plotOutput("plot")
    )
  )
)

# -------------- SERVER ------------------- #

server <- function(input, output) {
  
  output$plot <- renderPlot({
    
    data <- switch(input$subject, 
                   "Mathematics" = data_cale,
                   "Science" = data_cale_science)
    
    if(input$plotType==1 & input$Group == FALSE){
      
      ggplot(data, aes(x=Score)) +
        geom_density(alpha=0.4, fill="lavenderblush4") +
        ggtitle("Density plot of scores") +
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5, size = 14, face="bold"))
    }else if (input$plotType==1 & input$Group == TRUE){
      ggplot(data, aes(x=Average_score, fill=Gender)) +
        geom_density(alpha=0.4) +
        ggtitle("Density plot of scores by gender") +
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5, size = 14, face="bold")) +
        scale_fill_manual(values = c("skyblue2", "lightpink3"))
    } else if(input$plotType==2 & input$Group== FALSE){
      
      ggplot(unique(data[,c(1,2)]), aes(x=Country,y=Score)) +
        geom_point(color="lavenderblush4") +
        geom_label_repel(aes(label = Country),
                         box.padding   = 0.35, 
                         point.padding = 0.5,
                         segment.color = 'grey50') +
        ggtitle("Scatterplot of scores") +
        theme_bw() +
        theme(axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank()) +
        theme(plot.title = element_text(hjust = 0.5, size = 14, face="bold"))
      
    } else if(input$plotType==2 & input$Group== TRUE){
      
      ggplot(data, aes(x=Country,y=Average_score)) +
        geom_point(aes(color=Gender)) +
        ggtitle("Scatterplot of scores by gender") +
        theme_bw() +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
        theme(plot.title = element_text(hjust = 0.5, size = 14, face="bold")) +
        scale_color_manual(values = c("skyblue2", "lightpink3"))
    } else if(input$plotType==3 & input$Group== FALSE){
      
      ggplot(unique(data[,c(1,2)]), aes(x=Country,y=Score)) +
        geom_bar(stat="identity", color="lavenderblush4") +
        ggtitle("Barplot of scores") +
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5, size = 14, face="bold")) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    } else if(input$plotType==3 & input$Group== TRUE){
      
      ggplot(data, aes(x=Country,y=Average_score, fill=Gender)) +
        geom_bar(stat="identity", position=position_dodge()) +
        ggtitle("Barplot of scores") +
        theme_bw() +
        scale_fill_manual(values = c("skyblue2", "lightpink3")) +
        theme(plot.title = element_text(hjust = 0.5, size = 14, face="bold")) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    }
    
    
  })
  
}
# ----------------------- RUN THE APP ----------------------- #

shinyApp(ui = ui, server = server)

