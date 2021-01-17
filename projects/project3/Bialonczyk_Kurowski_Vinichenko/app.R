source("load_libraries.R")
source("progress_bar.R")
source("read_data.R")


# ------------------------------------------- parts of ui -------------------------------------------------------------- #

############### header ################
header_plus <- dashboardHeaderPlus(
  title = "My Facebook data", fixed = FALSE,
  left_menu = tagList(
    dropdownBlock(id="mydropdown", title = "Select the user", badgeStatus = NULL,
                  selectInput(inputId = "user", label = "User name", choices = list("Ula" = 1, "Kacper" = 2, "Yevhenii" = 3), selected = 1))
  )
)

############## sidebar #################
sidebar <- dashboardSidebar(
  sidebarMenu(menuItem("My statistics", tabName = "statistics", icon = icon("bar-chart-o")),
              menuItem("My friends", tabName = "friends", icon = icon("users")),
              menuItem("My messages", tabName = "messages", icon = icon("envelope")),
              menuItem("Facebook about me", tabName = "about", icon = icon("user-circle")))
)


############### body ###################  

#--- z tym trzeba pokombinowac, zeyb zalezalo od uzytkownika
profile_box <- box(
  title = "User",
  status = "primary",
  width = 4,
  boxProfile(
    src = "https://image.flaticon.com/icons/svg/149/149076.svg",
    title = textOutput("user_name"),
    subtitle = "Politechnika Warszawska",
    boxProfileItemList(
      bordered = TRUE,
      boxProfileItem(
        title = "Followers",
        description = textOutput("followers")
      ),
      boxProfileItem(
        title = "Following",
        description = textOutput("following")
      ),
      boxProfileItem(
        title = "Friends",
        description = textOutput("friends")
      )
    )
  )
)





frow1 <- fluidRow(
  profile_box,
  valueBoxOutput("value5"),
  valueBoxOutput("value1"),
  valueBoxOutput("value3"),
  valueBoxOutput("value2"),
  valueBoxOutput("value4"),
  valueBoxOutput("value6")
)


grow1 <- fluidRow(
  box(
    width = 4,
    status = "info",
    title = "Top friends",
    tags$div(
      class = "scroll-overflow-x",
      withSpinner(uiOutput("top_friends")),
      helpText("Friends the user's had most contact with.")
    )
  ),
  box(
    width = 4,
    status = "danger",
    title = "Top groups",
    withSpinner(uiOutput("top_groups")),
    helpText("Groups the user's had most interactions with.")
  ),
  box(
    width = 4,
    status = "warning",
    title = "Top commented groups",
    withSpinner(uiOutput("top_comments")),
    helpText("Users/groups where the user wrote most comments.")
  )
  
)

grow2 <- fluidRow(column(12, align='center', plotlyOutput("plotly_1")))

hrow1 <- fluidRow(valueBoxOutput("moje", width = 6),
                  valueBoxOutput("nie_moje", width = 6))
hrow2 <- fluidRow(
  column(8, align='center',wordcloud2Output("word_cloud"),sliderInput("slider1", label = "Choose word length range", min = 1, 
                                             max = 10, value = c(2, 7)))
  
)

irow1 <- fluidRow(
  dataTableOutput("interests_table")
)


body <- dashboardBody(
  
  tabItems(
    tabItem("statistics", frow1),
    tabItem("friends", grow1, grow2),
    tabItem("messages",h2("When were you texting the most?"),hrow1, h2("What are the most common words you use?"), hrow2),
    tabItem("about", h2("Check out what Facebook thinks you like"), irow1)
  )
  )

# ----------------------------------------- ui ------------------------------------------- # 
ui <- dashboardPage(header_plus, sidebar, body, skin='blue')


