function(input, output, session) {
  
  
  output$A_top_artists_img1 <- renderText({c('<img src="',A_top_artists_img_url[1],'"style="width:100px;height:100px;">')})
  output$A_top_tracks_img1 <- renderText({c('<img src="',A_top_tracks_img_url[1],'"style="width:100px;height:100px;">')})
  output$A_top_albums_img1 <- renderText({c('<img src="',A_top_albums_img_url[1],'"style="width:100px;height:100px;">')})
  output$A_top_artists_img2 <- renderText({c('<img src="',A_top_artists_img_url[2],'"style="width:100px;height:100px;">')})
  output$A_top_tracks_img2 <- renderText({c('<img src="',A_top_tracks_img_url[2],'"style="width:100px;height:100px;">')})
  output$A_top_albums_img2 <- renderText({c('<img src="',A_top_albums_img_url[2],'"style="width:100px;height:100px;">')})
  output$A_top_artists_img3 <- renderText({c('<img src="',A_top_artists_img_url[3],'"style="width:100px;height:100px;">')})
  output$A_top_tracks_img3 <- renderText({c('<img src="',A_top_tracks_img_url[3],'"style="width:100px;height:100px;">')})
  output$A_top_albums_img3 <- renderText({c('<img src="',A_top_albums_img_url[3],'"style="width:100px;height:100px;">')})
  
  output$P_top_artists_img1 <- renderText({c('<img src="',P_top_artists_img_url[1],'"style="width:100px;height:100px;">')})
  output$P_top_tracks_img1 <- renderText({c('<img src="',P_top_tracks_img_url[1],'"style="width:100px;height:100px;">')})
  output$P_top_albums_img1 <- renderText({c('<img src="',P_top_albums_img_url[1],'"style="width:100px;height:100px;">')})
  output$P_top_artists_img2 <- renderText({c('<img src="',P_top_artists_img_url[2],'"style="width:100px;height:100px;">')})
  output$P_top_tracks_img2 <- renderText({c('<img src="',P_top_tracks_img_url[2],'"style="width:100px;height:100px;">')})
  output$P_top_albums_img2 <- renderText({c('<img src="',P_top_albums_img_url[2],'"style="width:100px;height:100px;">')})
  output$P_top_artists_img3 <- renderText({c('<img src="',P_top_artists_img_url[3],'"style="width:100px;height:100px;">')})
  output$P_top_tracks_img3 <- renderText({c('<img src="',P_top_tracks_img_url[3],'"style="width:100px;height:100px;">')})
  output$P_top_albums_img3 <- renderText({c('<img src="',P_top_albums_img_url[3],'"style="width:100px;height:100px;">')})
  
  output$M_top_artists_img1 <- renderText({c('<img src="',M_top_artists_img_url[1],'"style="width:100px;height:100px;">')})
  output$M_top_tracks_img1 <- renderText({c('<img src="',M_top_tracks_img_url[1],'"style="width:100px;height:100px;">')})
  output$M_top_albums_img1 <- renderText({c('<img src="',M_top_albums_img_url[1],'"style="width:100px;height:100px;">')})
  output$M_top_artists_img2 <- renderText({c('<img src="',M_top_artists_img_url[2],'"style="width:100px;height:100px;">')})
  output$M_top_tracks_img2 <- renderText({c('<img src="',M_top_tracks_img_url[2],'"style="width:100px;height:100px;">')})
  output$M_top_albums_img2 <- renderText({c('<img src="',M_top_albums_img_url[2],'"style="width:100px;height:100px;">')})
  output$M_top_artists_img3 <- renderText({c('<img src="',M_top_artists_img_url[3],'"style="width:100px;height:100px;">')})
  output$M_top_tracks_img3 <- renderText({c('<img src="',M_top_tracks_img_url[3],'"style="width:100px;height:100px;">')})
  output$M_top_albums_img3 <- renderText({c('<img src="',M_top_albums_img_url[3],'"style="width:100px;height:100px;">')})
  
  
  
  
  output$Aradar <- renderPlotly({
    if (input$plotType == "spoti"){
      plot_ly(
        type = 'scatterpolar',
        mode = "markers",
        r = as.numeric(as.vector(A_radar)),
        theta = colnames(A_radar),
        fill = 'toself',
        fillcolor = "rgba(101, 211, 110, 0.87)",
        marker =  list(color = "#65a46e", size = 5),
        hovertemplate = "Feature: %{theta} \nValue: %{r:.4f}<extra></extra>",
        hoveron = "points"
      ) %>%
        layout(
          font = list(color = "#65D36E"),
          showlegend = F,
          plot_bgcolor  = "rgba(0, 0, 0, 0)",
          paper_bgcolor = "rgba(0, 0, 0, 0)"
        ) %>% 
        layout(
          polar = list(
            bgcolor = "rgba(0, 0, 0, 0)",
            radialaxis = list(
              visible = T,
              range = c(0,1),
              gridcolor = "#FFFFFF",
              color = "#FFFFFF",
              tickfont = list(color = "#FFFFFF")
            ),
            angularaxis = list(
              linecolor = "#FFFFFF",
              tickfont = list(size = 14)
            )
          )
        )%>%
        config(displayModeBar = FALSE)
    } else if (input$plotType == "our"){
      plot_ly(
        type = 'scatterpolar',
        mode = "markers",
        r = as.numeric(as.vector(A_radar2)),
        theta = colnames(A_radar),
        fill = 'toself',
        fillcolor = "rgba(101, 211, 110, 0.87)",
        marker =  list(color = "#65a46e", size = 5),
        hovertemplate = "Feature: %{theta} \nValue: %{r:.4f}<extra></extra>",
        hoveron = "points"
      ) %>%
        layout(
          font = list(color = "#65D36E"),
          showlegend = F,
          plot_bgcolor  = "rgba(0, 0, 0, 0)",
          paper_bgcolor = "rgba(0, 0, 0, 0)"
        ) %>% 
        layout(
          polar = list(
            bgcolor = "rgba(0, 0, 0, 0)",
            radialaxis = list(
              visible = T,
              range = c(0,1),
              gridcolor = "#FFFFFF",
              color = "#FFFFFF",
              tickfont = list(color = "#FFFFFF")
            ),
            angularaxis = list(
              linecolor = "#FFFFFF",
              tickfont = list(size = 14)
            )
          )
        )%>%
        config(displayModeBar = FALSE)
    }
    
    
  })
  
  
  
  output$Pradar <- renderPlotly({
    if (input$plotType == "spoti"){
      plot_ly(
        type = 'scatterpolar',
        mode = "markers",
        r = as.numeric(as.vector(P_radar)),
        theta = colnames(P_radar),
        fill = 'toself',
        fillcolor = "rgba(101, 211, 110, 0.87)",
        marker =  list(color = "#65a46e", size = 5),
        hovertemplate = "Feature: %{theta} \nValue: %{r:.4f}<extra></extra>",
        hoveron = "points"
      ) %>%
        layout(
          font = list(color = "#65D36E"),
          showlegend = F,
          plot_bgcolor  = "rgba(0, 0, 0, 0)",
          paper_bgcolor = "rgba(0, 0, 0, 0)"
        ) %>% 
        layout(
          polar = list(
            bgcolor = "rgba(0, 0, 0, 0)",
            radialaxis = list(
              visible = T,
              range = c(0,1),
              gridcolor = "#FFFFFF",
              color = "#FFFFFF",
              tickfont = list(color = "#FFFFFF")
            ),
            angularaxis = list(
              linecolor = "#FFFFFF",
              tickfont = list(size = 14)
            )
          )
        )%>%
        config(displayModeBar = FALSE)
    } else if (input$plotType == "our"){
      plot_ly(
        type = 'scatterpolar',
        mode = "markers",
        r = as.numeric(as.vector(P_radar2)),
        theta = colnames(P_radar),
        fill = 'toself',
        fillcolor = "rgba(101, 211, 110, 0.87)",
        marker =  list(color = "#65a46e", size = 5),
        hovertemplate = "Feature: %{theta} \nValue: %{r:.4f}<extra></extra>",
        hoveron = "points"
      ) %>%
        layout(
          font = list(color = "#65D36E"),
          showlegend = F,
          plot_bgcolor  = "rgba(0, 0, 0, 0)",
          paper_bgcolor = "rgba(0, 0, 0, 0)"
        ) %>% 
        layout(
          polar = list(
            bgcolor = "rgba(0, 0, 0, 0)",
            radialaxis = list(
              visible = T,
              range = c(0,1),
              gridcolor = "#FFFFFF",
              color = "#FFFFFF",
              tickfont = list(color = "#FFFFFF")
            ),
            angularaxis = list(
              linecolor = "#FFFFFF",
              tickfont = list(size = 14)
            )
          )
        )%>%
        config(displayModeBar = FALSE)
    }
  })
  
  
  
  output$Mradar <- renderPlotly({
    if (input$plotType == "spoti"){
      plot_ly(
        type = 'scatterpolar',
        mode = "markers",
        r = as.numeric(as.vector(M_radar)),
        theta = colnames(M_radar),
        fill = 'toself',
        fillcolor = "rgba(101, 211, 110, 0.87)",
        marker =  list(color = "#65a46e", size = 5),
        hovertemplate = "Feature: %{theta} \nValue: %{r:.4f}<extra></extra>",
        hoveron = "points"
      ) %>%
        layout(
          font = list(color = "#65D36E"),
          showlegend = F,
          plot_bgcolor  = "rgba(0, 0, 0, 0)",
          paper_bgcolor = "rgba(0, 0, 0, 0)"
        ) %>% 
        layout(
          polar = list(
            bgcolor = "rgba(0, 0, 0, 0)",
            radialaxis = list(
              visible = T,
              range = c(0,1),
              gridcolor = "#FFFFFF",
              color = "#FFFFFF",
              tickfont = list(color = "#FFFFFF")
            ),
            angularaxis = list(
              linecolor = "#FFFFFF",
              tickfont = list(size = 14)
            )
          )
        )%>%
        config(displayModeBar = FALSE)
    } else if (input$plotType == "our"){
      plot_ly(
        type = 'scatterpolar',
        mode = "markers",
        r = as.numeric(as.vector(M_radar2)),
        theta = colnames(M_radar),
        fill = 'toself',
        fillcolor = "rgba(101, 211, 110, 0.87)",
        marker =  list(color = "#65a46e", size = 5),
        hovertemplate = "Feature: %{theta} \nValue: %{r:.4f}<extra></extra>",
        hoveron = "points"
      ) %>%
        layout(
          font = list(color = "#65D36E"),
          showlegend = F,
          plot_bgcolor  = "rgba(0, 0, 0, 0)",
          paper_bgcolor = "rgba(0, 0, 0, 0)"
        ) %>% 
        layout(
          polar = list(
            bgcolor = "rgba(0, 0, 0, 0)",
            radialaxis = list(
              visible = T,
              range = c(0,1),
              gridcolor = "#FFFFFF",
              color = "#FFFFFF",
              tickfont = list(color = "#FFFFFF")
            ),
            angularaxis = list(
              linecolor = "#FFFFFF",
              tickfont = list(size = 14)
            )
          )
        )%>%
        config(displayModeBar = FALSE)
    }
  })
  
  output$feature_densities_plot <- renderPlotly({
    simpleCap <- function(x) {
      s <- strsplit(x, " ")[[1]]
      paste(toupper(substring(s, 1,1)), substring(s, 2),
            sep="", collapse=" ")
    }
    feature_names <- names(M_features_densities)
    plots <- lapply(feature_names, function(feature_n) {
      plot_ly(x = ~M_features_densities[[feature_n]][['x']],
              y = ~M_features_densities[[feature_n]][['y']],
              type = 'scatter', mode = 'lines', color = 'red', name = 'Mateusz') %>%
        add_trace(x = ~P_features_densities[[feature_n]][['x']],
                  y = ~P_features_densities[[feature_n]][['y']],
                  color = 'blue', name = 'Pawel')%>%
        add_trace(x = ~A_features_densities[[feature_n]][['x']],
                  y = ~A_features_densities[[feature_n]][['y']],
                  color = 'green', name = 'Artur')%>%
        layout(xaxis = list(title=simpleCap(feature_n)),
               yaxis = list(showticklabels = FALSE),
               showlegend = FALSE,
               plot_bgcolor  = "#121212",
               paper_bgcolor = "#121212",
               font = list(color="white"))
    })
    a <- subplot(plots[1:3], nrows = 1, shareX = TRUE, titleX = TRUE)
    b <- subplot(plots[4:6], nrows = 1, shareX = TRUE, titleX = TRUE)
    subplot(a,b, nrows = 2, titleX = TRUE, margin = 0.1)%>%
      config(displayModeBar = FALSE)
    
  })
  
  
  #dane do wordcloud
  dataCloud <- reactive({
    if(input$dataType == "genres"){
      dataframe <- get(paste(input$whoseData, "genres", sep=""))
    } else{
      get(input$whoseData) %>% 
        group_by_(input$dataType) %>% 
        count() %>% 
        arrange(-n) -> dataframe
      colnames(dataframe) <- c("word", "freq")
    }
    dataframe %>% 
      filter(freq >= input$freqWords) %>%
      head(input$maxWords)
  })
  
  output$cloud <- renderWordcloud2({
    wordcloud2(dataCloud(), size = 0.5,  backgroundColor = "#121212", color = "#65D36E",
               fontWeight = "normal", fontFamily = "Arial", rotateRatio = 0.7)
  })
  
  
  #lista artystów do wyboru w zależności od użytkownika do wyboru   
  dataArtists <- reactive({
    dataframe <- get(input$whoseData)
    dataframe %>% 
      group_by(artistName) %>%
      count() %>%
      arrange(-n) %>%
      head(50) -> dataframe
    dataframe$artistName
  })
  
  observe({
    updateSelectInput(session, "artist",
                      choices = dataArtists()
    )})
  
  #dane dla wybranego artysty
  dataArtistBarPlot <- reactive({
    dataframe <- get(input$whoseData)
    dataframe %>% 
      filter(artistName == input$artist) %>% 
      group_by(trackName) %>% 
      count() %>% 
      arrange(-n) %>% 
      head(10) -> dataframe
    colnames(dataframe) <- c("Title", "Streams")
    dataframe
  })
  
  output$mostStreamedBarplot <- renderPlotly({
    plot <- ggplot(dataArtistBarPlot(), 
                   aes(x = reorder(unlist(lapply(strwrap(Title, 10, simplify = FALSE), paste, collapse="\n")), -Streams), 
                       y = Streams, label = Title)) +
      geom_col(fill = "#65D36E") +
      scale_y_continuous(breaks = function(x) unique(floor(pretty(seq(0, (max(x) + 1) * 1.1))))) +
      theme(
        text=element_text(family="Proza Libre"),
        plot.background = element_rect(fill="transparent"),
        panel.background = element_rect(fill="transparent"),
        panel.grid.major.x = element_blank(),
        axis.text.x = element_text(size = 12, color = "#FFFFFF"),
        axis.text.y = element_text(size = 12, color = "#FFFFFF"),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 12, color = "#FFFFFF")) + 
      ylab("Number of streams")
    ggly <- ggplotly(plot, height = 500, tooltip = c("y", "label"))%>%
      config(displayModeBar = FALSE)
  })
  
  
  # ---------------------------- Kalendarz ---------------------------- #
  dataCalendar <- reactive({
    dataframe <- get(input$whoseData)
    dataframe$endTime <- substr(dataframe$endTime, 1, 11)
    dataframe <- dataframe %>%
      group_by(endTime) %>%
      count() %>%
      rename(date=endTime) %>%
      filter(grepl("2020", as.character(date)))
    
    # usuniecie anomalii u Pawla 27 czerwca
    if(input$whoseData == "Pdf"){
      dataframe[167,'n'] <- 50
    }
    
    dataframe
  })
  
  output$streamedCalendar1 <- renderSupercaliheatmapwidget({
    supercal(
      dataCalendar(), 
      datetime_col = date, value_col = n,
      label = cal_label("top", "center", height = 20),
      cell_size = 20,
      cell_padding = 2, 
      tooltip_item_name = cal_names("stream"),
      col_limit = 3,
      range=4,
      orientation='vertical',
      height="100%"
    ) %>% 
      cal_legend(show=FALSE, colors = cal_colors(min = "#DBE3DD", max = "#006522"))
    
  })
  
  output$streamedCalendar2 <- renderSupercaliheatmapwidget({
    supercal(
      dataCalendar(),
      datetime_col = date, value_col = n,
      label = cal_label("top", "center", height = 20),
      cell_size = 20,
      cell_padding = 2,
      tooltip_item_name = cal_names("stream"),
      col_limit = 1,
      range=4,
      start='2020-05-01',
      orientation='vertical',
      height="100%"
    )%>%
      cal_legend(show=FALSE, colors = cal_colors(min = "#DBE3DD", max = "#006522"))
  })
  
  output$streamedCalendar3 <- renderSupercaliheatmapwidget({
    supercal(
      dataCalendar(),
      datetime_col = date, value_col = n,
      label = cal_label("top", "center", height = 20),
      cell_size = 20,
      cell_padding = 2,
      tooltip_item_name = cal_names("stream"),
      col_limit = 1,
      range=4,
      start='2020-09-01',
      orientation='vertical',
      height="100%"
    )%>%
      cal_legend(show=FALSE, colors = cal_colors(min = "#DBE3DD", max = "#006522"))
  })
  
  output$fb_image_2 <- renderImage({
    switch(input$whoseNetwork,
           "Pawel" = list(src = 'www/pawel-fb.png',
                               width = "100%"),
           "Mateusz" = list(src = 'www/mateusz-fb.png',
                          width = "100%"),
           "Artur" = list(src = 'www/artur-fb.png',
                          width = "100%"))
  }, deleteFile = FALSE)
  
  
  
  getFeatureTimeData <- reactive({
    dataframe <- get(input$whoseData)
    feature <- input$featureType
    dataframe$endTime <- substr(dataframe$endTime, 1, 11)
    dataframe <- dataframe %>% 
      select(endTime, feature)
    dataframe <- dataframe%>%
      group_by(endTime) %>%
      summarize(median = median(!!sym(feature)), q1=quantile(!!sym(feature),0.25), q3=quantile(!!sym(feature),0.75))
    dataframe[['endTime']] <- strptime(dataframe[['endTime']], format = '%Y-%m-%d')
    rownames(dataframe) = dataframe[[1]]
    dataframe <- xts(dataframe[2:4], order.by = dataframe$endTime)
    dataframe
  })
  
  output$featureInTime <- renderDygraph({
    dygraph(getFeatureTimeData(), main = paste0("The median and the interquartile range of the ", input$featureType)) %>%
      dySeries(name = c("q1", "median", "q3"), label = input$featureType) %>%
      dyRangeSelector(dateWindow = c("2020-12-01", "2020-12-31")) %>% 
      dyAxis('y', valueRange=c(0,1.1), axisLabelColor = "#65D36E") %>% 
      dyAxis('x', axisLabelColor = "#65D36E") %>% 
      dyOptions(colors = "#65D36E", ) 
  })
  
  getFeatDesc <- reactive({
    text <- ""
    if(input$featureType=='acousticness'){
      text <- "A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic."
    }
    if(input$featureType=='danceability'){
      text <- "Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable."
    }
    if(input$featureType=='energy'){
      text <- "Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy."
    }
    if(input$featureType=='instrumentalness'){
      text <- "Predicts whether a track contains no vocals. “Ooh” and “aah” sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly “vocal”. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0."
    }
    if(input$featureType=='liveness'){
      text <- "Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live."
    }
    if(input$featureType=='valence'){
      text <- "A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry)."
    }
    text
  })
  
  output$featureDescription <- renderText({
    getFeatDesc()
  })
  
  
}



