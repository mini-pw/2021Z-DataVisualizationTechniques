library(shiny)
library(shinythemes)
library(readr)
library(ggplot2)
library(dplyr)
library(stringr)
library(patchwork)
library(ggthemes)
library(tidyverse)
library(rvest)
# devtools::install_github("clauswilke/ggtext")
library(ggtext)
# devtools::install_github("hadley/emo")
library(emo)


library(dygraphs)
library(datasets)
library(zoo)
library(xts)
library(dplyr)
library(gridExtra)
library(plotly)

source("R_plots/data_messages_over_years.R")
source("R_plots/prepare_data.R")




ui <- fluidPage(theme = shinytheme("slate"),
                titlePanel("My Facebook Data"),
                sidebarLayout(
                  sidebarPanel(
                    
                    # checkboxGroupInput(inputId = "persons",
                    #                    label = "hehe",
                    #                    choices =  c("Kuba K.", "Kuba L.", "Bartek S.")),
                    
                    tags$div(
                      HTML(
                        '<div id="persons" class="form-group shiny-input-checkboxgroup shiny-input-container shiny-bound-input">
        <label class="control-label" for="persons">Choose people</label>
          <div class="shiny-options-group">
            <div class="checkbox">
            <label>
              
              <input type="checkbox" name="persons" value="Kuba K.">
              <div style="width:128px;height:128px;border:4px solid #F2133C;background:#F2133C">
              <span><img src="https://scontent-waw1-1.xx.fbcdn.net/v/t1.30497-1/c29.0.100.100a/p100x100/84241059_189132118950875_4138507100605120512_n.jpg?_nc_cat=1&ccb=2&_nc_sid=7206a8&_nc_ohc=ZUBgBA4cH8QAX9IyWEj&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent-waw1-1.xx&tp=27&oh=502ad4ebf86d02d6adcfa22dccd701d7&oe=601F529E" height = "120"/></span>
              </label>
              </div>
            </div>
            <div class="checkbox">
              <label>
              <input type="checkbox" name="persons" value="Kuba L.">
              <div style="width:128px;height:128px;border:4px solid #5741A6;background:#5741A6">
              <span><img src="https://scontent-waw1-1.xx.fbcdn.net/v/t1.0-1/p100x100/122856167_1760056047475701_3097338334731053317_o.jpg?_nc_cat=108&ccb=2&_nc_sid=7206a8&_nc_ohc=BN2tqo9jmG0AX8FfTPI&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent-waw1-1.xx&tp=6&oh=1d4df0ff84a0b36b581b57fcd600968f&oe=601EC427" height = "120"></span>
              </label>
              </div>
            </div>
            <div class="checkbox">
              <label>
              <input type="checkbox" name="persons" value="Bartek S.">
              <div style="width:128px;height:128px;border:4px solid #F2BD1D;background:#F2BD1D">
              <span><img src="https://scontent.fktw4-1.fna.fbcdn.net/v/t1.0-1/c83.50.576.576a/s100x100/1526556_254831838188045_5566807436520804551_n.jpg?_nc_cat=100&ccb=2&_nc_sid=7206a8&_nc_ohc=96FyKJ2bBDEAX9TUYug&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.fktw4-1.fna&tp=28&oh=1babfa68d12441d29aafe93a7253c1c5&oe=60291148" height = "120"></span>
              </label>
              </div>  
            </div>
          </div>
        </div>
        '
                      )
                    )
                    ,width = 2),
                  
                  mainPanel(tabsetPanel(
                    tabPanel(
        "Data over time",
        br(),
        mainPanel(
          dygraphOutput("dygraph", width = "150%"),
          br(),
          radioButtons(
            "rollingAverage",
            "Rolling average",
            choices = c(
              "No rolling average",
              "Apply 15-days rolling average",
              "Apply 30-days rolling average",
              "Apply 60-days rolling average"
            ),
            selected = "No rolling average",
            inline = TRUE
          ),
          br(),
          actionButton("do", "Generate boxplots"),
          br(),
          br(),
          uiOutput(outputId = "boxplotsUI", width = "150%")
          
          
        )
                    ),
                    tabPanel("The most used emojis", br(),
                             dateRangeInput(
                               inputId = "dateRange",
                               label = "Date range",
                               start = Sys.Date() - 365,
                               end = Sys.Date(),
                               format = "dd-mm-yyyy",
                               weekstart = 1
                             ),
                             actionButton("emojiButton", "Submit"),
                             br(), br(),
                             uiOutput("emojiPlot"),
                             br(),
                             verbatimTextOutput("textKubaK"),
                             dataTableOutput("emojiKubaK"),
                             br(),
                             verbatimTextOutput("textKubaL"),
                             dataTableOutput("emojiKubaL"),
                             br(),
                             verbatimTextOutput("textBartekS"),
                             dataTableOutput("emojiBartekS")),
                    tabPanel(
                      "Activity time",
                      br(),
                      dateRangeInput(
                        inputId = "dateRangeActivity",
                        label = "Date range",
                        start = Sys.Date() - 365,
                        end = Sys.Date(),
                        format = "dd-mm-yyyy",
                        weekstart = 1
                      ),
                      selectInput(
                        inputId = "dayOfWeek",
                        label = "Day of the week",
                        choices = c(
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                          "Friday",
                          "Saturday",
                          "Sunday",
                          "all"
                        )
                      ),
                      br(),
                      uiOutput("activityPlot"),
                    )
                  ),
                  width = 10)
                ))

