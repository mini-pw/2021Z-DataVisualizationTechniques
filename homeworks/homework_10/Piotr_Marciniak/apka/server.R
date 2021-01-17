library(shiny)
library(leaflet)
library(geojsonio)
library(dplyr)
library(readr)
library(sp)
library(ggplot2)

shinyServer(function(input, output) {
    worldcountry <- geojson_read("./data/world map.json", what = "sp")
    data <- read_csv2("./data/dane.csv")
    
    output$map <- renderLeaflet({
        proper_data <- data %>%
            filter(Class == input$class, Subject == input$subject, Gender == "Both") %>%
            select(Country, Score)
        
        good_data <- merge(worldcountry, proper_data, by.x = "geounit", by.y = "Country", duplicateGeoms = TRUE)
        
        pallete <- colorNumeric("Blues", domain = proper_data$Score)
        
        leaflet(good_data) %>%
            addTiles() %>%
            fitBounds(~-100, -50, ~80, 80) %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.2, fillOpacity = 0.9,
                        layerId = ~geounit,
                        fillColor = ~pallete(Score)) %>%
            addLegend("bottomright", pal = pallete, values = proper_data$Score, title = "Score")
    })
    
    v <- reactiveValues(
        country = "Poland"
    )
    
    observeEvent(input$map_shape_click, {
        p <- input$map_shape_click
        countries <- data %>% 
            dplyr::filter(Class == input$class,Subject == input$subject) %>% 
            pull(Country)
        if (p$id %in% countries)
            v$country = p$id
    })
    
    output$gender <- renderPlot({
        data %>% dplyr::filter(Country == v$country, 
                        Class == input$class, Subject == input$subject) %>%
        ggplot(aes(x = Gender, y = Score, label = Country)) +
            geom_col(fill = "Blue") +
            ggtitle(v$country)
    })
    
    
})

