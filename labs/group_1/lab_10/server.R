library(DT)
library(ggplot2)
library(plotly)

function(input, output, session){
  # output$text_1 <- renderPrint({
  #   print(iris)
  # })
  
  output$table_1 <- DT::renderDataTable({
    DT::datatable(iris)
  })
  
  output$plot_1 <- renderPlot({
    sampled_rows <- sample(1:nrow(iris), input$plot_1_sample)
    sampled_iris <- iris[sampled_rows, ]
    
    if (input$plot_1_colors){
      ggplot(sampled_iris, aes_string(x = input$plot_1_x_selection, y = input$plot_1_y_selection, color = "Species")) +
        geom_point()
    } else {
      ggplot(sampled_iris, aes_string(x = input$plot_1_x_selection, y = input$plot_1_y_selection)) +
        geom_point()
    }
    

  })
  
  output$plotly_1 <- renderPlotly({
    sampled_rows <- sample(1:nrow(iris), input$plot_1_sample)
    sampled_iris <- iris[sampled_rows, ]
    
    if (input$plot_1_colors){
      p <- ggplot(sampled_iris, aes_string(x = input$plot_1_x_selection, y = input$plot_1_y_selection, color = "Species")) +
        geom_point()
    } else {
      p <- ggplot(sampled_iris, aes_string(x = input$plot_1_x_selection, y = input$plot_1_y_selection)) +
        geom_point()
    }
    
    ggplotly(p)
  })
  
}