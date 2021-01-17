library(spotifyr)
library(dplyr)
library(ggplot2)
library(jsonlite)
library(lubridate)
library(fmsb)
library(tidyverse)

Sys.setenv(SPOTIFY_CLIENT_ID = '')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '')
access_token <- get_spotify_access_token()



# -------- fragment do wczytywania danych o playliscie, zwraca liste dfow z piosenkami-----------
playlists_df <- as_tibble(as_tibble(fromJSON("eda/data/pawel/Playlist1.json"))[[1]])

playlists_names <- playlists_df[['name']]

track_audio_features <- function(row) {
  search_results <- search_spotify(paste(row["track.artistName"], row["track.trackName"]), type = "track")
  track_audio_feats <- get_track_audio_features(search_results$id[[1]])
  track_audio_feats
}

load_songs_info <- function(songs){
  songs <- songs[[1]]
  apply(songs, 1, track_audio_features) -> audio_features
  print(lengths(audio_features))
  do.call(rbind.data.frame, audio_features[lengths(audio_features) == 18]) -> df_features
  print(dim(df_features))
  cbind(songs[lengths(audio_features) == 18,], df_features)
  
}

playlist_list <- list()

for(i in 1:dim(playlists_df)[1]){
  playlist_list[[playlists_names[i]]] <- as.data.frame(load_songs_info(playlists_df[i, 'items'][[1]]))
}
saveRDS(playlist_list, file = "eda/data/pawel/playlist_data.RDS")
#----------------------------------------------------------------------

