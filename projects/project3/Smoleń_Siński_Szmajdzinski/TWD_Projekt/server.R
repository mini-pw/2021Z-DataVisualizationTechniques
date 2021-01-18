library(jsonlite)
library(plotly)
library(dplyr)
library(ggplot2)
library(shiny)
library(reshape2)
library(igraph)
library(networkD3) # w razie kłopotów załadować biblitokę newtorkD3 ręcznie przez odpaleniem aplikacji
library(stats)
library(dplyr)
options(stringsAsFactors=FALSE)
## Dane Bartek

sinskiFeatures <- fromJSON("sinskiFeatures.json")[[1]]
szmejFeatures <- fromJSON("szmajaFeatures.json")[[1]]
smolenFeatures <- fromJSON("smolenFeatures.json")[[1]]
  
sinskiFeatures <- sinskiFeatures %>% 
  select(danceability,acousticness,energy,instrumentalness,liveness,valence,tempo) %>%
  summarise(across(.fns = mean)) %>% mutate(tempo = tempo/300) 
sinskiFeatures$owner <- "Bartek"

szmejFeatures <- szmejFeatures %>% 
  select(danceability,acousticness,energy,instrumentalness,liveness,valence,tempo) %>%
  summarise(across(.fns = mean)) %>% mutate(tempo = tempo/300)
szmejFeatures$owner <- "Szymon"

smolenFeatures <- smolenFeatures %>% 
  select(danceability,acousticness,energy,instrumentalness,liveness,valence,tempo) %>%
  summarise(across(.fns = mean)) %>% mutate(tempo = tempo/300) 
smolenFeatures$owner <- "Janek"
Features <- rbind(sinskiFeatures,szmejFeatures)
Features <- rbind(Features,smolenFeatures)
Features <- melt(Features,variable.name = "features")


## Dane Janek

SmolenAnim <- read.csv("SmolenAnim.csv")
SmolenRange <- read.csv("SmolenRange.csv")
SinskiAnim <- read.csv("SinskiAnim.csv")
SinskiRange <- read.csv("SinskiRange.csv")
#SmolenColor <- read.csv("SmolenColor.csv")
#SinskiColor <- read.csv("SinskiColor.csv")
SzmejRange <- read.csv("SzmejRange.csv")
SzmejAnim <- read.csv("SzmejAnim.csv")
#SzmejColor <- read.csv("SzmejColor.csv")

##### Dane Szymon 
# Data for barplot
weekly_data <- read.csv("weekly_data.csv")

# Data for graph
node_all <- read.csv("node_all.csv")
edge_all <- read.csv("edge_all.csv")
node_two <- read.csv("node_two.csv")
edge_two <- read.csv("edge_two.csv")
node_one <- read.csv("node_one.csv")
edge_one <- read.csv("edge_one.csv")

### Kolory
owner <- c("Bartek","Janek","Szymon")
color <- c("#5199FF", "#4BB462", "#E85668")
owner_colors <- data.frame(owner,color)

