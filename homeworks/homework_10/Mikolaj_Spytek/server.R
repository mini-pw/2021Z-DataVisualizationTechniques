library(shiny)
library("readxl")
library(dplyr)
library(ggplot2)


M4 <- read_xlsx("1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5, 9, 14) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  rename("Fifth" = "Mathematics Achievement Distribution")%>%
  rename("Ninetyfifth" = "...14")%>%
  na.omit()

# Dla 8 klasy bedzie:
# 3-1_achievement-results-M8.xlsx

M8 <- read_xlsx("3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5, 9, 14) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  rename("Fifth" = "Mathematics Achievement Distribution")%>%
  rename("Ninetyfifth" = "...14")%>%
  na.omit()

# Przyroda dla 4 klasy
S4 <- read_xlsx("2-1_achievement-results-S4.xlsx", skip = 5) %>%
  select(3, 5, 9, 14) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  rename("Fifth" = "Science Achievement Distribution")%>%
  rename("Ninetyfifth" = "...14")%>%
  na.omit()

# Dla 8 klasy bedzie:
# 4-1_achievement-results-S8.xls

S8 <- read_xlsx("4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5, 9, 14) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  rename("Fifth" = "Science Achievement Distribution")%>%
  rename("Ninetyfifth" = "...14")%>%
  na.omit()

MC4 <- read_xlsx("11-8_students-confident-M4.xlsx", skip=5) %>%
  select(3, 6, 9, 12, 15, 18, 21)%>%
  rename("Country" = "...3") %>%
  rename("ConfidentPercent" = "Percent of Students...6") %>%
  rename("SomewhatConfidentPercent" = "Percent of Students...12") %>%
  rename("NotConfidentPercent" = "Percent of Students...18") %>%
  rename("ConfidentScore" = "Average Achievement...9") %>%
  rename("SomewhatConfidentScore" = "Average Achievement...15") %>%
  rename("NotConfidentScore" = "Average Achievement...21") %>%
  na.omit()

MC8 <- read_xlsx("11-9_students-confident-M8.xlsx", skip=5) %>%
  select(3, 6, 9, 12, 15, 18, 21)%>%
  rename("Country" = "...3") %>%
  rename("ConfidentPercent" = "Percent of Students...6") %>%
  rename("SomewhatConfidentPercent" = "Percent of Students...12") %>%
  rename("NotConfidentPercent" = "Percent of Students...18") %>%
  rename("ConfidentScore" = "Average Achievement...9") %>%
  rename("SomewhatConfidentScore" = "Average Achievement...15") %>%
  rename("NotConfidentScore" = "Average Achievement...21") %>%
  na.omit()

SC4 <- read_xlsx("11-11_students-confident-S4.xlsx", skip=5) %>%
  select(3, 6, 9, 12, 15, 18, 21)%>%
  rename("Country" = "...3") %>%
  rename("ConfidentPercent" = "Percent of Students...6") %>%
  rename("SomewhatConfidentPercent" = "Percent of Students...12") %>%
  rename("NotConfidentPercent" = "Percent of Students...18") %>%
  rename("ConfidentScore" = "Average Achievement...9") %>%
  rename("SomewhatConfidentScore" = "Average Achievement...15") %>%
  rename("NotConfidentScore" = "Average Achievement...21") %>%
  na.omit()

SC8 <- read_xlsx("11-12_students-confident-S8.xlsx", skip=10, n_max=65) %>%
  select(3, 6, 9, 12, 15, 18, 21)%>%
  rename("Country" = "...3") %>%
  rename("ConfidentPercent" = "Percent of Students...6") %>%
  rename("SomewhatConfidentPercent" = "Percent of Students...12") %>%
  rename("NotConfidentPercent" = "Percent of Students...18") %>%
  rename("ConfidentScore" = "Average Achievement...9") %>%
  rename("SomewhatConfidentScore" = "Average Achievement...15") %>%
  rename("NotConfidentScore" = "Average Achievement...21") %>%
  na.omit()


server <- function(input, output) {
  
  
  output$highlight1 <- renderUI({
    if (input$radioSubject == 1){
      if(input$radioGrade==1){
        df <- M4
      }
      else{
        df <- M8
      }
    }
    else{
      if(input$radioGrade==1){
        df <- S4
      }
      else{
        df <- S8
      }
    }
    
    df[, c(3,4)] <- sapply(df[, c(3,4)], as.numeric)
    
    selectInput("highlightedCountry11", "Highlight a country", choices=sort(df$Country))
    
    
  })
  
  output$plot1 <-renderPlot({
    if (input$radioSubject == 1){
      if(input$radioGrade==1){
        df <- M4
      }
      else{
        df <- M8
      }
    }
    else{
      if(input$radioGrade==1){
        df <- S4
      }
      else{
        df <- S8
      }
    }
    
    df[, c(3,4)] <- sapply(df[, c(3,4)], as.numeric)
    

    df["highlighted"] <- ifelse(df["Country"] == input$highlightedCountry11[[1]], TRUE, FALSE)
    
    if(input$radioCompare==2){
      p <- ggplot(df, aes(y=reorder(Country, Score), x=Score, fill=highlighted)) + geom_bar(stat="identity") + geom_text(aes(label=Score), hjust=-0.2) + ggtitle("Average score in countries") + xlab("Score (out of 1000)") + ylab("Country")
    }
    else if (input$radioCompare==1){
      p <- ggplot(df, aes(x=Fifth, y=reorder(Country, Fifth), fill=highlighted)) + geom_bar(stat="identity")+ geom_text(aes(label=Fifth), hjust=-0.2) + ggtitle("Fifth-percentile score in countries") + xlab("Score (out of 1000)") + ylab("Country")
    }
    else{
      p <- ggplot(df, aes(x=Ninetyfifth, y=reorder(Country, Ninetyfifth), fill=highlighted)) + geom_bar(stat="identity")+ geom_text(aes(label=Ninetyfifth), hjust=-0.2) + ggtitle("Ninety-fifth-percentile score in countries") + xlab("Score (out of 1000)") + ylab("Country")

    }
    
    # p <- p + geom_bar(data=subset(df, ), fill="#ff0000")
    
    p + theme_bw() + scale_x_continuous(expand = expansion(mult = c(0, .01)), limits =c(0,1000), position="top") + theme(legend.position = "none")
    
    
    
  })
    
  
  df2 <- reactive({
    if (input$radioSubject2 == 1){
      if(input$radioGrade2==1){
        df2 <- MC4
      }
      else{
        df2 <- MC8
      }
    }
    else{
      if(input$radioGrade2==1){
        df2 <- SC4
      }
      else{
        df2 <- SC8
      }
    }
    df2[, c(2,3,4,5,6,7)] <- sapply(df2[, c(2,3,4,5,6,7)], as.numeric)
    
    df2 <- df2 %>% mutate(aveg = (ConfidentPercent*ConfidentScore+SomewhatConfidentPercent*SomewhatConfidentScore+NotConfidentPercent*NotConfidentScore)/100)
    df2
  })
  
  
  rv <- reactiveValues(
    clicked = NULL,
    clicked_id = c()
  )
  

  
  observeEvent(input$plot2_click, {
    rv[["clicked"]] <- nearPoints(df2(),
                                  coordinfo = input[["plot2_click"]],
                                  allRows = TRUE,
                                  maxpoints = 1,
                                  threshold = 20
    )
    rv[["clicked_id"]] <- which(rv[["clicked"]][["selected_"]])
  })
  
  
  plot_df <- reactive({
    plot_df <- df2()
    plot_df[["selected_"]] <- FALSE
    plot_df[rv[["clicked_id"]], "selected_"] <- TRUE
    plot_df
  })

    output$plot2 <- renderPlot({



      plot <- ggplot(plot_df(), aes(x=ConfidentPercent, y=aveg)) + geom_point(size=3)

      
      selpoints <-  subset(plot_df(), selected_==TRUE)
      
      plot <- plot + geom_point(data = selpoints, color="#ff0000", size=4) + geom_label(data =selpoints, aes(label=Country),hjust = 0, nudge_x = 0.15)
      
      chospoints <- subset(plot_df(), Country %in% input$highlightedCountry) %>% top_n(1)
      
      plot <- plot + geom_point(data = chospoints, color="#00ff00", size=4) + geom_label(data =chospoints, aes(label=Country),hjust = 0, nudge_x = 0.15)
      
      
      plot +theme_bw() +  ggtitle("Relationship between student confidence and average score by country") + xlab("Percent of students who said they were confident in the subject") + ylab("Average score")
      
    })
    
    
    
    output$highlight <- renderUI({
      
      if (input$radioSubject2 == 1){
        if(input$radioGrade2==1){
          df2 <- MC4
        }
        else{
          df2 <- MC8
        }
      }
      else{
        if(input$radioGrade2==1){
          df2 <- SC4
        }
        else{
          df2 <- SC8
        }
      }
      selectInput("highlightedCountry", "Highlight a country (you can also click on points to find out what they are)", choices=sort(df2$Country))
    })


    

    
    
    
    
 
}

