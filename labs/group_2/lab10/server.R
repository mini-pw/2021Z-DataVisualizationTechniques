library(DT)
library(ggplot2)

function(input, output, session){
  
  # output$verbatim_1 <- renderPrint({
  #   print(iris)
  # })
  
  output$table_1 <- DT::renderDataTable({
    DT::datatable(iris)
  })
  
  output$plot_1 <- renderPlot({
    sample_row <- sample(1:nrow(iris), input$plot_1_sample)
    sampled_iris <- iris[sample_row, ]
    
    if (input$plot_1_colors) {
      ggplot(sampled_iris, aes_string(x = input$plot_1_x, y = input$plot_1_y, color = "Species")) +
        geom_point()  
    } else {
      ggplot(sampled_iris, aes_string(x = input$plot_1_x, y = input$plot_1_y)) +
        geom_point()
    }
    
  })
  
  output$plotly_1 <- renderPlotly({
    sample_row <- sample(1:nrow(iris), input$plot_1_sample)
    sampled_iris <- iris[sample_row, ]
    
    if (input$plot_1_colors) {
      p <- ggplot(sampled_iris, aes_string(x = input$plot_1_x, y = input$plot_1_y, color = "Species")) +
        geom_point()  
    } else {
      p <- ggplot(sampled_iris, aes_string(x = input$plot_1_x, y = input$plot_1_y)) +
        geom_point()
    }
    ggplotly(p)
    
  })
  
}

