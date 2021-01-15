
function(input, output, session) {
  
  hide(selector = "#tabs")
  
  source("datasets.R")
  
  color.palette <- c("Few Resources" = "#1f78b4",
                     "Some Resources" = "#984ea3",
                     "Many Resources" = "#33a02c",
                     "Moderate to Severe Problems" = "#1f78b4",
                     "Minor Problems" = "#984ea3",
                     "Hardly Any Problems" = "#33a02c")
  
  data1 <- reactive({
    switch(input$subject,
           "Mathematic" = 1,
           "Science" = 3) -> subject
    switch(input$grade,
           "4" = 0,
           "8" = 1) -> grade
    x <- dataset1[[subject + grade]]
    
    x
  })
  
  data2 <- reactive({
    switch(input$subject,
           "Mathematic" = 1,
           "Science" = 3) -> subject
    switch(input$grade,
           "4" = 0,
           "8" = 1) -> grade
    x <- dataset2[[subject + grade]]
    
    x
  })
  
  get.countries <- reactive({
    countries <- data1()
    countries <- countries$Country
    as.list(sort(countries))
  })
  
  selected_countries <- reactive({
    input$plot1_selected
  })
  
  observeEvent(c(input$plot1_selected, input$clear, input$grade), {
    if (length(input$plot1_selected)==0) {
      updateSelectInput(session, "country", label = "Chosen countries",
                        choices = get.countries(),
                        selected = character(0))
    } else {
      updateSelectInput(session, "country", label = "Chosen countries",
                        choices = get.countries(),
                        selected = selected_countries())
    }
  })
  
  output$plot1 <- renderGirafe({
    data1 <- data1()
    
    typeDescribtion <- ifelse(input$type=="Home",
                              " Home Resources for Learning ",
                              " School Discipline - Principals’ Reports ")
    
    xlabel <- paste0("Average", typeDescribtion, "Scale Score")
    ylabel <- "Average Science Scale Score"
    titlelabel <- paste0("Average", ifelse(input$subject=="Science", " Science ", " Mathematics "),
                         "Achievement by", typeDescribtion, "-", " Grade ", input$grade)
    
    
    ggplot(data1, aes_string(x = input$type, y = "Score",
                             label = paste("label",
                                           input$type, sep="_"),
                             color = paste("Describtion",
                                           input$type, sep="_"),
                             tooltip = paste("tooltip", input$type, sep = "_"),
                             data_id = "Country")) + 
      geom_point_interactive(size = 3) + 
      geom_point_interactive(data = data1 %>% filter(Country %in% input$country),
                              color = "#fb9a99", size = 5) +
      geom_text_repel(data = data1[1:3,],
                      nudge_y       = 680 - data1[1:3,]$Score,
                      size          = 5,
                      box.padding   = 1.5,
                      point.padding = 0.5,
                      force         = 100,
                      segment.size  = 0.2,
                      segment.color = "grey50",
                      direction     = "x") +
      geom_text_repel(data = data1[(nrow(data1)-2):nrow(data1),],
                      nudge_y       = 260 - data1[(nrow(data1)-2):nrow(data1),]$Score,
                      size          = 5,
                      box.padding   = 0.5,
                      point.padding = 0.5,
                      force         = 100,
                      segment.size  = 0.2,
                      segment.color = "grey50",
                      direction     = "x") +
      geom_label_repel(data = data1 %>%
                         filter(Country %in% setdiff(
                           input$country,
                           data1[c(1:3, (nrow(data1)-2):nrow(data1)),]$Country)
                         ),
                       size          = 5,
                       direction     = "both")  +
      scale_x_continuous(limits = c(6,12.5), expand = c(0, 0), breaks = 6:12) +
      scale_y_continuous(limits = c(240, 680), expand = c(0,.2)) + 
      scale_color_manual(values = color.palette) +
      theme_classic() +
      labs(x = xlabel, y = ylabel, title = titlelabel) +
      guides(color = "none") +
      theme(
        plot.title = element_text(face = "bold", size = 18, hjust = 0.5),
        axis.title.x = element_text(face = "bold", size = 14),
        axis.title.y = element_text(face = "bold", size = 14),
        axis.text.x = element_text(size = 11),
        axis.text.y = element_text(size = 11)
      ) -> a

    
    girafe(ggobj = a, width_svg = 15, height_svg = 6) -> x

    tooltip_css <- "background-color:white;font-style:italic;padding:10px;border-radius:10px 20px 10px 20px;"

    x <- girafe_options(x,
                        opts_tooltip(opacity = .95, css = tooltip_css),
                        opts_zoom(min = 1, max = 4),
                        opts_hover(css = "fill:#FB9A99;stroke:black;r:5pt;"),
                        opts_selection(css = "fill:#FB9A99;stroke:black;r:5pt;",
                                       selected = input$country, only_shiny = F))
    
    print(x)
  })
  
  observeEvent(c(input$country, input$clear, input$grade, input$type),{
    countries <- input$country
    data2 <- data2()
    if (!(any(countries %in% data2$Country))) {countries <- NULL}
    
    output$plot2 <- renderGirafe({
      ggplot(data2 %>% filter(Scale == input$type,
                              Country %in% countries),
             aes(x = Type, y = Values, fill = Type, data_id = Country,
                 tooltip = tooltip, label = label)) -> p 
      
      if (length(countries) != 0) {
        p + geom_bar_interactive(stat = "identity") + 
          geom_crossbar_interactive(aes(ymin=pmax(Values - Error, 0),
                                        ymax=pmin(Values + Error, 100)), fill = "white"
          )  -> p
      } 
      
      p + scale_y_continuous(limits = c(0, 100), expand = c(0,0)) + 
        theme_classic() +
        scale_fill_manual(values = color.palette) +
        guides(fill = "none") +
        labs(y = "Percent of Students", x = "",
             title = ifelse(is.null(countries),
                            "**Distribution of students in each group in** *{select country/countries}*",
                            paste0("**Distribution of students in each group in** ***",
                           paste0(countries, collapse = ", "),"***"))) +
        geom_text_interactive(aes(y = Values + Error), 
                  vjust = -0.3, fontface = "bold", size = 6) +
        theme(
          plot.title = ggtext::element_markdown(size = 16),
          axis.title.y = element_text(face = "bold", size = 14),
          axis.text.x = element_text(face = "bold", size = 12),
          axis.text.y = element_text(size = 11),
          strip.text = element_text(face = "bold", size = 12)
        ) -> p
      if (length(countries>1)) {
        p + facet_wrap(Country~.) -> p
      }
      
      girafe(ggobj = p, width_svg = 15, height_svg = 6) -> x
      
      tooltip_css <- "background-color:white;font-style:italic;padding:10px;border-radius:10px 20px 10px 20px;"
      
      x <- girafe_options(x,
                          opts_tooltip(opacity = .95, css = tooltip_css),
                          opts_zoom(min = 1, max = 4),
                          opts_hover(css = ""),
                          opts_selection(type = "none"))
      
      
      print(x)
    })
  })
  
  observeEvent(input$clear, {
    session$sendCustomMessage(type = 'plot1_set', message = character(0))
  })
  

  observeEvent(c(input$next01,input$prev03),#,input$next001),
               {
                 updateTabsetPanel(session, "tabs", selected = "panel02")
               })

  observeEvent(c(input$prev01, input$next02),#, input$prev001),
               {
                 updateTabsetPanel(session, "tabs", selected = "panel03")
               })
  
  observeEvent(c(input$prev02, input$next03),
               {
                 updateTabsetPanel(session, "tabs", selected = "panel01")
               })
}
