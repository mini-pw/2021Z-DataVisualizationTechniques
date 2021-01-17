library(shinydashboard)
library(shiny)
library(ggplot2)
library(ggiraph)
source("read_and_convert/read_data.R", encoding = "UTF-8")

function(input, output, session) {
  
  slider_color <- reactive({
    dates <- input$date
    names <- input$plot1_selected
    
    x <- df %>% filter(update_time <= dates[2],
                       update_time >=dates[1],
                       name %in% names) %>%
      select(przebiegniete) %>%
      pull
    
    
    n <- length(x)
    
    przebiegniete_dni<- sum(x)
    nie_przebiegniete_dni <- length(x[x==0])
    
    possible_results <- seq(-n, n, by=2)
    
    result <- przebiegniete_dni - nie_przebiegniete_dni
    
    index <- which(possible_results == result)
    
    palette <- colorfunc(n+1)
    
    correct_color <- palette[index]
    
    correct_color
  })
  
  slider_color_from_to <- reactive({ names <- c("Adrian", "Ada","Karol")
    dates <- input$date
    names <- input$plot1_selected
    x <- df %>% filter(update_time %in% dates,
                       name %in% names)
    x_from <- x %>% filter(update_time == dates[1]) %>%
      select(przebiegniete) %>%
      pull
    x_to <- x %>% filter(update_time == dates[2]) %>%
      select(przebiegniete) %>%
      pull
    
    n <- length(names)
    
    colors_return <- NULL
    
    przebiegniete <- sum(x_from) + 1
    
    colors_return[1] <- colorfunc(n+1)[przebiegniete]
    
    przebiegniete <- sum(x_to) + 1
    
    colors_return[2] <- colorfunc(n+1)[przebiegniete]
    
    colors_return
  })
  
  output$slider_middle <- renderUI({
    tags$style(HTML(paste0(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-
               edge, .js-irs-0 .irs-bar {background: ", slider_color() ,"}")))
  })
  

  output$slider_from_to <- renderUI({
    correct_colors <- slider_color_from_to()
    tags$style(type = "text/css",
               HTML(paste0(".irs-slider.from {background: ",
                           correct_colors[1],"; }"),# width: 8px; height: 20px; top: 20px; - zmiana kolka na kreske 
                    paste0(".irs-slider.to {background: ",
                           correct_colors[2],"; }")))
  })
  
  
  output$dayofweek <- renderGirafe({
    if (input$type == "dayofweek") {
      dates <- input$date
      ggplot(data_weekdays %>%
               filter(label %in% unique(df %>%
                                          filter(update_time >= dates[1],
                                                 update_time <= dates[2]) %>%
                                          select(dayofweek) %>%
                                          pull)),
             aes(x=x,y=y,label = label)) +
        geom_text_interactive(size = 16, aes(data_id = label)) +
        scale_y_continuous(limits = c(-1, 22)) +
        scale_x_continuous(limits = c(-17, 19)) + 
        theme_void() + 
        theme(panel.background = element_rect(fill = background_color, colour = background_color),
              plot.background = element_rect(fill = background_color),
              panel.grid.major = element_line(colour = background_color),
              axis.title = element_blank(),
              axis.ticks = element_blank(),
              axis.text = element_blank(),
              legend.title = element_blank()) -> p
      
      girafe(ggobj = p,
             options = list(
               opts_hover(css = girafe_css(
                 css = "stroke:none;",
                 text = "stroke:none;fill:red"
               )),
               opts_selection(css = girafe_css(
                 css = "stroke:none;",
                 text = "stroke:none;fill:red"
               ),
               only_shiny = F),
               opts_toolbar(position = 'bottomright', saveaspng = F)
             )
      ) -> x
      
      print(x)
    } else if (input$type == "update_time") {
      
      dates <- input$date
      
      ggplot(datespositions %>%
               filter(update_time >= dates[1],
                      update_time <= dates[2]),
             aes(x,y,label = format(update_time, "%d-%m-%y"))) + 
        geom_text_interactive(aes(data_id = update_time), size = 9) + 
        theme_void() +
        scale_x_continuous(limits = c(-2, 4)) +
        scale_y_continuous(limits = c(-1, 12)) + 
        theme(panel.background = element_rect(fill = background_color, colour = background_color),
              plot.background = element_rect(fill = background_color),
              panel.grid.major = element_line(colour = background_color),
              axis.title = element_blank(),
              axis.ticks = element_blank(),
              axis.text = element_blank(),
              legend.title = element_blank()) -> p
      
      girafe(ggobj = p,
             options = list(
               opts_hover(css = girafe_css(
                 css = "stroke:none;",
                 text = "stroke:none;fill:red"
               )),
               opts_selection(css = girafe_css(
                 css = "stroke:none;",
                 text = "stroke:none;fill:red"
               ),
               only_shiny = F),
               opts_toolbar(position = 'bottomright', saveaspng = F)
             )
      ) -> x
      
      print(x)
      
    }
    
  })
  
  output$legend <- renderGirafe({
    ggplot(legend_data, aes(x=x, y=y, data_id = przebiegniete)) + 
      geom_point_interactive(aes(shape = as.factor(shape)), size = 10, color = "red") + 
      geom_text_interactive(aes(x = x+1, y = y, label = shape), size = 7) +
      scale_x_continuous(limits = c(-0.2,3)) +
      scale_y_continuous(limits = c(-10,18)) +
      theme_void() +
      geom_text(aes(x=1.2, y=9, label = "Bieganie:"), size = 10) +
      guides(shape = 'none') + 
      scale_shape_manual(
        values = c(16,15)
      ) +
      theme(panel.background = element_rect(fill = background_color, colour = background_color),
            plot.background = element_rect(fill = background_color),
            panel.grid.major = element_line(colour = background_color),
            axis.title = element_blank(),
            axis.ticks = element_blank(),
            axis.text = element_blank(),
            legend.title = element_blank()) -> p
    
    x <- girafe(ggobj = p, width_svg = 2, height_svg = 6,
                options = list(
                  opts_hover_inv(css = "opacity:0.4;"),
                  opts_hover(girafe_css("stroke:red",
                                        text="stroke:none;fill:red")),
                  opts_selection(css = girafe_css(
                    css = "stroke:fill;",
                    text = "stroke:none;fill:red"
                  ),
                  type = "single",
                  only_shiny = F),
                  opts_toolbar(saveaspng = F)
                  )
    )
    
    
    print(x)
  })
  
  
  output$plot1 <- renderGirafe({
    p <- ggplot() +
      geom_polygon_interactive(data = prostokaty %>% filter(name %in% rv$plot1_cache),
                               aes(x,y, fill=name,
                                   data_id = name,
                                   tooltip = name), alpha = 1) +
      geom_polygon_interactive(data = prostokaty %>% filter(!name %in% rv$plot1_cache),
                               aes(x,y, fill=name,
                                   data_id = name,
                                   tooltip = name), alpha = 0.1) +
      geom_point(data=people, aes(x,y)) +
      geom_point(data=mouth %>% 
                   filter(happy == name %in% rv$plot1_cache),
                 aes(x,y)) +
      geom_polygon(data=skirt,aes(x,y)) +
      geom_text_interactive(data = people %>% filter(name == "Adrian"),
                            aes(x = 1, y = 15, color = name,
                                label = name, data_id = name,
                                tooltip = name),
                            size = 24) +
      geom_text_interactive(data = people %>% filter(name == "Ada"),
                            aes(x = 16, y = 15, color = name,
                                label = name, data_id = name,
                                tooltip = name),
                            size = 24) + 
      geom_text_interactive(data = people %>% filter(name == "Karol"),
                            aes(x = 31, y = 15, color = name,
                                label = name, data_id = name,
                                tooltip = name),
                            size = 24) + 
      scale_color_manual(values = color.names) + 
      scale_fill_manual(values = color.names) +
      theme_void() + 
      theme(panel.background = element_rect(fill = background_color, colour = background_color),
            plot.background = element_rect(fill = background_color),
            panel.grid.major = element_line(colour = background_color),
            axis.title = element_blank(),
            axis.ticks = element_blank(),
            axis.text = element_blank(),
            legend.title = element_blank()) + 
      guides(color="none", fill="none")

    
    
    girafe(ggobj = p, width_svg = 16, height_svg = 9,
           options = list(
             opts_tooltip(css = tooltip_css,
                          use_fill = TRUE),
             opts_hover(css = girafe_css(
               css = "stroke:none;",
               text = "stroke:none;"
             )),
             opts_selection(css = girafe_css(
                            css = "stroke:none;",
                            text = "stroke:none;"
                            ),
                            selected = rv$plot1_cache,
                            only_shiny = F), opts_toolbar(position = "bottomright")
           )
    ) -> x
    
    print(x)
    
  })
  
  observeEvent(c(input$plot1_selected, input$legend_selected), {
    
    legend <- input$legend_selected
    
    if (length(legend)==0) legend <- c(0,1)
    
    output$plot3 <- renderGirafe({
      dates <- input$date
      ggplot(df %>% filter(name %in% input$plot1_selected,
                           update_time <= dates[2],
                           update_time >= dates[1],
                           przebiegniete %in% legend),
             aes_string(x = 'step_count', y = 'jakosc_snu', colour = 'name',
                 data_id = input$type,
                 tooltip = paste0('tooltip_plot3', "_", input$type))) +
        geom_point_interactive(size = 3, aes(shape = as.character(przebiegniete))) +
        scale_x_continuous(expand = c(0,0), limits = c(0,22500)) +
        scale_y_continuous(labels = scales::percent_format(scale = 100),
                           limits = c(0,1.05), expand = c(0,0)) +
        scale_color_manual(values = color.names) +  
        scale_shape_manual(values = c("0" = 16, "1" = 15)) +
        labs(colour = "Imię") + 
        ylab("Jakość snu*") + xlab("Liczba kroków") +
        guides(color = "none", shape = "none") +
        coord_cartesian(clip = 'off') +
        theme_hc() + ggtitle("Zależność pomiędzy jakością snu a liczbą kroków") +
        theme(
          panel.background = element_rect(fill = background_color, colour = background_color),
          plot.background = element_rect(fill = background_color),
          axis.title.y = element_text_interactive(
            tooltip = "Więcej inforamcji\nw zakładce\no Wykresach"
          ), plot.title = element_text(hjust = 0.5, size = 15)
          )  -> p
      
    
      
      girafe(ggobj = p, width_svg = 8, height_svg = 5,
             options = list(
               opts_tooltip(css = tooltip_css,
                            use_fill = TRUE),
               opts_hover_inv(css = "opacity:0.6;"),
               opts_hover(css = girafe_css(
                 css = "stroke:black;"#r:8pt
               )), opts_toolbar(position = "bottomright")
             )
      ) -> x
      
      if (input$type == "name") {
        x <- girafe_options(x,
                            opts_selection(css = girafe_css(
                              css = "stroke:black;"#
                            ),
                            selected = rv$plots_cache,
                            only_shiny = F))
      } else if (input$type == "update_time") {
        x <- girafe_options(x,
                            opts_selection(css = girafe_css(
                              css = "stroke:black;"#r:8pt
                            ),
                            selected = rv$plots_cache_day,
                            type = 'multiple',
                            only_shiny = F))
      } else {
        x <- girafe_options(x,
                            opts_selection(css = girafe_css(
                              css = "stroke:black;"#r:8pt
                            ),
                            selected = rv$dayofweek,
                            type = 'multiple',
                            only_shiny = F))
      }
      
      print(x)
      
    })
    
    
    output$plot2 <- renderGirafe({ 
      dates <- input$date
      
      ggplot(df %>% filter(name %in% input$plot1_selected,
                           update_time <= dates[2],
                           update_time >= dates[1],
                           przebiegniete %in% legend),
             aes_string(x = 'Feelings', y = 'calorie', colour = 'name',
                 data_id = input$type, tooltip = paste0('tooltip_plot2', "_", input$type))) +
        geom_point_interactive(size = 5, aes(shape = as.character(przebiegniete))
                               ) +
        scale_y_continuous(expand = c(0,0), limits = c(0, 415)) +
        scale_color_manual(values = color.names) + 
        scale_shape_manual(values = c("0" = 16, "1" = 15)) +
        guides(color = "none", shape = "none") +
        labs(colour = "Imię") + 
        ylab("Liczba spalonych kalorii") +
        xlab("Wskaźnik wyspania*") +
        coord_cartesian(clip = 'off') +
        theme_hc() + ggtitle("Zależność pomiędzy liczbą spalonych kalorii a wskaźnikiem wyspania") +
        theme(
          panel.background = element_rect(fill = background_color, colour = background_color),
          plot.background = element_rect(fill = background_color),
          axis.title.x = element_text_interactive(
            tooltip = "Więcej inforamcji\nw zakładce\no Wykresach"
          ), plot.title = element_text(hjust = 0.5, size = 15)
        ) -> p
      
      
      girafe(ggobj = p, width_svg = 7, height_svg = 3,
             options = list(
               opts_tooltip(css = tooltip_css,
                            use_fill = TRUE),
               opts_hover_inv(css = "opacity:0.6;"),
               opts_hover(css = girafe_css(
                 css = "stroke:black;"
               )), opts_toolbar(position = "bottomright")
             )
      ) -> x
      
      if (input$type == "name") {
        x <- girafe_options(x,
                            opts_selection(css = girafe_css(
                              css = "stroke:black;"#r:8pt
                            ),
                            # selected = rv$plots_cache,
                            only_shiny = F))
      } else {
        x <- girafe_options(x,
                            opts_selection(css = girafe_css(
                              css = "stroke:black;"#r:8pt
                            ),
                            # selected = rv$plots_cache_day,
                            type = 'multiple',
                            only_shiny = F))
      }
      
      print(x)
      
    })
    
    output$plot45 <- renderGirafe({
      dates <- input$date
      input$date
      ggplot(df %>% filter(name %in% input$plot1_selected,
                           update_time <= dates[2],
                           update_time >= dates[1],
                           przebiegniete %in% legend),
             aes_string(x = 'asleep', y = 'jakosc_snu', colour = 'name',
                 data_id = input$type,
                 tooltip = paste0('tooltip_plot45', "_", input$type))) +
        geom_point_interactive(size = 3, aes(shape = as.character(przebiegniete))) +
        scale_x_time(limits = as_hms(c("00:00:00","11:00:00")), expand = c(0,0),
                     labels = function(x) substring(x, 1, 5)) +
        scale_y_continuous(labels = scales::percent_format(scale = 100),
                           limits = c(0,1.05), expand = c(0,0)) +
        guides(color = "none", shape = "none") + 
        scale_color_manual(values = color.names) +  
        scale_shape_manual(values = c("0" = 16, "1" = 15)) +
        labs(colour = "Imię") +
        ylab("Jakość snu*") + xlab("Długość snu") +
        coord_cartesian(clip = 'off') +
        theme_hc() + ggtitle("Zależność pomiędzy jakością snu a długością snu") +
        theme(
          panel.background = element_rect(fill = background_color, colour = background_color),
          plot.background = element_rect(fill = background_color),
          axis.title.y = element_text_interactive(
            tooltip = "Więcej inforamcji\nw zakładce\no Wykresach"
          ), plot.title = element_text(hjust = 0.5, size = 15)
        ) -> p
      
      
      girafe(ggobj = p, width_svg = 5, height_svg = 5,
             options = list(
               opts_tooltip(css = tooltip_css,
                            use_fill = TRUE),
               opts_hover_inv(css = "opacity:0.6;"),
               opts_hover(css = girafe_css(
                 css = "stroke:black;"
               )), opts_toolbar(position = "bottomright")
             )
      ) -> x
      
      if (input$type == "name") {
        x <- girafe_options(x,
                            opts_selection(css = girafe_css(
                              css = "stroke:black;"
                            ),
                            # selected = rv$plots_cache,
                            only_shiny = F))
      } else {
        x <- girafe_options(x,
                            opts_selection(css = girafe_css(
                              css = "stroke:black;"#r:8pt
                            ),
                            # selected = rv$plots_cache_day,
                            type = 'multiple',
                            only_shiny = F))
      }
      
      print(x)
      
    })
    
  })
  
  rv <- reactiveValues(
    plots_cache = NULL,
    plot1_cache = c("Karol", "Ada", "Adrian"),
    plots_cache_day = NULL,
    dayofweek = NULL
    )
  
    observeEvent(input$plot1_selected, {
      
      rv$plot1_cache <- input$plot1_selected
      
    })
    observeEvent(c(input$plot3_selected,
                   input$plot2_selected,
                   input$plot45_selected),
                 {
      if (input$type == "name") {
        names_general <- input$plot1_selected
        names_current_plot45 <- input$plot45_selected
        names_current_plot3 <- input$plot3_selected
        names_current_plot2 <- input$plot2_selected
        
        if (length(names_current_plot45)==length(names_current_plot3)) {
          names_current <- names_current_plot2
        } else if(length(names_current_plot45)==length(names_current_plot2)) {
          names_current <- names_current_plot3
        } else if(length(names_current_plot3)==length(names_current_plot2)) {
          names_current <- names_current_plot45
        } else return()
        
        names <- intersect(names_current, names_general)
        
        session$sendCustomMessage(type = 'plot3_set', message = names) # aktualizuje input$plot3_selected
        session$sendCustomMessage(type = 'plot2_set', message = names)
        session$sendCustomMessage(type = 'plot45_set', message = names)
        
        rv$plots_cache <- names
      } else if (input$type=="update_time") {
        
        days_plot45 <- input$plot45_selected
        days_plot3 <- input$plot3_selected
        days_plot2 <- input$plot2_selected
      
        if (length(days_plot45)==length(days_plot3)) {
          days <- days_plot2
        } else if(length(days_plot45)==length(days_plot2)) {
          days <- days_plot3
        } else if(length(days_plot3)==length(days_plot2)) {
          days <- days_plot45
        } else return()
        
        
        session$sendCustomMessage(type = 'plot3_set', message = days)
        session$sendCustomMessage(type = 'plot2_set', message = days)
        session$sendCustomMessage(type = 'plot45_set', message = days)
        session$sendCustomMessage(type = 'dayofweek_set', message = days)
        
        rv$plots_cache_day <- days
        
      } else if (input$type == "dayofweek") {
        dayofweek_plot45 <- input$plot45_selected
        dayofweek_plot3 <- input$plot3_selected
        dayofweek_plot2 <- input$plot2_selected
        
        dayofweek_plot <- input$dayofweek
        
        if (length(dayofweek_plot45)==length(dayofweek_plot3)) {
          dayofweek <- dayofweek_plot2
        } else if(length(dayofweek_plot45)==length(dayofweek_plot2)) {
          dayofweek <- dayofweek_plot3
        } else if(length(dayofweek_plot3)==length(dayofweek_plot2)) {
          dayofweek <- dayofweek_plot45
        } else return()
        
        
        
        session$sendCustomMessage(type = 'plot3_set', message = dayofweek)
        session$sendCustomMessage(type = 'plot2_set', message = dayofweek)
        session$sendCustomMessage(type = 'plot45_set', message = dayofweek)
        session$sendCustomMessage(type = 'dayofweek_set', message = dayofweek)
        
        
        rv$dayofweek <- dayofweek
        
      }
    })
    observeEvent(input$dayofweek_selected, {
      if (input$type == "name") return()
      
      selected <- input$dayofweek_selected
      
      if (input$type == "update_time") {
        rv$plots_cache_day <- selected
      } else {
        rv$dayofweek <- selected
      }
      
      
      
      session$sendCustomMessage(type = 'plot3_set', message = selected)
      session$sendCustomMessage(type = 'plot2_set', message = selected)
      session$sendCustomMessage(type = 'plot45_set', message = selected)
      
      
    })
    
    observeEvent(input$date, {
      
      if (input$type == "name") {
        session$sendCustomMessage(type = 'plot3_set', message = rv$plots_cache) # aktualizuje input$plot3_selected
        session$sendCustomMessage(type = 'plot2_set', message = rv$plots_cache)
        session$sendCustomMessage(type = 'plot45_set', message = rv$plots_cache)
      } else if (input$type == "update_time") {
        session$sendCustomMessage(type = 'plot3_set', message = rv$plots_cache_day) # aktualizuje input$plot3_selected
        session$sendCustomMessage(type = 'plot2_set', message = rv$plots_cache_day)
        session$sendCustomMessage(type = 'plot45_set', message = rv$plots_cache_day)
        session$sendCustomMessage(type = 'dayofweek_set', message = rv$dayofweek)
      } else if (input$type == "dayofweek") {
        session$sendCustomMessage(type = 'plot3_set', message = rv$dayofweek) # aktualizuje input$plot3_selected
        session$sendCustomMessage(type = 'plot2_set', message = rv$dayofweek)
        session$sendCustomMessage(type = 'plot45_set', message = rv$dayofweek)
        session$sendCustomMessage(type = 'dayofweek_set', message = rv$dayofweek)
      }
      
    })
  
}