server <- function(input, output, session) {
  
  ### Tab 2
  
  observeEvent(input$emojiButton, {
    ppl <- isolate(input$persons)
    output$emojiPlot <- renderUI({
      if (length(ppl) > 0) {
        plotOutput("emojiPlot2")
      } else { verbatimTextOutput("emojiText2") }
      })
    output$emojiPlot2 <- renderPlot({
      plot_emoji(isolate(input$dateRange[1]),
                 isolate(input$dateRange[2]), ppl)
    })
    output$emojiText2 <- renderText("No one was selected")
    if ("Kuba K." %in% ppl) {
      output$textKubaK <- renderText("Kuba K.")
      output$emojiKubaK <- renderDataTable(
        prepare_data_table(isolate(input$dateRange[1]),
                           isolate(input$dateRange[2]), "Kuba K."),
        options = list(pageLength = 5),
        escape = FALSE)
    } else {
      output$emojiKubaK <- NULL
      output$textKubaK <- NULL
    }
    if ("Kuba L." %in% ppl) {
      output$textKubaL <- renderText("Kuba L.")
      output$emojiKubaL <- renderDataTable(
        prepare_data_table(isolate(input$dateRange[1]),
                           isolate(input$dateRange[2]), "Kuba L."),
        options = list(pageLength = 5),
        escape = FALSE)
    } else {
      output$emojiKubaL <- NULL
      output$textKubaL <- NULL
    }
    if ("Bartek S." %in% ppl) {
      output$textBartekS <- renderText("Bartek S.")
      output$emojiBartekS <- renderDataTable(
        prepare_data_table(isolate(input$dateRange[1]),
                           isolate(input$dateRange[2]), "Bartek S."),
        options = list(pageLength = 5),
        escape = FALSE)
    } else {
      output$emojiBartekS <- NULL
      output$textBartekS <- NULL
    }
  })
  
  
  ### Tab 3

  output$activityPlot <- renderUI({
    if (length(input$persons) > 0) {
      plotOutput("activityPlot2")
    } else { verbatimTextOutput("activityText") }
  })
  output$activityPlot2 <- renderPlot({

    plot_activity_time(input$dateRangeActivity[1],
                       input$dateRangeActivity[2],
                       input$persons,
                       input$dayOfWeek)
  })
  output$activityText <- renderText("No one was selected")
  

  
  
  ############ Tab 1 functionality
  
    
  output$dygraph <- renderDygraph({
    if (input$rollingAverage == "No rolling average") {
      fig <-
        dygraph(total_xts,  ylab = "Number of sent messages in each day")
      
    } else if (input$rollingAverage == "Apply 15-days rolling average") {
      fig <-
        dygraph(total_xts_rolling_small, ylab = "Number of sent messages in each day")
      
    } else if (input$rollingAverage == "Apply 30-days rolling average") {
      fig <-
        dygraph(total_xts_rolling_mid, ylab = "Number of sent messages in each day")
      
    } else  {
      fig <-
        dygraph(total_xts_rolling_big, ylab = "Number of sent messages in each day")
      
    }
    
    
    fig <- fig %>% dyRangeSelector() %>%
      dyShading(from = min(index(total_xts)),
                to = max(index(total_xts)),
                color = "#fdf6e3") %>%
      dyAxis(name = "x", axisLabelColor = "white") %>%
      dyAxis(name = "y", axisLabelColor = "white") %>%
      dySeries("Koziel", color = '#F2133C') %>%
      dySeries("Lis", color = '#5741A6') %>%
      dySeries("Sawicki", color = '#F2BD1D')
    
    
    if (!"Kuba K." %in% input$persons) {
      fig <-
        fig %>% dySeries("Koziel", color = '#F2133C', strokeWidth = 0)
    } else {
      fig <- fig %>% dySeries("Koziel", color = '#F2133C')
    }
    
    if (!"Kuba L." %in% input$persons) {
      fig <- fig %>% dySeries("Lis", color = '#5741A6', strokeWidth = 0)
    } else {
      fig <- fig %>% dySeries("Lis", color = '#5741A6')
    }
    
    if (!"Bartek S." %in% input$persons) {
      fig <-
        fig %>% dySeries("Sawicki", color = '#F2BD1D', strokeWidth = 0)
    } else {
      fig <- fig %>% dySeries("Sawicki", color = '#F2BD1D')
    }
    
    fig
    
    
    
    
    
    
  })
  
  
  
  data_box <- eventReactive(input$do, {
    date_start <-
      strftime(req(input$dygraph_date_window[[1]]), "%Y-%m-%d")
    date_end <-
      strftime(req(input$dygraph_date_window[[2]]), "%Y-%m-%d")
    
    
    out <- list()
    
    
    out$Koziel <-
      mess_Koziel %>% filter(date > as.Date(date_start) &
                               date < as.Date(date_end))
    out$Lis <-
      mess_Lis %>% filter(date > as.Date(date_start) &
                            date < as.Date(date_end))
    out$Sawicki <-
      mess_Sawicki %>% filter(date > as.Date(date_start) &
                                date < as.Date(date_end))
    
    return(out)
    
    
  })
  
  
  
  
  box_Koziel <- reactive({
    if (!"Kuba K." %in% input$persons)
      return(NULL)
    ggplot(data_box()$Koziel, aes(x = day_of_the_week, y = length)) + geom_boxplot(fill = '#F2133C',
                                                                                   color = '#F2133C',
                                                                                   alpha = 0.2) + scale_y_log10(limits = c(NA, y_max)) +
      theme_minimal() +
      theme_solarized() + ylab("message length") + xlab("") +
      theme(
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 20),
        legend.text = element_text(size = 15),
        legend.title = element_text(size = 18)
      )
  })
  box_Lis <- reactive({
    if (!"Kuba L." %in% input$persons)
      return(NULL)
    ggplot(data_box()$Lis , aes(x = day_of_the_week, y = length)) + geom_boxplot(fill = '#5741A6',
                                                                                 color = '#5741A6',
                                                                                 alpha = 0.2) + scale_y_log10(limits = c(NA, y_max)) +
      theme_minimal() +
      theme_solarized() + ylab("message length") + xlab("") +
      theme(
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 20),
        legend.text = element_text(size = 15),
        legend.title = element_text(size = 18)
      )
  })
  box_Sawicki <- reactive({
    if (!"Bartek S." %in% input$persons)
      return(NULL)
    ggplot(data_box()$Sawicki, aes(x = day_of_the_week, y = length)) +
      geom_boxplot(fill = '#F2BD1D',
                   color = '#F2BD1D',
                   alpha = 0.2) + scale_y_log10(limits = c(NA, y_max))  +
      theme_minimal() +
      theme_solarized() + ylab("message length") + xlab("") +
      theme(
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 20),
        legend.text = element_text(size = 15),
        legend.title = element_text(size = 18)
      )
  })
  
  
  output$boxplotsUI <- renderUI({
    if (length(input$persons) > 0) {
      plotOutput("boxplots", width = "150%")
    } else{
      verbatimTextOutput("boxplotsNoSelection")
    }
  })
  
  
  
  output$boxplotsNoSelection <- renderText("No one was selected")
  
  
  output$boxplots <- renderPlot({
    ptlist <- list(box_Koziel(), box_Lis(), box_Sawicki())
    
    
    
    to_delete <- !sapply(ptlist, is.null)
    ptlist <- ptlist[to_delete]
    
    if (length(ptlist) == 0)
      return(NULL)
    
    labs <- c("Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat.", "Sun.")
    
    if (length(ptlist) == 3) {
      ptlist[[1]] <- ptlist[[1]] + scale_x_discrete(labels  = labs)
      ptlist[[2]] <- ptlist[[2]] + scale_x_discrete(labels  = labs)
      ptlist[[3]] <- ptlist[[3]] + scale_x_discrete(labels  = labs)
    }
    
    
    grid.arrange(grobs = ptlist, ncol = length(ptlist))
  })
  
  ############ End of tab 1 functionality
  
  
}

shinyApp(ui, server)
