library(shiny)
library(ggplot2)

function(input, output, session){

  df <- reactive({
    data.frame(x = input[["slider1"]][1]:input[["slider1"]][2],
              y = runif(length(input[["slider1"]][1]:input[["slider1"]][2])))
  })
 
  rv <- reactiveValues(
    clicked = NULL,
    clicked_id = c(),
    polygon = data.frame(x = numeric(), y = numeric())
    )
  
  observeEvent(input[["plot1_click"]], {
    rv[["clicked"]] <- nearPoints(df(), 
                                  coordinfo = input[["plot1_click"]],
                                  allRows = TRUE,
                                  maxpoints = 1,
                                  threshold = 20)
    selected_point <- which(rv[["clicked"]][["selected_"]])
    
    if (length(selected_point) > 0){
      if (selected_point %in% rv[["clicked_id"]]){
        rv[["clicked_id"]] <- setdiff(rv[["clicked_id"]], selected_point)
        row_to_remove <- which(rv[["polygon"]][,"x"] == rv[["clicked"]][selected_point, "x"])
        rv[["polygon"]] <- rv[["polygon"]][-row_to_remove, ]
      } else {
        rv[["clicked_id"]] <- c(rv[["clicked_id"]], selected_point)
        rv[["polygon"]] <- rbind(rv[["polygon"]], data.frame(x = rv[["clicked"]][selected_point, "x"],
                                                             y = rv[["clicked"]][selected_point, "y"]))
      }  
    }
    
    

  })
   
  output[["plot1"]] <- renderPlot({
    plot_df <- df()
    plot_df[["selected_"]] <- FALSE
    plot_df[rv[["clicked_id"]], "selected_"] <- TRUE

    ggplot(plot_df) +
      geom_point(aes(x = x, y = y, color = selected_), size = 7) +
      geom_polygon(data = rv[["polygon"]], aes(x=x, y=y))
  })
  
  
}