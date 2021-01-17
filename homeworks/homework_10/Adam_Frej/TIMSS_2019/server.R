#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define server logic
shinyServer(function(input, output) {

    Data <- read.csv2("Data.csv")
    
    output$plot_bar <- renderPlotly({
        Data$color = ifelse(input$select_gender == "all", "forestgreen", 
                            ifelse(input$select_gender == "girls", "firebrick", "#104e8b")) #why dodgerblue4 needs hex?
        if (!is.null(plot_bar())) {
            Data$color = ifelse(Data$Country %in% plot_bar(), "orange", Data$color)
        }
        plot_ly(Data, y = as.formula(
            paste0("~reorder(Country, ", input$select_data, input$select_year, input$select_gender, ")")), 
                x = as.formula(paste0("~", input$select_data, input$select_year, input$select_gender)), 
                type = "bar", source = "plot_bar", orientation = 'h', 
                marker = list(color = ~color)) %>%
            layout(xaxis = list(title = "Score", range = c(250, 650)), 
                   yaxis = list(title = list(text = "Country", standoff = 0)))
    })

    output$plot_time <- renderPlotly({
        if (is.null(plot_bar())) return(NULL)
        Data_country <- filter(Data, Country == plot_bar())
        if (input$select_data == "M") {
            Data_country <- data.frame(year = c("2019", "2015", "2011", "2007", "2003", "1995"), 
                                all = as.numeric(Data_country[2:7]), 
                                girls = as.numeric(Data_country[c(8,10,12,14,16,18)]), 
                                boys = as.numeric(Data_country[c(9,11,13,15,17,19)]))
            title = paste0(plot_bar(), " - ", "Math")
        }
        else {
            Data_country <- data.frame(year = c("2019", "2015", "2011", "2007", "2003", "1995"), 
                                       all = as.numeric(Data_country[20:25]), 
                                       girls = as.numeric(Data_country[c(26,28,30,32,34,36)]), 
                                       boys = as.numeric(Data_country[c(27,29,31,33,35,37)]))
            title = paste0(plot_bar(), " - ", "Science")
        }
        plot_ly(Data_country, x = ~year, colors = c("Both" = "forestgreen", 
                                                    "Girls" = "firebrick", 
                                                    "Boys" = "dodgerblue4")) %>%
            add_trace(y = ~all, type = "scatter", mode = "markers+lines", color = "Both") %>%
            add_trace(y = ~girls, type = "scatter", mode = "markers+lines", color = "Girls") %>%
            add_trace(y = ~boys, type = "scatter", mode = "markers+lines", color = "Boys") %>%
            layout(xaxis = list(title = "Year"), 
                   yaxis = list(title = "Score"),
                   legend = list(title = list(text = "<b>Gender:</b>")),
                   title = list(text = title))
    })
    
    plot_bar <- reactiveVal("Singapore")
    
    observeEvent(event_data("plotly_click", source = "plot_bar"), {
        plot_bar(event_data("plotly_click", source = "plot_bar")$y)
    })
    
})