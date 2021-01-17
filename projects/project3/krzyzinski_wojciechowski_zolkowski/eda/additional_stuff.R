# library(lubridate)



#dodanie popularności
# get_popularity <- function(row){
#   get_track(row["id"])["popularity"]
# }
# pop <- read.csv('./eda/data/pawel/dane_2020_enc.csv', fileEncoding = "UTF-8", stringsAsFactors = FALSE)
# pop2 <- apply(pop, 1, get_popularity) 
# 
# do.call(rbind.data.frame, pop2) ->  df_pop
# cbind(pop, df_pop) -> Adf 





# #połączenie danych z nowymi - do dopełnienia roku
# dane1 <- read.csv("./eda/data/artur/dane.csv", encoding = "UTF-8")
# dane2 <- read.csv("./eda/data/artur/dane2.csv", fileEncoding = "UTF-8")
# 
# 
# dane <- as.data.frame(fromJSON("eda/data/artur/StreamingHistory0.json"))
# cbind(dane[this_rows,], dane1[-c(1:6)]) -> X
# # rbind(X, dane2[-1]) -> df
# # 
# Pdf %>% filter(endTime < "2021-01-01" & endTime >= "2020-01-01") -> X
# Pdf <- X[-1]
# write.csv(Pdf, "./eda/data/pawel/dane_2020_enc.csv", fileEncoding = "UTF-8")




#trochę rzeczy żeby naprawić kodowanie, bo (przynajmniej mi) coś się popsuło 
# library(stringi)
# Mdf$artistName <- stri_replace_all_fixed(Mdf$artistName, "<U+", "\\u")
# Mdf$artistName <- stri_replace_all_fixed(Mdf$artistName, ">", "")
# Mdf$artistName <- stri_unescape_unicode(Mdf$artistName)
# 
# Mdf$trackName <- stri_replace_all_fixed(Mdf$trackName, "<U+", "\\u")
# Mdf$trackName <- stri_replace_all_fixed(Mdf$trackName, ">", "")
# Mdf$trackName <- stri_unescape_unicode(Mdf$trackName)
# # 
# # 
# write.csv(Mdf, file = "./eda/data/mateusz/dane_2020_enc.csv", fileEncoding = "UTF-8")





# jakieś staty z ciekawości
# x1 <- Adf %>% group_by(artistName) %>% count(name = "n1") %>% arrange(-n1) 
# x2 <- Pdf %>% group_by(artistName) %>% count(name = "n2") %>% arrange(-n2) 
# x3 <- Mdf %>% group_by(artistName) %>% count(name = "n3") %>% arrange(-n3) 
# 
# 
# x1 <- Adf %>% group_by(artistName) %>% count(name = "n1") %>% mutate(n1 = n1/nrow(Adf)) %>% arrange(-n1) 
# x2 <- Pdf %>% group_by(artistName) %>% count(name = "n2") %>% mutate(n2 = n2/nrow(Pdf)) %>% arrange(-n2) 
# x3 <- Mdf %>% group_by(artistName) %>% count(name = "n3") %>% mutate(n3 = n3/nrow(Mdf)) %>% arrange(-n3) 
# 
# 
# inner_join(inner_join(x1, x2), x3) %>% mutate(n = min(n1, n2, n3)) %>% arrange(-n) 
# 
# inner_join(x1,x3) %>% mutate(n = 100*min(n1,n3)) %>% arrange(-n) -> x
# inner_join(x1,x2) %>% mutate(n = 100*min(n1,n2)) %>% arrange(-n) -> x
# inner_join(x2,x3) %>% mutate(n = 100*min(n3,n2)) %>% arrange(-n) -> x
# 
# left_join(x1, x3) %>% mutate(n = min(n1, n3)) %>%  arrange(-n) 
# left_join(x1, x2) %>% mutate(n = min(n1, n2)) %>%  arrange(-n)
# left_join(x3, x2) %>% mutate(n = min(n3, n2)) %>%  arrange(-n)
# 
# sum(x$n)





#albumy dla piosenek
# res <- vector()
# 
# for (i in 0:(floor(nrow(Pdf)/20)-1)){
#   res <- c(res, as.character(unlist(get_albums(get_tracks(Pdf$id[(20*i+1):(20*i+20)])$album.id)["name"])))
# }
# 
# albumName <- c(res, as.character(unlist(get_albums(get_tracks(Pdf$id[(20*i+21):nrow(Pdf)])$album.id)["name"])))
# Pdf <- cbind(Pdf, albumName)
# write.csv(Pdf[-1], "./eda/data/pawel/dane_2020_enc.csv", fileEncoding = "UTF-8")
# 
# 







