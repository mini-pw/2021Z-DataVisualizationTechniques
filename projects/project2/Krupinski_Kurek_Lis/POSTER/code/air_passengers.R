# library(ggplot2)
# library(dplyr)
# library(stringi)

air_plots <- function(vector_with_countries, path_to_tsv) {
  
  air_passengers <- read.csv(file = path_to_tsv, sep = '\t', header = TRUE)
  
  rows <- rep(c("M,PAS,PAS_CRD,TOTAL,TOT,"), length(vector_with_countries))
  countries <- paste0(rows, vector_with_countries)
  
  air_passengers %>%
    rename(country = freq.unit.tra_meas.tra_cov.schedule.geo.TIME_PERIOD) %>%
    filter(country %in% countries) -> df
  
  year <- rep(c("2019", "2020"),each=12)[1:21]
  month <- rep(1:12, length.out=21)
  
  for (i in seq_along(countries)) {
    
    country_i <- countries[i]
    passengers <- as.numeric(df[df$country == country_i, 2:22])
    df_i <- data.frame(month, year, passengers)
    
    plot_i <- ggplot(data = df_i, aes(
      x = month, y = (passengers/1000000), group = year, color = year
    )) +
      geom_line(size=1.5) +
      scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
      scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
      ylab("passengers [mln]") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5),
            text = element_text(size = 20))
    
    country_i <- stri_sub(country_i, -2)
    
    if (country_i == "BG") {
      plot_i <- plot_i + ggtitle("Number of air passengers in Bulgaria")
    } else if (country_i == "IS") {
      plot_i <- plot_i + ggtitle("Number of air passengers in Iceland")
    } else {
      plot_i <- plot_i + 
        ggtitle(paste("Number of air passengers in", country_i))
    }
      
    print( plot_i )
  }
}

air_plots(c("BG", "IS"), "data/air_passengers.tsv")