shinyServer(function(input, output) {
  
  #### Wykres Bartek 
  
  output$radar_plot <- renderPlotly({
    choosen_features <- filter(Features, owner %in% input$kto_slucha)
    chosen_colors <- filter(owner_colors, owner %in% input$kto_slucha)
    fig <- plot_ly(data = choosen_features,
      r = ~value,
      theta = ~features,
      showlegend = FALSE,
      color = ~owner,
      colors = as.vector(chosen_colors[["color"]]),
      type = 'scatterpolar',
      fill = 'toself',
      mode = 'markers'
     )
    m <- list(
      l = 10,
      r = 10,
      b = 20,
      t = 50,
      pad = 4
    )
    fig <- fig %>%
      layout(
        title = list(
          text = "Average features of our favourite tracks in 2020"
          ),
        polar = list(
          radialaxis = list(
            visible = T,
            range = c(0,1)
          )
        ),
        margin = m
      ) %>% config(displayModeBar = F)
    return(fig)
  })
  
  ### Wykresy Smol
  
  output$p <- renderPlot({   ##plynnosc opcji play w zaleznosci od maszyny
    z <- get(paste(input$person, "Anim", sep=""))
    if(input$person=="Smolen"){
      cc=as.vector("#4BB462")
    }
    if(input$person=="Szmej"){
      cc=as.vector("#E85668")
    }
    if(input$person=="Sinski"){
      cc=as.vector("#5199FF")
    }
    
    a<-(z %>% filter(date==input$date))   # tu z
    ggplot(a, aes(x=-pos, y=no))+
      geom_bar(stat="identity", alpha=0.8, fill=cc, color=cc)+
      geom_text(aes(x=-pos, y=no*1.1, label=artistName, colour="black"), size=4.5, color="black")+
      coord_flip()+theme_bw()+
      theme(
        plot.title=element_text(size=25),
        legend.position="none",
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title=element_text(size=16),
        axis.text=element_text(size=14)
        )+
      labs(title = "Top artists since Jan 01 2020", y="Number of listens")
  })
  
  
  
  output$q <- renderPlot({
    b <- get(paste(input$person, "Range", sep=""))
    aa <- b %>% filter(endTime>=input$range[1] & as.Date(endTime) <=input$range[2])   
    aa <- aa %>% count(artistName) %>% arrange(n) %>% top_n(10)
    if(input$person=="Smolen"){
      cc=as.vector("#4BB462")
    }
    if(input$person=="Szmej"){
      cc=as.vector("#E85668")
    }
    if(input$person=="Sinski"){
      cc=as.vector("#5199FF")
    }
    
    #aa <- left_join(aa, get(paste(input$person, "Color", sep="")))
    ggplot(aa, aes(x=reorder(artistName, n), y=n, fill=as.character(artistName), color=as.character(artistName)))+
      geom_bar(stat="identity", alpha=0.8, fill=cc, color=cc)+
      geom_text(aes(x=artistName, y=n*1.1, label=artistName), size=4.5, color="black")+theme_bw()+
      coord_flip()+
      theme(
        plot.title=element_text(size=25),
        legend.position="none",
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title=element_text(size=16),
        axis.text=element_text(size=14))+
      labs(title = "Top artists in given time period", y="Number of listens")})
  
  ###### Wykresy Szymon

  output$bar_year <- renderPlotly({
    if (length(input$kto_slucha) != 0) {
    timePer_week <- filter(weekly_data, name %in% input$kto_slucha)
    chosen_colors <- filter(owner_colors, owner %in% input$kto_slucha)
    p1 <- ggplot(data = timePer_week, aes(x = as.Date(week), y = weekly_time)) +
      geom_line(aes(color = name)) +  scale_color_manual(values = as.vector(chosen_colors[["color"]]))+
      scale_x_date(date_labels = "%b") + theme_bw() + labs(x = "Week",y = "Listening Time",title = "Listening time per week in 2020")+
      theme(
        legend.text = element_text(size = 15),
        plot.title=element_text(size=25),
      )
    p1 <- ggplotly(p1) %>% layout(legend = list(orientation = 'h',x= 0.2,y=-0.2),valign = "middle") %>% config(displayModeBar = F)
    return(p1)
    }
  })
  
  
  output$graph <- renderForceNetwork({
    if (length(input$kto_slucha) == 3){
      el <- edge_all
      nl <- node_all
      colors <- 'd3.scaleOrdinal(["#E85668", "#4BB462", "#5199FF", "black"])'
    } else if (length(input$kto_slucha) == 2){
      if ("Szymon" %in% input$kto_slucha & "Bartek" %in% input$kto_slucha){
        war <- "sb"
        colors <- 'd3.scaleOrdinal(["#E85668","#5199FF", "black"])'
      } else if ("Janek" %in% input$kto_slucha & "Bartek" %in% input$kto_slucha){
        war <- "jb"
        colors <- 'd3.scaleOrdinal(["#4BB462", "#5199FF", "black"])'
      } else {
        war <- "sj"
        colors <- 'd3.scaleOrdinal(["#E85668", "#4BB462", "black"])'
      }
      el <- edge_two %>% filter(wariant == war)
      nl <- node_two %>% filter(wariant == war)
    } else if (length(input$kto_slucha) == 1) {
      el <- edge_one %>% filter(wariant == input$kto_slucha)
      nl <- node_one %>% filter(wariant == input$kto_slucha)
      if ("Szymon" == input$kto_slucha)  {
        colors <- 'd3.scaleOrdinal(["#E85668", "black"])'
      } else if ("Janek" == input$kto_slucha) {
        colors <- 'd3.scaleOrdinal(["#4BB462", "black"])'
      }else if ("Bartek" == input$kto_slucha){
        colors <- 'd3.scaleOrdinal(["#5199FF", "black"])'
      } 
    } else if (length(input$kto_slucha) == 0) {
      el <- data_frame(
        from_num=c(0),
        to_num=c(0)
      )
      nl <- data_frame(
        id = c(0),user = c(0),b = c(0),d = c(0), a = c(0)
      )
      colors <- 'd3.scaleOrdinal(["white"])'
    }
   
    forceNetwork(Links = el, Nodes = nl, Source="from_num", Target="to_num", NodeID = "id",
                 Group = "user", linkWidth = 1,
                 colourScale = colors,
                 linkColour = "#afafaf", Nodesize=5,fontSize=12, zoom=T, legend=F,
                 opacity = 0.8, charge=-400,
                 width = 300, height = 300, 
                 opacityNoHover = 1)
    
    
  })
  
})
