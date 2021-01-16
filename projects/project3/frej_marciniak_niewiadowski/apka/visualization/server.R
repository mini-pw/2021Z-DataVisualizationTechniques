library(shiny)
library(dplyr)
library(tidyverse)
library(plotly)
library(chron)
library(ggimage)
library(sp)

shinyServer(function(input, output) {
    data <- read_csv2("data.csv")
    person_color <- c("Adam" = "#E69F00", "Pawel" = "#009E73", "Piotr" = "#56B4E9")
    
    filtered_data <- reactive({
        data %>% 
            filter(between(date, input$DatesMerge[1], input$DatesMerge[2])) %>%
            mutate(duration = 60*hours(times(time)) + minutes(times(time)) + 1/60*seconds(times(time)))
    })
    
    output$application <- renderPlotly({
        if (is.null(input$nameButton)) return(NULL)
      order <-filtered_data() %>%
        filter(name %in% input$nameButton) %>%
        group_by(title) %>%
        summarise(sum_duration = sum(duration)) %>%
        arrange(desc(sum_duration)) %>%
        ungroup() %>%
        head(10)
      
        filtered_data() %>%
            filter(name %in%  input$nameButton) %>%
          filter(title %in% order$title) %>%
          group_by(title, name) %>%
          summarise(sum_duration = sum(duration)) %>%
            plot_ly(y = ~title, x = ~sum_duration/60, type = "bar", color = ~name, 
                    colors = person_color,
                    orientation = 'h', source = "application") %>%
                layout(title = list(text = "Applications usage:            Click the bars!"), 
                       xaxis = list(title = "Time in hours"),
                       yaxis = list(title = list(text = "Application", standoff = 0), 
                                    categoryorder = "array",
                                    categoryarray = rev(order$title)),
                       margin = list(l=250), 
                       barmode = 'stack',
                       showlegend = TRUE,
                       legend = list(x = 0.8, y = 0))
        })
    
    application <- reactiveVal("chrome")
    
    observeEvent(event_data("plotly_click", source = "application"), {
        application(event_data("plotly_click", source = "application")$y)
    })
    
    output$plot_clicks <- renderPlotly({
        if (is.null(application())) return(NULL)
        if (is.null(input$nameButton)) return(NULL)
        d <- filtered_data() %>%
            filter(name %in% input$nameButton) %>%
            filter(title == application()) %>%
            replace_na(list(keys = 0, lmb = 0, rmb = 0, scrollwheel=0)) %>%
            group_by(date, title) %>%
            summarise(keys = sum(keys), lmb = sum(lmb), rmb = sum(rmb), scrollwheel = sum(scrollwheel)) %>%
            ungroup()%>%
            arrange(date)
          
        color <-  c("Keys" = "#003f5c",
                    "LMB" = "#7a5195",
                    "RMB" = "#ef5675",
                    "Scroll" = "#ffa600")
        
        if (filtr_keys() != "all")
          color <- ifelse(names(color) == filtr_keys(), color, "gray")
        
        if(nrow(d)>1)
            plot_ly(d, x = ~date, colors = color) %>%
                add_trace(y = ~keys, type = "scatter", mode = "markers+lines", color = "Keys") %>%
                add_trace(y = ~lmb, type = "scatter", mode = "markers+lines", color = "LMB") %>%
                add_trace(y = ~rmb, type = "scatter", mode = "markers+lines", color = "RMB") %>%
                add_trace(y = ~scrollwheel, type = "scatter", mode = "markers+lines", color = "Scroll") %>%
                layout(title = list(text = paste0("Clicks in: \"", application(), "\" over time")), 
                       xaxis = list(title = "Date", type = "date", tickformat = "%d/%m<br>(%a)"),
                       yaxis = list(title = "Number of clicks"))
        else if(nrow(d) == 1)
            plot_ly() %>%
            add_bars(
                x = c("keys","lmb","rmb","scrollwheel"),
                y = c(d$keys, d$lmb, d$rmb, d$scrollwheel),
                base = 0,
                marker = list(
                    color = c('blue','red','green','yellow')
                )) %>%
            layout(title = list(text = paste0("Clicks in: \"", application(), "\"")), yaxis = list(title = "Number of clicks"))
        else
            return(NULL)
    })
    
    output$app_activity <- renderPlotly({
        if (is.null(application())) return(NULL)
        if (is.null(input$nameButton)) return(NULL)
        d <- filtered_data() %>%
            filter(name %in% input$nameButton) %>%
            filter(title == application()) %>%
            mutate(duration = duration/60) %>%
            arrange(date)
    
    plot_ly(d, x = ~date, y = ~duration, type = 'bar', color = ~name, 
            colors = person_color) %>% 
        layout(title = list(text = paste0("Activity in: \"", application(), "\" over time")), 
               xaxis = list(title = "Date", type = "date", tickformat = "%d/%m<br>(%a)"),
               yaxis = list(title = "Time in hours", type = "hours"), 
               barmode = 'stack',
               showlegend = TRUE)
    })
    
    filtr_keys <- reactiveVal("all")
    
    observeEvent(input$mouse_click, {
        mwheel <- data.frame(x = c(65.95, 84.95, 84.95, 65.95), 
                                y = c(84.60001, 84.60001, 140.6, 140.6))
        lmb <- data.frame(x = c(69.95, 38.95, 28.95, 10.95, 5.949997,
                                   9.949997, 72.95, 72.95, 64.95, 58.95,
                                   60.95, 72.95, 72.95, 69.95), 
                             y = c(69.60001, 76.60001, 83.60001, 109.6,125.6,
                                   153.6, 155.6, 146.6, 143.6, 132.6,
                                   84.60001, 76.60001, 66.60001, 69.60001))
        rmb <- data.frame(x = c(78.95, 97.95, 120.95, 133.95,141.95,
                                   142.95, 141.95, 77.95, 78.95, 89.95,91.95,
                                   89.95, 77.95, 77.95, 78.95), 
                             y = c(68.60001, 70.60001, 82.60001, 98.60001,117.6,
                                   122.6,156.6, 156.6, 147.6, 138.6,129.6,
                                   88.6,76.6, 66.6, 68.60001))
        if(point.in.polygon(input$mouse_click$x, input$mouse_click$y, mwheel$x, mwheel$y) == 1)
          ifelse(filtr_keys() == "Scroll", filtr_keys("all"), filtr_keys("Scroll"))
        else if (point.in.polygon(input$mouse_click$x, input$mouse_click$y, lmb$x, lmb$y) == 1)
          ifelse(filtr_keys() == "LMB", filtr_keys("all"), filtr_keys("LMB"))
        else if (point.in.polygon(input$mouse_click$x, input$mouse_click$y, rmb$x, rmb$y) == 1)
          ifelse(filtr_keys() == "RMB", filtr_keys("all"), filtr_keys("RMB"))
    })
    
    observeEvent(input$key_click, {
      if (!is.null(input$key_click))
        ifelse(filtr_keys() == "Keys", filtr_keys("all"), filtr_keys("Keys"))
    })
    
    output$mouse <- renderImage({
            return(list(
                src = "../img/mouse.png",
                filetype = "image/png",
                alt = "Mouse"
            ))
        
    }, deleteFile = FALSE)
    output$key <- renderImage({
        return(list(
            src = "../img/key.png",
            filetype = "image/png",
            alt = "Key"
        ))
        
    }, deleteFile = FALSE)
})
