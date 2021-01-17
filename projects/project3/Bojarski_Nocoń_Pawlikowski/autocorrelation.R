library(ggplot2)

# sets working directory as the same as this file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# loads the data
running_data <- read.table("Source_data/running_data.txt", header = TRUE, sep = "\t")
running_data$date <- as.Date(running_data$date, format = "%Y-%m-%d")

# crates autocorrelation plot
autocorrelation <- function(deley, vector) {
  autocorr <- acf(vector)
  autocorr <- data.frame(y = autocorr$acf, x = 0:(length(autocorr$acf)-1))
  
  p <- ggplot(autocorr, aes(x = x, y = y)) +
    geom_segment(aes(xend = x), yend = 0, color = "darkgreen") +
    geom_hline(yintercept = 0, color = "darkgreen") +
    geom_vline(xintercept = deley, 
               color = "#57a800", 
               alpha = 0.4, 
               size = 7.5) +
    geom_point(size = 2) +
    theme(
      title = element_text(color = "darkgreen", size = 30),
      axis.title = element_text(color = "darkgreen", size = 18),
      axis.text = element_text(color = "darkgreen", size = 18), 
      panel.background = element_blank(),
      axis.line = element_line(colour = "darkgreen"),
      panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
      axis.ticks = element_line(color = "darkgreen")
    ) +
    xlab("lag between trainings") +
    ylab("correlation coefficient") +
    ggtitle("Autocorrelation function") +
    scale_x_continuous(expand = c(0,0),
                       limits = c(-1, 22.5),
                       breaks = seq(0, 22, 2)) +
    scale_y_continuous(expand = c(0,0),
                       limits = c(-0.2, 1.05),
                       breaks = seq(-0.2, 1, 0.2))
  return(p)
}

# creates correlation plot between delayed data
correlation <- function(delay, vector) {
  n <- length(vector)
  if(delay != 0) {
    df <- data.frame(y = vector[-seq(1, delay, 1)], 
                     x = vector[-seq(n-delay+1, n, 1)])
  } else df <- data.frame(x = vector, y = vector)
  
  min_xy <- 7.868565
  max_xy <- 13.87667
  
  p <- ggplot(df, aes(x = x, y = y)) +
    geom_point(color = "#57a800", size = 2) +
    theme(
      title = element_text(color = "darkgreen", size = 30),
      axis.title = element_text(color = "darkgreen", size = 18),
      axis.text = element_text(color = "darkgreen", size = 18), 
      panel.background = element_blank(),
      axis.line = element_line(colour = "darkgreen"),
      panel.border = element_rect(colour = "darkgreen", fill=NA, size = 2),
      axis.ticks = element_line(color = "darkgreen")
    ) +
    xlab(if(delay !=0) paste("running speed ", 
                             delay, 
                             " training session", if(delay != 1) "s", " ago (km/h)",
                             sep = "") 
         else "running speed") +
    ylab("running speed (km/h)") +
    ggtitle("") +
    scale_x_continuous(expand = c(0,0),
                       limits = c(min_xy, max_xy),
                       breaks = seq(0, 20, 1)) +
    scale_y_continuous(expand = c(0,0),
                       limits = c(min_xy, max_xy),
                       breaks = seq(0, 20, 1))
  return(p)
}
