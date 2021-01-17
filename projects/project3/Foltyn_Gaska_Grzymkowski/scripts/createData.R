# skrypt agreguje dane wygenerowane przez extract_JSON_history.R

library(dplyr)


create_count <- function(name){
  df <- read.csv(paste(name,".csv", sep = ""))

  df$time_usec <- as.Date(df$time_usec, '%Y-%m-%d')

  df1 <- df %>% group_by(df$time_usec, df$domain) %>% count()
  colnames(df1) <- c("time_usec", "domain", "count")

  all_days <- df %>% group_by(df$time_usec) %>% count()
  a <- rep(all_days$`df$time_usec`, each = 8)
  b <- rep( c( "stackoverflow.com",
              "wikipedia.org",
              "github.com",
              "pw.edu.pl",
              "youtube.com",
              "google.com",
              "facebook.com",
              "instagram.com"), times = length(a)/8)
  df2 <- data.frame("time_usec" = a, "domain" = b)
  finaldf <- left_join(df2, df1, by = c("time_usec", "domain"))
  finaldf$count[is.na(finaldf$count)] <- 0
  write.csv(finaldf, paste(name,"Count.csv", sep = ""))
}
create_count("jakub")
create_count("kacper")
create_count("janek")



