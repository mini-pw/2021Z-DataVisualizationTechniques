library(fmsb)
library(dplyr)
library(wordcloud2)
library(networkD3)
library(plotly)
library(networkD3)
library(httr)
library(htmlwidgets)

function(input, output, session){
  
  output$text <- renderPrint("Ładuje się")
  
  #token submit
  observeEvent(input$submit, {
    
    key <- input$token
    
    #top artysci i gatunki dla nowej osoby i lista ich related artystów
    url = "https://api.spotify.com/v1/me/top/artists?time_range=long_term&limit=50&offset=0"
    G <- GET(url, add_headers(Authorization = paste("Bearer", key, sep = " "), Accept = " application/json", Content_Type = " application/json"))
    jsonRespText <- content(G,as="parsed")
    Sys.sleep(2)
    
    jsonRespText <- jsonRespText[["items"]]
    allGenresUser <- list()
    artistsUser <- list()
    artistsIdUser <- list()
    for (i in c(1:length(jsonRespText)))
    {
      artistsUser[i] <- jsonRespText[[i]]["name"]
      artistsIdUser[i] <- jsonRespText[[i]]["id"]
      lnList <- length(jsonRespText[[i]][["genres"]])
      lnGList <- length(allGenresUser)
      if (lnList != 0)
      {
        for (j in c(1:lnList))
        {
          allGenresUser[lnGList + j] <- jsonRespText[[i]][["genres"]][j]
        }
      }
    }
    artistsUser <- unlist(artistsUser)
    artistsIdUser <- unlist(artistsIdUser)
    
    allGenresUser <- unlist(allGenresUser, recursive=FALSE)
    allGenresUser <- as.data.frame(table(allGenresUser))
    allGenresUser <- allGenresUser[order(allGenresUser$Freq, decreasing = TRUE),]
    
    #Cloud na 4 osobe
    tempAllGenresUser <- allGenresUser
    colnames(tempAllGenresUser) <- c("allGenres", "Freq")
    tempAllGenresUser <- rbind(allGenres, tempAllGenresUser)
    tempAllGenresUser <- aggregate(tempAllGenresUser$Freq, by=list(allGenres=tempAllGenresUser$allGenres), FUN=sum)
    colnames(tempAllGenresUser) <- c("allGenres", "Freq")
    tempAllGenresUser <- tempAllGenresUser[order(tempAllGenresUser$Freq, decreasing = TRUE),]
    output$cloud <- renderWordcloud2({
      wordcloud2(data = tempAllGenresUser, widgetsize = 100, ellipticity = 1, color = "#008d4c", backgroundColor = "#222d32")
    })
    
    # Radar na 4 osobe
    output$radar <- renderPlotly({
      n = 10
      colnames(allGenresDominik) <- c("allGenres", "Dominik")
      colnames(allGenresPatryk) <- c("allGenres", "Patryk")
      colnames(allGenresTomek) <- c("allGenres", "Tomek")
      colnames(allGenresUser) <- c("allGenres", "User")
      
      genres <- inner_join(allGenres, allGenresDominik, by = "allGenres")
      genres <- inner_join(genres, allGenresPatryk, by = "allGenres")
      genres <- inner_join(genres, allGenresTomek, by = "allGenres")
      genres <- inner_join(genres, allGenresUser, by = "allGenres")
      
      rownames(genres) <- genres$allGenres
      genres <- arrange(genres, by = "All")
      genres <- genres[-c(1,2)]
      
      genres <- head(genres, n)
      fig <- plot_ly(
        type = 'scatterpolar',
        fill = 'toself',
        mode = 'markers') %>%
        add_trace(
          r = genres$Tomek,
          theta = unlist(rownames(genres)),
          name = 'Tomek',
          marker = list(
            color = rgb(86/256, 214/256, 240/256, 1)
          ),
          fillcolor = rgb(86/256, 214/256, 240/256, 0.4)) %>%
        add_trace(
          r = unlist(genres$Dominik),
          theta = unlist(rownames(genres)),
          name = 'Dominik',
          marker = list(
            color = rgb(247/256, 96/256, 129/256, 1)
          ),
          fillcolor = rgb(247/256, 96/256, 129/256, 0.4)) %>%
        add_trace(
          r = genres$Patryk,
          theta = unlist(rownames(genres)),
          name = 'Patryk',
          marker = list(
            color = rgb(240/256, 155/256, 86/256, 1)
          ),
          fillcolor = rgb(240/256, 155/256, 86/256, 0.4)) %>%
        add_trace(
          r = genres$User,
          theta = unlist(rownames(genres)),
          name = 'Ty',
          marker = list(
            color = rgb(96/256, 247/256, 169/256, 1)
          ),
          fillcolor = rgb(96/256, 247/256, 169/256, 0.4)) %>%
        layout(
          paper_bgcolor = rgb(0, 0, 0, 0),
          font = list(
            color = "#008d4c",
            size = 20
          ),
          polar = list(
            bgcolor = rgb(0.5,0.5,0.5,0),
            radialaxis = list(
              visible = T,
              range = c(0,20)
            )
          )
        )
      fig
    })
    
    
    url <- paste("https://api.spotify.com/v1/artists/", artistsIdUser[1], "/related-artists", sep="")
    G <- GET(url, add_headers(Authorization = paste("Bearer", key, sep = " "), Accept = " application/json", Content_Type = " application/json"))
    jsonRespText <- content(G,as="parsed")
    Sys.sleep(2)
    for (i in c(2:length(artistsUser)))
    {
      url <- paste("https://api.spotify.com/v1/artists/", artistsIdUser[i], "/related-artists", sep="")
      G <- GET(url, add_headers(Authorization = paste("Bearer", key, sep = " "), Accept = " application/json", Content_Type = " application/json"))
      jsonRespText <- c(jsonRespText, content(G,as="parsed"))
      #będzie się robić 100 sekund......
      output$text <- renderPrint(2*i)
      
      print(i)
      Sys.sleep(2)
    }
    #^
  
    t <- read.csv("relatedArtists.csv")
    t <- t[-1]
    
    artistsNames <- read.csv("artistsNames.csv")
    artistsNames <- artistsNames[-1]
    artistsNames <- as.character(artistsNames$x)
    
    C <- data.frame(source = numeric(0), destination = numeric(0))
    
    #jesli jest user
    artistsNames <- c(artistsNames, artistsUser) 
    #^
    
    #funkcja dla nas
    for (i in c(1:150))
    {
      for (j in c(1:20))
      {
        temp <- which(artistsNames == as.character(t[j,i]))
        if(length(temp) != 0)
        {
          for (k in 1:length(temp))
          {
            C <- rbind(C, data.frame(source = i - 1, destination = temp - 1))
          }
        }
      }
    }
    #^
    
    #funkcja dla User
    for (i in c(151:length(artistsNames)))
    {
      for (j in c(1:length(jsonRespText[[i-150]])))
      {
        temp <- which(artistsNames == jsonRespText[[i-150]][[j]][["name"]])
        if(length(temp) != 0)
        {
          for (k in 1:length(temp))
          {
            C <- rbind(C, data.frame(source = i - 1, destination = temp - 1))
          }
        }
      }
    }
    #^
    
    C <- unique(C)
    C$value <- rep(0.1, length(C$source))
    
    #jesli user
    nodes <- data.frame(
      name = artistsNames,
      group = c(rep("Tomek", 50), rep("Dominik", 50), rep("Patryk", 50), rep("Ty", length(artistsUser))),
      size = rep(20, 150+length(artistsUser)))
    #^
    
        
    output$force <- renderForceNetwork(
      {
        fn <- forceNetwork(Links = C, Nodes = nodes,
                           Source = "source", Target = "destination",
                           Value = "value", NodeID = "name",
                           Group = "group", Nodesize = "size", opacity = 1, charge = -10, bounded = T,
                           linkDistance = 150, fontSize = 20, height = 985, width = 1920,
                           opacityNoHover = 0.25, legend = TRUE, zoom = TRUE, fontFamily = "Helvetica",
                           colourScale = JS('d3.scaleOrdinal().domain(["Tomek", "Dominik", "Patryk", "Ty"]).range(["#56d6f0", "#f76081", "#f09b56", "#60f7a9"])'))
        
        htmlwidgets::onRender(
          fn,
          'function(el, x) { 
          d3.selectAll(".legend text").style("font-size", "18px");
          d3.selectAll(".legend text").style("fill", "#008d4c");
          }'
        )
      }
    )
      
  })

  #Cloud
 output$cloud <- renderWordcloud2({
   wordcloud2(data = allGenres,  widgetsize = 100, ellipticity = 0.5, color = "#008d4c", backgroundColor = "#222d32")
 })
 
 #Print Cloud
 output$print  = renderPrint(input$cloud_clicked_word)
 
 
 #Graf
 
 output$force <- renderForceNetwork({
   t <- read.csv("relatedArtists.csv")
   t <- t[-1]
   
   artistsNames <- read.csv("artistsNames.csv")
   artistsNames <- artistsNames[-1]
   artistsNames <- as.character(artistsNames$x)
   
   C <- data.frame(source = numeric(0), destination = numeric(0))
   
   for (i in c(1:150))
   {
     for (j in c(1:20))
     {
       temp <- which(artistsNames == as.character(t[j,i]))
       if(length(temp) != 0)
       {
         for (k in 1:length(temp))
         {
           C <- rbind(C, data.frame(source = i - 1, destination = temp - 1))
         }
       }
     }
   }
   
   
   C <- unique(C)
   C$value <- rep(0.1, length(C$source))
   
   #jesli tylko my
   nodes <- data.frame(
     name = artistsNames,
     group = c(rep("Tomek", 50), rep("Dominik", 50), rep("Patryk", 50)),
     size = rep(20, 150),
     aId = artistsId$x)
   #^
   
   
   fn <- forceNetwork(Links = C, Nodes = nodes,
                Source = "source", Target = "destination",
                Value = "value", NodeID = "name",
                Group = "group", Nodesize = "size", opacity = 1, charge = -10, bounded = T,
                linkDistance = 150, fontSize = 20, height = 985, width = 1920,
                opacityNoHover = 0.25, legend = TRUE, zoom = TRUE, fontFamily = "Helvetica",
                colourScale = JS('d3.scaleOrdinal().domain(["Tomek", "Dominik", "Patryk"]).range(["#56d6f0", "#f76081", "#f09b56"])'), 
                clickAction = 'window.open(d.hyperlink)')
   
   fn$x$nodes$hyperlink <- paste0(
     'https://open.spotify.com/artist/',
     nodes$aId
   )
   
   htmlwidgets::onRender(
     fn,
     'function(el, x) { 
      d3.selectAll(".legend text").style("font-size", "18px");
      d3.selectAll(".legend text").style("fill", "#008d4c");
      }'
   )

 })
 
 # Radar
 output$radar <- renderPlotly({
   n = 10
   colnames(allGenresDominik) <- c("allGenres", "Dominik")
   colnames(allGenresPatryk) <- c("allGenres", "Patryk")
   colnames(allGenresTomek) <- c("allGenres", "Tomek")
   genres <- inner_join(allGenres, allGenresDominik, by = "allGenres")
   genres <- inner_join(genres, allGenresPatryk, by = "allGenres")
   genres <- inner_join(genres, allGenresTomek, by = "allGenres")
   rownames(genres) <- genres$allGenres
   genres <- arrange(genres, by = "All")
   genres <- genres[-c(1,2)]
   
   genres <- head(genres, n)
   fig <- plot_ly(
     type = 'scatterpolar',
     fill = 'toself',
     mode = 'markers'
     ) %>%
     add_trace(
       r = genres$Tomek,
       theta = unlist(rownames(genres)),
       name = 'Tomek',
       marker = list(
         color = rgb(86/256, 214/256, 240/256, 1)
       ),
       fillcolor = rgb(86/256, 214/256, 240/256, 0.4)) %>%
     add_trace(
       r = unlist(genres$Dominik),
       theta = unlist(rownames(genres)),
       name = 'Dominik',
       marker = list(
         color = rgb(247/256, 96/256, 129/256, 1)
       ),
       fillcolor = rgb(247/256, 96/256, 129/256, 0.4)) %>%
     add_trace(
       r = genres$Patryk,
       theta = unlist(rownames(genres)),
       name = 'Patryk',
       marker = list(
         color = rgb(240/256, 155/256, 86/256, 1)
       ),
       fillcolor = rgb(240/256, 155/256, 86/256, 0.4)) %>%
     layout(
       paper_bgcolor = rgb(0, 0, 0, 0),
       font = list(
         color = "#008d4c",
         size = 20
       ),
       polar = list(
         bgcolor = rgb(0.5,0.5,0.5,0),
         radialaxis = list(
           visible = T,
           range = c(0,20),
           tickfont = list(
             color = "#9e9e9e"
           )
         )
       )
     )
   fig
 })
 
 
 output$progressBox <- renderValueBox({
   vec <- c("Gatunek", " ")
   click <- toString(input$cloud_clicked_word)
   click <- unlist(strsplit(click, ":"))
   if (length(click) != 0){
     vec <- click
   }
   print(vec)
   valueBox(
     vec[2], vec[1],
     color = "green"
   )
 })
}