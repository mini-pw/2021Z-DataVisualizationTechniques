function(input, output, session) {
  barplot_dataset <- reactive({switch(   
    input$category_input,   
    "Maths 4-grade"= M4results,   
    "Maths 8-grade"= M8results,   
    "Science 4-grade"= S4results,   
    "Science 8-grade"= S8results
  )})
  
  lineplot_dataset <- reactive({
    switch(input$category_input,
           "Maths 4-grade"= M4trends,   
           "Maths 8-grade"= M8trends,   
           "Science 4-grade"= S4trends,   
           "Science 8-grade"= S8trends)
  })
  
  barplot_dataset_picked <- reactive({
    pickCountry(barplot_dataset(), input$country_input, click_info$country)%>%
      arrange(-Score)%>% 
      mutate(Country=factor(Country, levels=Country)) 
  })
  
  lineplot_dataset_picked <- reactive({
    pickCountry(lineplot_dataset(), input$country_input)
  })
  
  observe({ 
    countries_to_choose <- barplot_dataset()$Country
    countries_to_choose <- sort(countries_to_choose)
    updateSelectInput(session, "country_input", choices = countries_to_choose, selected = NULL)
  })
  
  click_info <- reactiveValues(country = "Click on bar to compare...", score=0)
  pick_info <- reactiveValues(country = "Choose country on the left...", score = 0)
  
  # updating pick country
  observe({
    req(input$country_input)
    row <- barplot_dataset_picked()%>%
      filter(Country == input$country_input)
    pick_info$country <- as.character(row[1,][[1]])
    pick_info$score <- row[1,][[2]]
  })
  
  
  # updating click country
  observe({
    if (is.null(barplot_dataset_picked())){
      cat("Select country on the left")
    }else{
      req(input$barplot_click_pos, barplot_dataset_picked())
      lvls <- levels(barplot_dataset_picked()$Country)
      name <- lvls[round(input$barplot_click_pos$x)]
      
      df_record <- barplot_dataset_picked()%>%
        filter(Country == name)
      click_info$country <- as.character(df_record[1,][[1]])
      click_info$score <- df_record[1,][[2]]
    }
  })
  
  # printing click country
  output$clicked_country_name <- renderPrint(cat(click_info$country))
  output$clicked_country_score <- renderPrint(cat(paste("Score:", click_info$score)))
  
  # printing pick country
  output$picked_country_name <- renderPrint(cat(pick_info$country))
  output$picked_country_score <- renderPrint(cat(paste("Score:", pick_info$score)))
  
  
  
  
  output$country_bars <- renderPlot({
    ggplot(barplot_dataset_picked(),
           aes(x=Country, y=Score, fill=pick, color=click))+
      geom_col()+
      theme_classic()+
      theme(axis.ticks.x = element_blank(),
            axis.text.x = element_blank(),
            legend.position = 'none')+
      scale_fill_manual(values = c("#D8D8D8", "#00AFBB"))+
      scale_color_manual(values = c('black', 'red'))+
      theme(plot.title = element_text(size=22),
            axis.text.y = element_text(size = 12),
            axis.title=element_text(size=14))+
      labs(title = "Countries sorted by score", x = "",
           subtitle = " Click on the bar to compare")+
      scale_y_continuous(expand = c(0, 0), limits = c(0, 700))
  })
  
  output$country_lines <- renderPlot({
    if (!(input$country_input %in% lineplot_dataset_picked()$Country)){
      return()
    }
    ggplot()+
      geom_line(data=lineplot_dataset_picked()%>%filter(pick==FALSE),
                aes(x=year, y=Score, group=Country), color='grey', alpha=0.5)+
      geom_line(data=lineplot_dataset_picked()%>%filter(pick==TRUE),
                aes(x=year, y=Score, group=Country), color='#00AFBB')+
      geom_point(data=lineplot_dataset_picked()%>%filter(pick==TRUE),
                aes(x=year, y=Score, group=Country), color='#00AFBB')+
      theme_classic()+
      ylim(200, 700)+
      labs(title = "Scores across previous years", x = "")+
      theme(plot.title = element_text(size=22),
            axis.text.y = element_text(size = 12),
            axis.text.x = element_text(size = 12),
            axis.title=element_text(size=14))
  })
  
  output$distributions_plot <- renderPlotly({
    df_to_plot <- switch(   
      input$category_input_dists,   
      "Maths 4-grade"= M4distribution,   
      "Maths 8-grade"= M8distribution,   
      "Science 4-grade"= S4distribution,   
      "Science 8-grade"= S8distribution
    )
    
    df_to_plot$Country <- factor(df_to_plot$Country, levels = df_to_plot$Country[order(df_to_plot$avg)])
    fig <- plot_ly(df_to_plot, color = I("gray80"))
    fig <- fig %>% add_segments(x = ~x5th_p, xend = ~x95th_p, y = ~Country, yend = ~Country, showlegend = FALSE)
    fig <- fig %>% add_markers(x = ~x5th_p, y = ~Country, name = "5th percentile", color = I("grey"))
    fig <- fig %>% add_markers(x = ~x95th_p, y = ~Country, name = "95th percentile", color = I("grey"))
    fig <- fig %>% add_segments(x = ~x25th_p, xend = ~x75th_p, y = ~Country, yend = ~Country, showlegend = FALSE)
    fig <- fig %>% add_markers(x = ~x25th_p, y = ~Country, name = "25th percentile", color = I("#76d2e4"))
    fig <- fig %>% add_markers(x = ~x75th_p, y = ~Country, name = "75th percentile", color = I("#76d2e4"))
    fig <- fig %>% add_segments(x = ~x95_conf_1, xend = ~x95_conf_2, y = ~Country, yend = ~Country, showlegend = FALSE)
    fig <- fig %>% add_markers(x = ~x95_conf_1, y = ~Country, name = "95% confidence", color = I("black"))
    fig <- fig %>% add_markers(x = ~x95_conf_2, y = ~Country, name = "95% confidence", color = I("black"))
    fig <- fig %>% layout(height = 650, font=list(family="Montserrat"), yaxis=list(title = ""),
                          xaxis = list(title = "Score"))
    fig <- fig %>% config(displayModeBar = FALSE)
  })
}