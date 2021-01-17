get_genres <- function(x){
  id_artist <- search_spotify(x, type = "artist")
  as.vector(get_artist(id_artist$id[[1]])[["genres"]])
}

lapply(unique(Adf$artistName), get_genres) -> A_list_of_genres
save <- A_list_of_genres
mapply(c, as.list(unique(Adf$artistName)), save, SIMPLIFY = FALSE) -> listaA

# save(listaA, file="A_genres_list.RData")
# save(A_list_of_genres, file="A_genres_list_without_artist.RData")
#load("A_genres_list_without_artist.RData")

genres_repeated <- function(df, lista){
  artistsCounted <- df %>% group_by(artistName) %>% count()
  artistsCounted <- data.frame(artistName = unique(df$artistName)) %>% inner_join(artistsCounted) 
  genres_rep <- unlist(mapply(rep, lista, artistsCounted$n))
  genres_rep <- as.data.frame(table(genres_rep)) %>% arrange(-Freq)
  colnames(genres_rep) <- c("word", "freq")
  genres_rep
}

A_genres_repeated <- genres_repeated(Adf, A_list_of_genres)
P_genres_repeated <- genres_repeated(Pdf, P_list_of_genres)
M_genres_repeated <- genres_repeated(Mdf, M_list_of_genres)

write.csv(A_genres_repeated, "A_genres_repeated.csv", fileEncoding = "UTF-8")
write.csv(M_genres_repeated, "M_genres_repeated.csv", fileEncoding = "UTF-8")
write.csv(P_genres_repeated, "P_genres_repeated.csv", fileEncoding = "UTF-8")