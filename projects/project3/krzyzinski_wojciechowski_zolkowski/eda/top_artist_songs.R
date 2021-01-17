library(spotifyr)
library(dplyr)
library(ggplot2)
library(jsonlite)
library(lubridate)
library(fmsb)
library(tidyverse)

# Sys.setenv(SPOTIFY_CLIENT_ID = '')
# Sys.setenv(SPOTIFY_CLIENT_SECRET = '')
# access_token <- get_spotify_access_token()


# choices for dropdown input
top_artists <- df%>%
  mutate(artistName = as.character(artistName))%>%
  group_by(artistName)%>%
  summarise(n = n())%>%
  arrange(-n)%>%
  head(20)%>%.$artistName
  
top_songs_of_top_artists <- df%>%
  mutate(artistName = as.character(artistName))%>%
  filter(artistName %in% top_artists)%>%
  group_by(artistName, trackName)%>%
  summarise(n = n())%>%
  arrange(artistName, -n)%>%
  filter(n > 2)

picked_artist_songs <- top_songs_of_top_artists%>%
  filter(artistName == top_artists[1])%>%head(5)

ggplot(picked_artist_songs, aes(x = reorder(trackName, -n), y = n))+
  geom_col()
