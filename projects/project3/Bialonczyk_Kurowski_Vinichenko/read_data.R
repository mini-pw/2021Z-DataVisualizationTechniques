library(data.table)
library(dplyr)
# nalezy ustawic working directory na \sciezka_do_files\files

#----------------------------------------------- word_data ----------------------------------------------------- #
word_data <- read.csv("most_popular_words.csv") 
colnames(word_data) <- c("X", "word", "freq", "sender") 
word_data$freq <- as.numeric(word_data$freq)
word_data <- word_data %>%
  mutate(word = tolower(as.character(word)))
word_data <- word_data %>% 
  group_by(word, sender) %>%
  mutate(freq = sum(freq)) %>% 
  ungroup() %>% 
  select(word, freq, sender) %>%
  unique()

#----------------------------------------------- friends_data ---------------------------------------------------- #
friends_data <- read.csv("friends.csv")
friends_data <- friends_data %>% arrange(desc(timestamp))

friends <- read.csv('friends_number.csv')

#----------------------------------------------- messages_data ---------------------------------------------------- #
messages <- read.csv("messages.csv")

messages$time <- as.POSIXct(messages$time/1000, origin="1970-01-01")
messages$date <- as.Date(messages$time, "%Y-%m-%d")

# zliczam wiadomosci po dacie #
wszystkie = messages %>% count(date) %>% arrange(desc(n))



#---------------------------------------------- komentarze -------------------------------------------------------#
comments <- read.csv("comments.csv")
top_comments <- comments %>% 
  group_by(comment.author, comment.group) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>%
  ungroup()

#---------------------------------------------- reszta ------------------------------------------------------------#
likes <- read.csv("likes.csv")
posts <- read.csv("posts.csv")
groups <- read.csv("groups.csv")
interests<- read.csv("interests.csv")
