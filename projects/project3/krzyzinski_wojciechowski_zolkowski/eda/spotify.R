library(spotifyr)
library(dplyr)
library(ggplot2)
library(jsonlite)
library(lubridate)
library(fmsb)

Sys.setenv(SPOTIFY_CLIENT_ID = '')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '')
access_token <- get_spotify_access_token()

df <- rbind(as.data.frame(fromJSON("eda/data/pawel/StreamingHistory0.json")), as.data.frame(fromJSON("eda/data/pawel/StreamingHistory1.json")))

df %>% mutate(endTime = as.POSIXct(endTime, format = "%Y-%m-%d %H:%M", tz = "UTC")) %>% 
       mutate(endTime = format(df$endTime, tz="Europe/Warsaw", usetz = TRUE)) -> df

track_audio_features <- function(row) {
  search_results <- search_spotify(paste(row["artistName"], row["trackName"]), type = "track")
  track_audio_feats <- get_track_audio_features(search_results$id[[1]])
  track_audio_feats
}


# zakomentowane sciaganie informacji o utworach

# apply(df, 1, track_audio_features) -> audio_features
# do.call(rbind.data.frame, audio_features[lengths(audio_features) == 18]) -> df_features
# cbind(df[lengths(audio_features) == 18,], df_features) -> df_with_features
# write.csv(df_with_features, "dane.csv")


df <- read.csv("/eda/data/pawel/dane.csv")


df %>% select(danceability, speechiness, energy, acousticness, 
                  instrumentalness, liveness, speechiness, valence, tempo) -> df_radar

as.data.frame(as.list(colMeans(df_radar))) -> df_radar
rbind(c(rep(1, 7), 200), c(rep(0, 7), 0), df_radar) -> df_radar

radarchart(df_radar)


