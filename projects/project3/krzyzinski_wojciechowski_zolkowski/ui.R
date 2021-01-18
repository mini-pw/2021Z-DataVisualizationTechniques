my_theme <- bs_theme(
  bg = "#121212",
  fg = "#FFFFFF",
  primary = "#1CD155",
  base_font = font_google("Proza Libre"),
  heading_font = font_google("Proza Libre"),
  code_font = font_google("Fira Code")
)


navbarPage(
  "Spotify Data Visualtization",
  theme = my_theme,
  tabPanel(
    "Start",
    fluidPage(
      h1(
        "Spotify Data Visualtization",
        align = "center",
        style = "color: #65D36E;"
      ),
      fluidRow(
        column(4, align = "center", h1("Artur")),
        column(4, align = "center", h1("Paweł")),
        column(4, align = "center", h1("Mateusz"))
      ),
      
      fluidRow(
        column(
          4,
          align = "center",
          style = 'padding: 10px;',
          h3("Listening time", style = "color: #65D36E;"),
          fluidRow(
            column(4, h4(round(A_listening_time), style = "color: #65D36E;"),
                   "minutes"),
            column(4, h4(round(
              A_listening_time / 60, 2
            ), style = "color: #65D36E;"),
            "hours"),
            column(4, h4(round(
              A_listening_time / (24 * 60), 2
            ), style = "color: #65D36E;"),
            "days")
          ),
          
          h3("Streaming Numbers", style = "color: #65D36E;"),
          fluidRow(
            column(4, h4(A_plays_number, style = "color: #65D36E;"),
                   "plays"),
            column(
              4,
              h4(A_artists_number, style = "color: #65D36E;"),
              "different artists"
            ),
            column(
              4,
              h4(A_tracks_number, style = "color: #65D36E;"),
              "different songs"
            )
          ),
          
          h3("Top Artists", style = "color: #65D36E;"),
          fluidRow(
            column(4, align = "center",
                   htmlOutput("A_top_artists_img1"),
                   A_top_artists[1]),
            column(4, align = "center",
                   htmlOutput("A_top_artists_img2"),
                   A_top_artists[2]),
            column(4, align = "center",
                   htmlOutput("A_top_artists_img3"),
                   A_top_artists[3])
          ),
          
          
          h3("Top Albums", style = "color: #65D36E;"),
          fluidRow(
            column(
              4,
              align = "center",
              htmlOutput("A_top_albums_img1"),
              A_top_albums[[1]][2],
              br(),
              "by",
              A_top_albums[[1]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("A_top_albums_img2"),
              A_top_albums[[2]][2],
              br(),
              "by",
              A_top_albums[[2]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("A_top_albums_img3"),
              A_top_albums[[3]][2],
              br(),
              "by",
              A_top_albums[[3]][1]
            )
          ),
          
          br(),
          h3("Top Tracks", style = "color: #65D36E;"),
          fluidRow(
            column(
              4,
              align = "center",
              htmlOutput("A_top_tracks_img1"),
              A_top_tracks[[1]][2],
              br(),
              "by",
              A_top_tracks[[1]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("A_top_tracks_img2"),
              A_top_tracks[[2]][2],
              br(),
              "by",
              A_top_tracks[[2]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("A_top_tracks_img3"),
              A_top_tracks[[3]][2],
              br(),
              "by",
              A_top_tracks[[3]][1]
            )
          )
        ),
        
        
        column(
          4,
          align = "center",
          style = 'border-left:1px solid #65D36E; padding: 10px;',
          h3("Listening time", style = "color: #65D36E;"),
          fluidRow(
            column(4, h4(round(P_listening_time), style = "color: #65D36E;"),
                   "minutes"),
            column(4, h4(round(
              P_listening_time / 60, 2
            ), style = "color: #65D36E;"),
            "hours"),
            column(4, h4(round(
              P_listening_time / (24 * 60), 2
            ), style = "color: #65D36E;"),
            "days")
          ),
          
          h3("Streaming Numbers", style = "color: #65D36E;"),
          fluidRow(
            column(4, h4(P_plays_number, style = "color: #65D36E;"),
                   "plays"),
            column(
              4,
              h4(P_artists_number, style = "color: #65D36E;"),
              "different artists"
            ),
            column(
              4,
              h4(P_tracks_number, style = "color: #65D36E;"),
              "different songs"
            )
          ),
          
          h3("Top Artists", style = "color: #65D36E;"),
          fluidRow(
            column(4, align = "center",
                   htmlOutput("P_top_artists_img1"),
                   P_top_artists[1]),
            column(4, align = "center",
                   htmlOutput("P_top_artists_img2"),
                   P_top_artists[2]),
            column(4, align = "center",
                   htmlOutput("P_top_artists_img3"),
                   P_top_artists[3])
          ),
          
          h3("Top Albums", style = "color: #65D36E;"),
          fluidRow(
            column(
              4,
              align = "center",
              htmlOutput("P_top_albums_img1"),
              P_top_albums[[1]][2],
              br(),
              "by",
              P_top_albums[[1]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("P_top_albums_img2"),
              P_top_albums[[2]][2],
              br(),
              "by",
              P_top_albums[[2]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("P_top_albums_img3"),
              P_top_albums[[3]][2],
              br(),
              "by",
              P_top_albums[[3]][1]
            )
          ),
          
          h3("Top Tracks", style = "color: #65D36E;"),
          fluidRow(
            column(
              4,
              align = "center",
              htmlOutput("P_top_tracks_img1"),
              P_top_tracks[[1]][2],
              br(),
              "by",
              P_top_tracks[[1]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("P_top_tracks_img2"),
              P_top_tracks[[2]][2],
              br(),
              "by",
              P_top_tracks[[2]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("P_top_tracks_img3"),
              P_top_tracks[[3]][2],
              br(),
              "by",
              P_top_tracks[[3]][1]
            )
          ),
          
          
        ),
        
        
        
        column(
          4,
          align = "center",
          style = 'border-left:1px solid #65D36E; padding: 10px;',
          h3("Listening time", style = "color: #65D36E;"),
          fluidRow(
            column(4, h4(round(M_listening_time), style = "color: #65D36E;"),
                   "minutes"),
            column(4, h4(round(
              M_listening_time / 60, 2
            ), style = "color: #65D36E;"),
            "hours"),
            column(4, h4(round(
              M_listening_time / (24 * 60), 2
            ), style = "color: #65D36E;"),
            "days")
          ),
          
          h3("Streaming Numbers", style = "color: #65D36E;"),
          fluidRow(
            column(4, h4(M_plays_number, style = "color: #65D36E;"),
                   "plays"),
            column(
              4,
              h4(M_artists_number, style = "color: #65D36E;"),
              "different artists"
            ),
            column(
              4,
              h4(M_tracks_number, style = "color: #65D36E;"),
              "different songs"
            )
          ),
          
          h3("Top Artists", style = "color: #65D36E;"),
          fluidRow(
            column(4, align = "center",
                   htmlOutput("M_top_artists_img1"),
                   M_top_artists[1]),
            column(4, align = "center",
                   htmlOutput("M_top_artists_img2"),
                   M_top_artists[2]),
            column(4, align = "center",
                   htmlOutput("M_top_artists_img3"),
                   M_top_artists[3])
          ),
          
          h3("Top Albums", style = "color: #65D36E;"),
          fluidRow(
            column(
              4,
              align = "center",
              htmlOutput("M_top_albums_img1"),
              M_top_albums[[1]][2],
              br(),
              "by",
              M_top_albums[[1]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("M_top_albums_img2"),
              M_top_albums[[2]][2],
              br(),
              "by",
              M_top_albums[[2]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("M_top_albums_img3"),
              M_top_albums[[3]][2],
              br(),
              "by",
              M_top_albums[[3]][1]
            )
          ),
          
          h3("Top Tracks", style = "color: #65D36E;"),
          fluidRow(
            column(
              4,
              align = "center",
              htmlOutput("M_top_tracks_img1"),
              M_top_tracks[[1]][2],
              br(),
              "by",
              M_top_tracks[[1]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("M_top_tracks_img2"),
              M_top_tracks[[2]][2],
              br(),
              "by",
              M_top_tracks[[2]][1]
            ),
            column(
              4,
              align = "center",
              htmlOutput("M_top_tracks_img3"),
              M_top_tracks[[3]][2],
              br(),
              "by",
              M_top_tracks[[3]][1]
            )
          ),
          
        ),
      ),
      br(),
      br(),
      
    fluidRow(
      column(4, align = "center", h1("Artur")),
      column(4, align = "center", h1("Paweł")),
      column(4, align = "center", h1("Mateusz"))
    ),
      
      
      h2("Audio features", align = "center", style = "color: #65D36E;"),
      fluidRow(
        column(6, align = "center",
               sidebarPanel(
                 awesomeRadio(
                   inputId = "plotType",
                   label = "Plot type",
                   choices = c(
                     "Values normalized by Spotify" = "spoti",
                     "Values normalized based on our streaming history" =
                       "our"
                   ),
                   status = "success"
                 ),
                 width = 12,
                 align = "left"
               )),
        column(
          6,
          sidebarPanel(
          "Distributions of most audio features are narrow. Moreover, our music preferences
                             are quite similar. Therefore, it is possible to display both averages based only on Spotify
                             data and averages normalized based on our streaming history (quantiles of the value of features of
                             our data merged).", width = "100%"), br()
        )
      ),
      br(),
      fluidRow(
        column(4, align = "center", plotlyOutput("Aradar")),
        column(4, align = "center",  plotlyOutput("Pradar")),
        column(4, align = "center",  plotlyOutput('Mradar'))
      ),
      fluidRow(column(
        12,
        align = "center",
        h2("Audio features", align = "center", style = "color: #65D36E;"),
        plotlyOutput("feature_densities_plot", width = "100%"),
        br()
      ))
    )
  ),
  
  tabPanel(
    "The Year in Review",
    fluidPage(
      h1("The Year in Review", align = "center", style = "color: #65D36E;"),
      fluidRow(column(
        12,
        align = "center",
        sidebarPanel(
          radioGroupButtons(
            inputId = "whoseData",
            label = "Show stats for ...",
            choices = c(
              "Artur" = "Adf",
              "Paweł" = "Pdf",
              "Mateusz" = "Mdf"
            ),
            size = "lg",
            status = "primary",
            individual = TRUE
          ),
          width = 6,
          align = "center"
        )
      )),
      
      fluidRow(
        column(
          4,
          h2("Streams calendar", align = "center", style = "color: #65D36E;"),
          supercaliheatmapwidgetOutput("streamedCalendar1", height = "210px"),
          supercaliheatmapwidgetOutput("streamedCalendar2", height = "210px"),
          supercaliheatmapwidgetOutput("streamedCalendar3", height = "210px"),
        ),
        column(
          8,
          h1("Feature in time", align = "center", style = "color: #65D36E;"),
          fluidRow(
            column(
            5,
            sidebarPanel(
              selectInput(
                inputId = "featureType",
                label = "Selected feature:",
                choices = c(
                  "Acousticness" = "acousticness",
                  "Danceability" = "danceability",
                  "Energy" = "energy",
                  "Instrumentalness" = "instrumentalness",
                  "Liveness" = "liveness",
                  "Valence" = "valence"
                ),
                selected = "energy"
              ),
              align = "center",
              width = "100%"
            )
          ),
          column(
            7,
            sidebarPanel(textOutput("featureDescription"), width = '100%')
          )),
          br(),
          br(),
          tags$style(make_css(list('.dygraph-legend', 
                                   c('left', 'background-color'), 
                                   c('70px !important', 'transparent !important')))),
          dygraphOutput('featureInTime')
          
        )
      ),
      
      h2("Most-streamed", align = "center", style = "color: #65D36E;"),
      fluidRow(
        column(
          4,
          align = "center",
          sidebarPanel(
            awesomeRadio(
              inputId = "dataType",
              label = "Show most-streamed ...",
              choices = c(
                "artists" = "artistName",
                "albums" = "albumName",
                "songs" = "trackName",
                "genres" = "genres"
              ),
              selected = "artistName",
              status = "success"
            ),
            hr(),
            sliderInput(
              "freqWords",
              "Minimum frequency:",
              min = 1,
              max = 100,
              value = 10
            ),
            "It is a number of streamed songs from an artist, a number of streams for a song
                                                  or a number of artists associated with a genre.",
            br(),
            hr(),
            sliderInput(
              "maxWords",
              "Maximum number of words:",
              min = 1,
              max = 100,
              value = 50
            ),
            "It is a number of words included in word cloud.",
            width = 12
          )
        ),
        
        
        column(8, align = "center",
               wordcloud2Output("cloud", height = "600px"))
      ),
      
      
      
      
      #to może być obok czegoś w jednym wierszu
      h2(
        "Most-streamed tracks by an artist",
        align = "center",
        style = "color: #65D36E;"
      ),
      
      fluidRow(
        column(4,),
        column(4, align = "center",
               sidebarPanel(
                 selectInput("artist",
                             "Artist:",
                             "Loading top artists..."),
                 width = 10
               )),
        column(4, )
      ),
      fluidRow(column(
        12,
        align = "center",
        plotlyOutput("mostStreamedBarplot", width = "60%"),
        br()
      ),),
    )
  ),
  tabPanel("FB Network",
           fluidPage(
             h2("Facebook Friends Network", align = "center", style = "color: #65D36E;"),
             fluidRow(
               column(
                 6,
                 align = "center",
                 sidebarPanel(
                   radioGroupButtons(
                     inputId = "whoseNetwork",
                     label = "Show stats for ...",
                     choices = c(
                       "Artur" = "Artur",
                       "Paweł" = "Pawel",
                       "Mateusz" = "Mateusz"
                     ),
                     size = "lg",
                     status = "primary",
                     individual = TRUE
                   ),
                   width = 12,
                   align = "center"
                 )
               ),
               column(
                 6,
                 "Small bonus. Here are our networks of our friends on Facebook.
                               Each node represents one of our friends. Friends are connected if they know each other.
                               More connected people are situated closer to each other. That forms nicely clouds which represent cricles of friends.
                               Each cloud was coloured to be distinguished easier. Note how visible are schoolmates who went to the next school alongside us.
                               ",
                 style = "text-align: justify;"
               )
             ),
             fluidRow(column(
               12, align = "center",
               #svgPanZoomOutput(outputId = "fb_image"),
               imageOutput("fb_image_2", width = "80%")
             ))
           )),
  tabPanel("About", 
           fluidPage(
             h1(
               "About this project",
               align = "center",
               style = "color: #65D36E;"
             ),
             fluidRow(
               column(
                 6, 
                 h2("Authors", align = "center", style = "color: #65D36E;"),
                 fluidRow(
                   column(4,
                          a(img(src="https://media-exp1.licdn.com/dms/image/C4E03AQHOKGqGWDUYWA/profile-displayphoto-shrink_800_800/0/1605393012623?e=1616025600&v=beta&t=S_Vv8Lmb0Onxdubf7mckJnQiQyMG9-lSnRTVNMSFhSk", 
                                width = "50%"), 
                            href="https://open.spotify.com/user/11182309188?si=tgbiSIsmTNW-zF5sNDdfcw"),
                          h5("Artur Żółkowski", align = "center")
                          ),
                   column(4, 
                          a(img(src="https://scontent-frt3-2.xx.fbcdn.net/v/t1.0-9/116570723_2997535790345236_4030782794165897827_n.jpg?_nc_cat=101&ccb=2&_nc_sid=09cbfe&_nc_ohc=IA4PenhSHskAX-waBLM&_nc_ht=scontent-frt3-2.xx&oh=74655f06bfaf3b3808cee2178c50cad9&oe=60284568",
                                width = "50%"), 
                            href="https://open.spotify.com/user/pawel494?si=kwbicY8jQdyoQkC3uTXZAw"),
                          h5("Paweł Wojciechowski", align = "center")
                          ),
                   column(4, 
                          a(img(src="https://scontent-frx5-1.xx.fbcdn.net/v/t1.0-9/69910272_2978714532202881_2819709346231877632_n.jpg?_nc_cat=100&ccb=2&_nc_sid=09cbfe&_nc_ohc=Mjh1NL2CxMQAX9AGDQ7&_nc_ht=scontent-frx5-1.xx&oh=966d84409e22c813582fa6ba4c4fe656&oe=60281B7D",
                                width = "50%"), 
                            href="https://open.spotify.com/user/1173486597?si=q4b1tSxIRT2zCrTBt-y4Pg"),
                          h5("Mateusz Krzyziński", align = "center")
                   ),
                   align = "center"
                 ),
                 br(),
                 fluidRow(
                 column(1, " "),
                column(10, style="text-align: justify;",
                 "We are Data Science students at Warsaw Univeristy of Technology. Music is something that fills our student life. 
                 Actually, it is an integral part of our lives. Every year we look forward to Spotify Wrapped to see our top songs and the most listened artists of the year. 
                 We guess you know that feeling too...",
                 "In our project, we went one step further. We have analyzed our data in more detail. It was extremely interesting for us. 
                 We hope you have found something interesting here too (technically or musically).
                 If you want to find us on Spotify click on the pictures."
                ),
                column(1, " ")
                )
               ),
               column(
                 6, 
                 h2("App and data", align = "center", style = "color: #65D36E;"),
                 fluidRow(
                 column(1, " "),
                 column(10, style="text-align: justify;",
                 "This Shiny App is our project for Data Visualization Techniques course at our studies. 
                 Our task was to create an interactive visualization - a dashboard (Personal Visuzalizaion).
                 We have decided to create the visualization of our streaming data from Spotify. For this purpose, we have requested for datasets from 2020 on Spotify.
                 When creating the dashboard, we have used also", a("Spotify Web API", href="https://developer.spotify.com/documentation/web-api/"), 
                 "which returns metadata about music artists, albums, and tracks, directly from the Spotify Data Catalogue."
                 ),
                 column(1, " ")
                 
                 )
               )
             
               
             )
           )
      )
  
)
