library(wordcloud2)
library(spotifyr)
library(dplyr)
library(shiny)
library(bslib)
library(fmsb)
library(ggplot2)
library(plotly)
library(shinyWidgets)
library(supercaliheatmapwidget)
library(dygraphs)
library(xts)
library(tableHTML)
library(devtools)

Sys.setlocale(locale = "pl_PL")

Sys.setenv(SPOTIFY_CLIENT_ID = '')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '')
access_token <- get_spotify_access_token()


Mdf <- read.csv("./eda/data/mateusz/dane_2020_enc.csv", fileEncoding = "UTF-8", stringsAsFactors = FALSE)
Pdf <- read.csv("./eda/data/pawel/dane_2020_enc.csv", fileEncoding = "UTF-8", stringsAsFactors = FALSE)
Adf <- read.csv('./eda/data/artur/dane_2020_enc.csv', fileEncoding = "UTF-8", stringsAsFactors = FALSE)


get_listening_time <- function(df){
  sum(df$msPlayed)/(60*1000)
}

get_top_artists <- function(df, number) {
  as.vector(df %>% group_by(artistName) %>% count() %>% arrange(-n) %>% head(number) %>% pull(artistName))
}

get_top_artists_img_url <- function(df, number) {
  top_artists <- get_top_artists(df, number)
  res <- search_spotify(top_artists[1], "artist")[[1, "images"]][[1]][1, "url"]
  for (i in 2:number)
  {
    res <- c(res, search_spotify(top_artists[i], "artist")[[1, "images"]][[1]][1, "url"])
  }
  res
}

get_top_tracks <- function(df, number){
  top_tracks <- as.vector(df %>% group_by(artistName, trackName) %>% count() %>% arrange(-n) %>% head(number))
  paste(pull(top_tracks, artistName), pull(top_tracks, trackName), sep = ": ")                    
}

get_top_tracks_img_url <- function(df, number){
  top_tracks <- get_top_tracks(df, number)
  res <- search_spotify(top_tracks[1], "track")[[1, "album.images"]][[1]][1, "url"]
  for (i in 2:number)
  {
    res <- c(res, search_spotify(top_tracks[i], "track")[[1, "album.images"]][[1]][1, "url"])
  }
  res
}

get_top_albums <- function(df, number){
  top_albums <- as.vector(df %>% group_by(artistName, albumName) %>% count() %>% arrange(-n) %>% head(number))
  paste(pull(top_albums, artistName), pull(top_albums, albumName), sep = ": ")                    
}

get_top_albums_img_url <- function(df, number){
  top_albums <- get_top_albums(df, number)
  res <- search_spotify(top_albums[1], "album")[[1, "images"]][[1]][1, "url"]
  for (i in 2:number)
  {
    res <- c(res, search_spotify(top_albums[i], "album")[[1, "images"]][[1]][1, "url"])
  }
  res
}

get_plays_number <- function(df){
  nrow(df)
}

get_tracks_number <- function(df){
  nrow(df %>% group_by(artistName, trackName) %>% count())
}

get_artists_number <- function(df){
  nrow(df %>% group_by(artistName) %>% count())
}



get_data_for_start_page <- function(whose){
  assign(paste(whose, "listening_time", sep = "_"), get_listening_time(get(paste(whose, "df", sep=""))), envir = .GlobalEnv)
  assign(paste(whose, "top_artists", sep = "_"), get_top_artists(get(paste(whose, "df", sep="")), 3), envir = .GlobalEnv)
  assign(paste(whose, "top_artists_img_url", sep = "_"), get_top_artists_img_url(get(paste(whose, "df", sep="")), 3), envir = .GlobalEnv)
  assign(paste(whose, "top_tracks", sep = "_"), strsplit(get_top_tracks(get(paste(whose, "df", sep="")), 3), ": "), envir = .GlobalEnv)
  assign(paste(whose, "top_tracks_img_url", sep = "_"), get_top_tracks_img_url(get(paste(whose, "df", sep="")), 3), envir = .GlobalEnv)
  assign(paste(whose, "top_albums", sep = "_"), strsplit(get_top_albums(get(paste(whose, "df", sep="")), 3), ": "), envir = .GlobalEnv)
  assign(paste(whose, "top_albums_img_url", sep = "_"), get_top_albums_img_url(get(paste(whose, "df", sep="")), 3), envir = .GlobalEnv)
  assign(paste(whose, "plays_number", sep = "_"), get_plays_number(get(paste(whose, "df", sep=""))), envir = .GlobalEnv)
  assign(paste(whose, "tracks_number", sep = "_"), get_tracks_number(get(paste(whose, "df", sep=""))), envir = .GlobalEnv)
  assign(paste(whose, "artists_number", sep = "_"), get_artists_number(get(paste(whose, "df", sep=""))), envir = .GlobalEnv)
}


get_data_for_start_page("A")
get_data_for_start_page("P")
get_data_for_start_page("M")


A_features <- Adf %>% select(danceability, energy, acousticness, 
                          instrumentalness, liveness, valence) 
A_radar <- as.data.frame(as.list(colMeans(A_features))) 

P_features <- Pdf %>% select(danceability, energy, acousticness, 
                          instrumentalness, liveness, valence) 
P_radar <- as.data.frame(as.list(colMeans(P_features))) 

M_features <- Mdf %>% select(danceability, energy, acousticness, 
               instrumentalness, liveness, valence) 
M_radar <- as.data.frame(as.list(colMeans(M_features))) 


# min_1stquantiles <- apply(rbind(apply(A_features, 2, quantile, 0.25), 
#                                 apply(P_features, 2, quantile, 0.25), 
#                                 apply(M_features, 2, quantile, 0.25)), 2, min)
# max_3rdquantiles <- apply(rbind(apply(A_features, 2, quantile, 0.75), 
#                                 apply(P_features, 2, quantile, 0.75), 
#                                 apply(M_features, 2, quantile, 0.75)), 2, max)


min_1stquantiles <- apply(rbind(A_features, P_features, M_features), 2, quantile, 0.25)
max_3rdquantiles <- apply(rbind(A_features, P_features, M_features), 2, quantile, 0.75)


A_radar2 <- (colMeans(A_features) - min_1stquantiles)/(max_3rdquantiles - min_1stquantiles)
P_radar2 <- (colMeans(P_features) - min_1stquantiles)/(max_3rdquantiles - min_1stquantiles)
M_radar2 <- (colMeans(M_features) - min_1stquantiles)/(max_3rdquantiles - min_1stquantiles)


Mdfgenres <- read.csv("./eda/data/mateusz/genres_repeated.csv", fileEncoding = "UTF-8", stringsAsFactors = FALSE)[2:3]
Pdfgenres <- read.csv("./eda/data/pawel/genres_repeated.csv", fileEncoding = "UTF-8", stringsAsFactors = FALSE)[2:3]
Adfgenres <- read.csv('./eda/data/artur/genres_repeated.csv', fileEncoding = "UTF-8", stringsAsFactors = FALSE)[2:3]

M_features_densities <- lapply(M_features, density)
P_features_densities <- lapply(P_features, density)
A_features_densities <- lapply(A_features, density)
