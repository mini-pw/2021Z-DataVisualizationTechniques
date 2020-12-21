library(rbokeh)


figure(xgrid = FALSE, ygrid = FALSE, xaxes = FALSE, yaxes = FALSE) %>%
  ly_lines(x = c(-2,2), 
           y = c(-1,-1),
           width = 20,
           color = "white",alpha = 1
  )  %>%
  ly_lines(x = c(0,0), 
           y = c(-1,0.3),
           width = 20,
           color = "brown",alpha = 1
  )  %>%
  ly_lines(x = runif(200, -2, 2) * seq(0, 1, length = 200), 
           y = seq(10, 0, length = 200),
           width = 10,
           color = "green") %>%
  ly_points(x = runif(15, -1.5, 1.5) * seq(0, 1, length = 15), 
            y = seq(10, 0, length = 15),
            size = 20,
            color = "red") %>%
  ly_points(x = runif(7, -1.5, 1.5) * seq(0, 1, length = 7), 
            y = seq(10, 0, length = 7),
            size = 20,
            color = "yellow") %>%
  theme_plot(
    background_fill_color = '#8499ba',
    
  ) %>%
  ly_points(x = runif(200,-2, 2), 
            y = runif(200,0, 10),
            size = 5,
            color = "white") 
