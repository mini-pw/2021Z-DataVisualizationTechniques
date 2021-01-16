library(DT)
library(ggplot2)
library(plotly)
library(forcats)
library(stringr)
library(tidyr)
library(dplyr)

function(input, output, session){
  
  choose_frame <- function(){
  if (input$class == "IV") {
    cl = "IV"
     if (input$subject == "Mathematics") {
       df <- M_4
     } else {
       df <- S_4 
     }
   } else {
     cl = "VIII"
     if (input$subject == "Mathematics") {
       df <- M_8 
     } else {
       df <- S_8
     }
   }
    return (df)
  }
  
  create_plot <- function(df) {
    
    n = input$no
    if (n < 5) {
      n = 5
    } else if (n > nrow(df)){
      n = nrow(df)}
    
    if (input$data_type == 1) {
      df <- df %>%
        select(1, 4) %>%
        setNames(., c("Country", "Score"))
    } else if (input$data_type == 2) {
      df <- df %>%
        select(1,3) %>%
        setNames(., c("Country", "Score"))}
    
    df["Score"] <- as.numeric(unlist(df["Score"])) # niektore kolumny byly zapisane jako 'char'
    lim = max(df['Score'])
    
    if (input$sort_type == "Ascending") {
      df <- arrange(df, Score) %>%
        head(n)
      p <- ggplot(df, aes(x = reorder(Country, Score), y = Score)) + 
        geom_col(fill = "skyblue1", color = "black", width = 0.7) 
      } else {
      df <- arrange(df, desc(Score)) %>%
        head(n)
      p <- ggplot(df, aes(x = reorder(Country, -Score), y = Score)) + 
        geom_col(fill = "skyblue1", color = "black", width = 0.7) 
    }
    p <- p +
      scale_y_continuous("Score", expand = c(0, 0), limits = c(0, max(df$Score) * 1.05)) +
      scale_fill_manual(values=c("#56b4e9", "#e69f00")) +
      labs(
        x = "Country",
        y = "Score",
        title = "Average TIMSS score for given countries") + 
      theme(axis.text.x = element_text(face="bold", color="black", 
                                       size=16, angle=60),
            axis.text.y = element_text(face="plain", color="black", 
                                       size=16),
            axis.line = element_line(colour = "black", 
                                     size = 1, linetype = "solid"),
            axis.title=element_text(size=16,face="plain"),
            title =element_text(size=18, face='plain'),
            panel.background = element_rect(fill = "white", colour = "white"),
            panel.grid.major.y = element_line(colour = "grey80", size = 0.5))

  
    ggplotly(p, tooltip = c("Country", "Score"))
  }
  
  create_plot1 <- function() {
    if (input$class == "IV") {
      cl = "IV"
      if (input$subject == "Mathematics") {
        df <- M4L
      } else {
        df <- S4L
      }
    } else {
      cl = "VIII"
      if (input$subject == "Mathematics") {
        df <- M8L 
      } else {
        df <- S8L
      }
    }
    
    df <- df %>%
      filter(Country == input$choose_country)
      
    x <- colnames(df)
    y <- as.numeric(unclass(unlist(df[1, -1])))
    x <- x[-1] 
    
    df1 <- data.frame(
      Likeness = x,
      Percentage = y
    )
    rownames(df1) <- NULL

    
    if (!(is.element(input$choose_country, unlist(df$Country)))) {
      p <- ggplot(df1, aes(x = Likeness, y = Percentage)) + 
        annotate("text", x = 2, y = 50, label = "No data available for", size = 10) +
        annotate("text", x = 2, y = 40, label = "chosen country and categories :(", size = 10) +
        scale_y_continuous(expand = c(0, 0), limits = c(0, 100)) +
        theme(
          axis.title = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank(),
          panel.background = element_blank(),
          panel.grid = element_blank()
        )
    } else {
      p <- ggplot(df1, aes(x = Likeness, y = Percentage)) + 
        geom_col(fill = "skyblue1", color = "black") +
        scale_y_continuous(expand = c(0, 0), limits = c(0, 105)) +
        scale_fill_manual(values=c("#56b4e9", "#e69f00")) +
        scale_x_discrete(name = "", 
                         limits=c("Like Very Much", "Somewhat Like", "Do Not Like")) + 
        labs(
          x = "",
          y = "",
          title = "Percentage of students liking chosen subject") + 
        theme(axis.text.x = element_text(face="plain", color="black", 
                                         size=16),
              axis.text.y = element_text(face="plain", color="black", 
                                         size=16),
              axis.line = element_line(colour = "black", 
                                       size = 1, linetype = "solid"),
              axis.title=element_text(size=16,face="plain"),
              title =element_text(size=18, face='plain'),
              panel.background = element_rect(fill = "white", colour = "white"),
              panel.grid.major.y = element_line(colour = "grey80", size = 0.5)) 
    }
    
    p <- ggplotly(p, tooltip = c("Likeness", "Percentage"))
    
    
    
    return(p)
  }
  
  
  button_reactive <- eventReactive( input$confirm, {create_plot(choose_frame())})
  button_reactive1 <- eventReactive( input$confirm, {create_plot1()})
  
  output$plot <- renderPlotly(
    {button_reactive()})
  
  output$plot1 <- renderPlotly(
    {button_reactive1()})
  
}