# ----------------------------------------- server ---------------------------------------- #
server <- function(input, output){
  
  output$value1 <- renderValueBox({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
   
    user_likes <- likes %>% filter(name == user1) 
    
    valueBox(
      nrow(user_likes)
      ,'Total number of likes'
      ,icon = icon("thumbs-up")
      ,color = "blue")
    
    
  })
  
  output$value2 <- renderValueBox({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    comments_user <- comments %>% filter(comment.author == user1)
    
    valueBox(
      nrow(comments_user)
      ,'Total number of comments'
      ,icon = icon("comment")
      ,color = "yellow")
    
  })
  
  output$value3 <- renderValueBox({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    messages_user <- messages %>% filter(name == user1)
    
    valueBox(
      nrow(messages_user)
      ,'Total number of messages'
      ,icon = icon("envelope")
      ,color = "yellow")
    
  })
  
  output$value4 <- renderValueBox({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    user_posts <- posts %>% filter(name == user1) 
    
    valueBox(
      nrow(user_posts)
      ,'Total number of posts'
      ,icon = icon("pen")
      ,color = "purple")
    
  })
  
  output$value5 <- renderValueBox({
    
    valueBox(
      as.IDate(as.POSIXct(1342180210, origin="1970-01-01")) #to do zmiany w zaleznosci od uzytkownika;mozna zrobic tabelke w read_data i filtrowac
      ,'Member since'
      ,icon = icon("user")
      ,color = "blue")
    
  })
  
  output$value6 <- renderValueBox({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    groups_user <- groups %>% filter(name==user1)
    
    valueBox(
      nrow(groups_user) 
      ,'Number of groups'
      ,icon = icon("users")
      ,color = "purple")
    
  })
  
  output$interests_table <- renderDataTable({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    interests_user <- interests %>% filter(name == user1)
    
    interests_user[sample(nrow(interests_user)), ]
  })
  
  output$top_friends <- renderUI({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    top_friends = messages %>% filter(name==user1) %>% count(id) %>% arrange(desc(n))
    top_friends$id <- as.character(top_friends$id)
    
    colors <- rep(rainbow(5), 2)
    
    tags$div(
      map(seq_len(min(10, nrow(top_friends))), ~ {
        progressGroup(top_friends$id[[.]], top_friends$n[[.]], max = max(top_friends$n), color = colors[.])
      })
    )
  })
  
  
  output$top_groups <- renderUI({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    groups_user2 <- groups %>% filter(name==user1)
    
    colors <- rep(rainbow(5), 2)
    
    tags$div(
      map(seq_len(min(10, nrow(groups))), ~ {
        progressGroup(as.character(groups_user2$group_name[[.]]), groups_user2$value[[.]], max = max(groups_user2$value), color = colors[.])
      })
    )
  })
  
  output$top_comments <- renderUI({
    
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    top_comments_user <- top_comments %>% filter(comment.author == user1) # do zmiany, przefiltrowac po uzytkowniku
    
    colors <- rep(rainbow(5), 2)
    
    tags$div(
      map(seq_len(min(10, nrow(top_comments_user))), ~ {
        progressGroup(as.character(top_comments_user$comment.group[[.]]), top_comments_user$n[[.]], max = max(top_comments_user$n), color = colors[.])
      })
    )
  })
  
  output$moje <- renderValueBox({
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    moje = messages %>% filter(name==user1 & sender=="Me") %>% count(date) %>% arrange(desc(n))
    
    valueBox(
      moje[1,1]
      ,paste('The day when the user sent ',moje[1,2],'messages')
      ,icon = icon("envelope")
      ,color = "purple")
    
  })
  output$nie_moje <- renderValueBox({
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    nie_moje = messages %>% filter(name==user1 & sender=="Not me") %>% count(date) %>% arrange(desc(n))
    
    valueBox(
      nie_moje[1,1]
      ,paste('The day when the user got ',nie_moje[1,2],'messages')
      ,icon = icon("envelope")
      ,color = "purple")
    
  })
  
  output$word_cloud <- renderWordcloud2({
    if (as.numeric(input$user) == 1){
      user <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user <- "Kacper"
    } else{
      user <- "Yevhenii"
    }
    
    df <- word_data %>%
      filter(sender == user) %>%
      select(word, freq) %>%
      filter(nchar(as.character(word)) >= input$slider1[1] & nchar(as.character(word)) <= input$slider1[2])
    
    
    wordcloud2(data = df, backgroundColor = "#1C00ff00")
    
  })
  
  output$plotly_1 <- renderPlotly({
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    df <- friends_data %>%
      filter(user == user1) %>%
      select(timestamp, new_friends)
    
    plot_ly(df, x = ~timestamp, 
            y = ~new_friends,
            type = 'scatter',
            mode = 'lines',
            hovertemplate = paste('date: %{x}', '<br>new friends: %{y}<br><extra></extra>')) %>%
      layout(plot_bgcolor  = "rgba(0, 0, 0, 0)",
             paper_bgcolor = "rgba(0, 0, 0, 0)",
             fig_bgcolor   = "rgba(0, 0, 0, 0)",
             xaxis = list(
               title = 'month'
             ),
             yaxis = list(
               title = 'new friends'
             ),
             title = 'New friends on a given month')
    
  })
  
  output$user_name <- renderText({
    if (as.numeric(input$user) == 1){
      user <- "Ula Bialonczyk"
    } else if(as.numeric(input$user) == 2){
      user <- "Kacper Kurowski"
    } else{
      user <- "Yevhenii Vinichenko"
    }
    user
  })
  
  output$followers <- renderText({
    if (as.numeric(input$user) == 1){
      followers <- "732"
    } else if(as.numeric(input$user) == 2){
      followers <- "341"
    } else{
      followers <- "10"
    }
    followers
  })
  
  output$following <- renderText({
    if (as.numeric(input$user) == 1){
      following <- "421"
    } else if(as.numeric(input$user) == 2){
      following <- "583"
    } else{
      following <- "12"
    }
    following
  })
  
  output$friends <- renderText({
    if (as.numeric(input$user) == 1){
      user1 <- "Ula"
    } else if(as.numeric(input$user) == 2){
      user1 <- "Kacper"
    } else{
      user1 <- "Yevhenii"
    }
    
    friends_data %>% filter(user == user1) %>%
      summarise(all_friends = sum(new_friends)) -> data
    
    data["all_friends"][[1]]
    
    
  })
  
  
}

shinyApp(ui, server)
