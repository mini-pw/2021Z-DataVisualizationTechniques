library("rjson")
tomek <- fromJSON(file ="RScripts/projekt3TWD/artistsTomek.json")
artists <- tomek$items
tomek <- tomek$items
dominik <- fromJSON(file ="RScripts/projekt3TWD/domTop50Artists.json")
artists <- c(artists, dominik$items)
dominik <- dominik$items
patryk <- fromJSON(file ="RScripts/projekt3TWD/Patryk_top_artists.json")
artists <- c(artists, patryk$items)
patryk <- patryk$items

# liczenie gatunkow dla artystow topowych
allGenres <- list()
for (i in c(1:150))
{
  lnList <- length(artists[[i]][["genres"]])
  lnGList <- length(allGenres)
  if (lnList != 0)
  {
    for (j in c(1:lnList))
    {
      allGenres[lnGList + j] <- artists[[i]][["genres"]][j]
    }
  }
}
#allGenres <- unique(allGenres)
allGenres <- unlist(allGenres, recursive=FALSE)
allGenres <- as.data.frame(table(allGenres))
allGenres <- allGenres[order(allGenres$Freq, decreasing = TRUE),]

# liczenie gatunkow dla artystow topowych tomek
allGenresTomek <- list()
for (i in c(1:50))
{
  lnList <- length(tomek[[i]][["genres"]])
  lnGList <- length(allGenresTomek)
  if (lnList != 0)
  {
    for (j in c(1:lnList))
    {
      allGenresTomek[lnGList + j] <- tomek[[i]][["genres"]][j]
    }
  }
}
#allGenres <- unique(allGenres)
allGenresTomek <- unlist(allGenresTomek, recursive=FALSE)
allGenresTomek <- as.data.frame(table(allGenresTomek))
allGenresTomek <- allGenresTomek[order(allGenresTomek$Freq, decreasing = TRUE),]

# liczenie gatunkow dla artystow topowych dominik
allGenresDominik <- list()
for (i in c(1:50))
{
  lnList <- length(dominik[[i]][["genres"]])
  lnGList <- length(allGenresDominik)
  if (lnList != 0)
  {
    for (j in c(1:lnList))
    {
      allGenresDominik[lnGList + j] <- dominik[[i]][["genres"]][j]
    }
  }
}
#allGenres <- unique(allGenres)
allGenresDominik <- unlist(allGenresDominik, recursive=FALSE)
allGenresDominik <- as.data.frame(table(allGenresDominik))
allGenresDominik <- allGenresDominik[order(allGenresDominik$Freq, decreasing = TRUE),]

# liczenie gatunkow dla artystow topowych patryk
allGenresPatryk <- list()
for (i in c(1:50))
{
  lnList <- length(patryk[[i]][["genres"]])
  lnGList <- length(allGenresPatryk)
  if (lnList != 0)
  {
    for (j in c(1:lnList))
    {
      allGenresPatryk[lnGList + j] <- patryk[[i]][["genres"]][j]
    }
  }
}
#allGenres <- unique(allGenres)
allGenresPatryk <- unlist(allGenresPatryk, recursive=FALSE)
allGenresPatryk <- as.data.frame(table(allGenresPatryk))
allGenresPatryk <- allGenresPatryk[order(allGenresPatryk$Freq, decreasing = TRUE),]

#zapisywanie danych

write.csv(allGenres, "allGenres.csv")
write.csv(allGenresPatryk, "allGenresPatryk.csv")
write.csv(allGenresDominik, "allGenresDominik.csv")
write.csv(allGenresTomek, "allGenresTomek.csv")



# tworzenie csv odnosnie relacji artystow
library(httr)

key <- "BQDA9X6AA_hi_hFLR3HDQaS-zC6wbt5aCT8mGOaOqnEmx5UYw-BEspodLOz23VRzLE9sDf5AuaOId-NTxh_18SkIZMHsYR_NXVxwVIqhSsmx6TaBMce0ANXrbblc2FOf50c_uhsmeINUQ_-XIfpthlpNBHpl9MZFlZaAWGOQ9O8"



url <- paste("https://api.spotify.com/v1/artists/", artistsId[1], "/related-artists", sep="")
G <- GET(url, add_headers(Authorization = paste("Bearer", key, sep = " "), Accept = " application/json", Content_Type = " application/json"))
jsonRespText <- content(G,as="parsed")
Sys.sleep(2)
for (i in c(2:150))
{
  url <- paste("https://api.spotify.com/v1/artists/", artistsId[i], "/related-artists", sep="")
  G <- GET(url, add_headers(Authorization = paste("Bearer", key, sep = " "), Accept = " application/json", Content_Type = " application/json"))
  jsonRespText <- c(jsonRespText, content(G,as="parsed"))
  #będzie się robić 300 sekund......
  Sys.sleep(2)
}

relatedList <- list()
for (i in c(1:150))
{
  temp <- jsonRespText[[i]][[1]][["name"]]
  for (j in c(2:length(jsonRespText[[i]])))
  {
    temp <- c(temp, jsonRespText[[i]][[j]][["name"]])
  }
  relatedList <- c(relatedList, list(temp))
}

artistsNames <- c("A")
for (i in c(1:150))
{
  artistsNames[i] = artists[[i]][["name"]]
}
artistsNames <- unlist(artistsNames)

artistsId <- c("A")
for (i in c(1:150))
{
  artistsId[i] = artists[[i]][["id"]]
}
artistsId <- unlist(artistsId)

obydzialalo <- sapply(relatedList, '[', seq(max(sapply(relatedList, length))))
colnames(obydzialalo) <- artistsNames
write.csv(obydzialalo, "relatedArtists.csv")
write.csv(artistsNames, "artistsNames.csv")
write.csv(artistsId, "artistsId.csv")