library(jsonlite)
library(plotly)
library(dplyr)
library(ggplot2)
library(shiny)
library(reshape2)
library(igraph)
library(networkD3)

# Dane do grafu

#Bartek

history_b0 <- fromJSON("bartek0.json")
history_b1 <- fromJSON("bartek1.json")
history_b2 <- fromJSON("bartek2.json")
history_b3 <- fromJSON("bartek3.json")

janek <- rbind(history_b0, history_b1, history_b2, history_b3)
janek$endTime <- as.Date(factor(janek$endTime) , format = "%Y-%m-%d")

#Janek

history_j0 <- fromJSON("jan0.json")
history_j1 <- fromJSON("jan1.json")

bartek <- rbind(history_j0, history_j1)
bartek$endTime <- as.Date(factor(bartek$endTime) , format = "%Y-%m-%d")

#Szymon 

szymon <- fromJSON("szymon0.json")

szymon$endTime <- as.Date(factor(szymon$endTime) , format = "%Y-%m-%d")

###### Data for barplot 

week_bartek <- bartek %>% group_by(week = cut(endTime, "week")) %>%
  mutate(weekly_time = sum(msPlayed)/ 60000) %>%
  filter(endTime >= as.Date('2020-1-1') & endTime < as.Date('2020-11-1')) %>%
  select(week, weekly_time) %>%
  distinct() %>% mutate(name = "Bartek")
week_janek <- janek %>% group_by(week = cut(endTime, "week")) %>%
  mutate(weekly_time = sum(msPlayed)/ 60000) %>%
  filter(endTime >= as.Date('2020-1-1') & endTime < as.Date('2020-11-1')) %>%
  select(week, weekly_time) %>%
  distinct() %>% mutate(name = "Janek")
week_szymon <- szymon %>% group_by(week = cut(endTime, "week")) %>%
  mutate(weekly_time = sum(msPlayed)/ 60000) %>%
  filter(endTime >= as.Date('2020-1-1') & endTime < as.Date('2020-11-1')) %>%
  select(week, weekly_time) %>%
  distinct() %>% mutate(name = "Szymon")

weekly_data <- rbind(week_bartek, week_janek, week_szymon)

write.csv(weekly_data, "weekly_data.csv")

######## Data for graph

df1 <- szymon %>%
  group_by(artistName) %>%
  summarise(sum_time = sum(msPlayed) / 60000) %>% 
  arrange(desc(sum_time)) %>%
  mutate(name = "Szymon")
df2 <- janek %>%
  group_by(artistName) %>%
  summarise(sum_time = sum(msPlayed) / 60000) %>% 
  arrange(desc(sum_time)) %>%
  mutate(name = "Janek")
df3 <- bartek %>%
  group_by(artistName) %>%
  summarise(sum_time = sum(msPlayed) / 60000) %>% 
  arrange(desc(sum_time)) %>%
  mutate(name = "Bartek")
### Data for one selected
## Szymon 
network_data <- head(df1, 8)
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName)

n <- nrow(data_frame(id = c(data$from, data$to)) %>% distinct())
nl<- data_frame(id = c(data$from, data$to)) %>% distinct() 

node_szym <- data_frame(id = c(data$from, data$to)) %>% distinct() %>%
  mutate(idn = 0:(n-1), user = c("Szymon", rep("Artists", n-1)),
         size = c(10, rep(3, n-1)), wariant = "Szymon")

edge_szym <- data %>% mutate(from_num = apply(select(data, from), 1, FUN = pom)) %>%
  mutate(to_num = apply(select(data, to), 1, FUN = pom), wariant = "Szymon")

## Janek 
network_data <- head(df2, 8)
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName)

n <- nrow(data_frame(id = c(data$from, data$to)) %>% distinct())
nl<- data_frame(id = c(data$from, data$to)) %>% distinct() 

node_jan <- data_frame(id = c(data$from, data$to)) %>% distinct() %>%
  mutate(idn = 0:(n-1), user = c("Janek", rep("Artists", n-1)),
         size = c(10, rep(3, n-1)), wariant = "Janek")

edge_jan <- data %>% mutate(from_num = apply(select(data, from), 1, FUN = pom)) %>%
  mutate(to_num = apply(select(data, to), 1, FUN = pom), wariant = "Janek")
## Bartek 
network_data <- head(df3, 8)
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName)

n <- nrow(data_frame(id = c(data$from, data$to)) %>% distinct())
nl<- data_frame(id = c(data$from, data$to)) %>% distinct() 

node_bart <- data_frame(id = c(data$from, data$to)) %>% distinct() %>%
  mutate(idn = 0:(n-1), user = c("Bartek", rep("Artists", n-1)),
         size = c(10, rep(3, n-1)), wariant = "Bartek")

edge_bart <- data %>% mutate(from_num = apply(select(data, from), 1, FUN = pom)) %>%
  mutate(to_num = apply(select(data, to), 1, FUN = pom), wariant = "Bartek")

##### Data for 1 selected combined

edge_one <- rbind(edge_szym, edge_bart, edge_jan)
node_one <- rbind(node_jan, node_szym, node_bart)

write.csv(edge_one, "edge_one.csv")
write.csv(node_one, "node_one.csv")

### Data for two selected

## Szymon i Janek

common_artists_top5 <- full_join(df1, df2, by = "artistName") %>% na.omit()
common_artists_top5$min_time <- apply(select(common_artists_top5, sum_time.x, sum_time.y),1 , FUN = min)
common_artists_top5 <- common_artists_top5 %>%
  arrange(desc(min_time)) %>%
  select(artistName) %>%
  head(5)

network_data <- rbind(filter(df1, df1$artistName %in% common_artists_top5$artistName),
                      filter(df2, df2$artistName %in% common_artists_top5$artistName),
                      head(filter(df1, !df1$artistName %in% common_artists_top5$artistName)), 
                      head(filter(df2, !df2$artistName %in% common_artists_top5$artistName)))
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName)

n <- nrow(data_frame(id = c(data$from, data$to)) %>% distinct())
nl<- data_frame(id = c(data$from, data$to)) %>% distinct() 

node_sj <- data_frame(id = c(data$from, data$to)) %>% distinct() %>%
  mutate(idn = 0:(n-1), user = c("Szymon","Janek", rep("Artists", n-2)),
         size = c(10,10, rep(3, n-2)), wariant = "sj")

edge_sj <- data %>% mutate(from_num = apply(select(data, from), 1, FUN = pom)) %>%
  mutate(to_num = apply(select(data, to), 1, FUN = pom), wariant = "sj")

## Szymon i Bartek

common_artists_top5 <- full_join(df1, df3, by = "artistName") %>% na.omit()
common_artists_top5$min_time <- apply(select(common_artists_top5, sum_time.x, sum_time.y),1 , FUN = min)
common_artists_top5 <- common_artists_top5 %>%
  arrange(desc(min_time)) %>%
  select(artistName) %>%
  head(5)

network_data <- rbind(filter(df1, df1$artistName %in% common_artists_top5$artistName),
                      filter(df3, df3$artistName %in% common_artists_top5$artistName),
                      head(filter(df1, !df1$artistName %in% common_artists_top5$artistName)), 
                      head(filter(df3, !df3$artistName %in% common_artists_top5$artistName)))
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName)

n <- nrow(data_frame(id = c(data$from, data$to)) %>% distinct())
nl<- data_frame(id = c(data$from, data$to)) %>% distinct() 

node_sb <- data_frame(id = c(data$from, data$to)) %>% distinct() %>%
  mutate(idn = 0:(n-1), user = c("Szymon","Bartek", rep("Artists", n-2)),
         size = c(10,10, rep(3, n-2)), wariant = "sb")

edge_sb <- data %>% mutate(from_num = apply(select(data, from), 1, FUN = pom)) %>%
  mutate(to_num = apply(select(data, to), 1, FUN = pom), wariant = "sb")

## Janek i Bartek

common_artists_top5 <- full_join(df2, df3, by = "artistName") %>% na.omit()
common_artists_top5$min_time <- apply(select(common_artists_top5, sum_time.x, sum_time.y),1 , FUN = min)
common_artists_top5 <- common_artists_top5 %>%
  arrange(desc(min_time)) %>%
  select(artistName) %>%
  head(5)

network_data <- rbind(filter(df2, df2$artistName %in% common_artists_top5$artistName),
                      filter(df3, df3$artistName %in% common_artists_top5$artistName),
                      head(filter(df3, !df3$artistName %in% common_artists_top5$artistName)), 
                      head(filter(df2, !df2$artistName %in% common_artists_top5$artistName)))
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName)

n <- nrow(data_frame(id = c(data$from, data$to)) %>% distinct())
nl<- data_frame(id = c(data$from, data$to)) %>% distinct() 

node_jb <- data_frame(id = c(data$from, data$to)) %>% distinct() %>%
  mutate(idn = 0:(n-1), user = c("Janek","Bartek", rep("Artists", n-2)),
         size = c(10,10, rep(3, n-2)), wariant = "jb")

edge_jb <- data %>% mutate(from_num = apply(select(data, from), 1, FUN = pom)) %>%
  mutate(to_num = apply(select(data, to), 1, FUN = pom), wariant = "jb")

##### Data for 2 selected combined

edge_two <- rbind(edge_jb, edge_sj, edge_sb)
node_two <- rbind(node_jb, node_sb, node_sj)

write.csv(edge_two, "edge_two.csv")
write.csv(node_two, "node_two.csv")

#### Data for all

all <- full_join(df1, df2, by = "artistName") %>% full_join(df3, by = "artistName")

# all_top3 <- all %>%
#   mutate(min_time = apply(select(all, sum_time.x, sum_time.y, sum_time),  1, FUN = min)) %>% 
#   arrange(desc(min_time)) %>%
#   select(artistName) %>%
#   head(3)
# 
# zajete <- all_top3[["artistName"]]

zajete <- c()

SJ_top3 <- all %>%
  mutate(min_time = apply(select(all, sum_time.x, sum_time.y),  1, FUN = min)) %>% 
  filter(!artistName %in% zajete) %>%
  arrange(desc(min_time)) %>%
  select(artistName) %>%
  head(5)
zajete <- c(zajete, SJ_top3[["artistName"]])

JB_top3 <- all %>%
  mutate(min_time = apply(select(all, sum_time, sum_time.y),  1, FUN = min)) %>% 
  filter(!artistName %in% zajete) %>%
  arrange(desc(min_time)) %>%
  select(artistName) %>%
  head(5)

zajete <- c(zajete, JB_top3[["artistName"]])

BS_top3 <- all %>%
  mutate(min_time = apply(select(all, sum_time, sum_time.x),  1, FUN = min)) %>% 
  filter(!artistName %in% zajete) %>%
  arrange(desc(min_time)) %>%
  select(artistName) %>%
  head(5)

zajete <- c(zajete, BS_top3[["artistName"]])

network_data <- rbind(filter(df1, df1$artistName %in% BS_top3$artistName),
                      filter(df1, df1$artistName %in% SJ_top3$artistName),
                      filter(df2, df2$artistName %in% JB_top3$artistName),
                      filter(df2, df2$artistName %in% SJ_top3$artistName),
                      filter(df3, df3$artistName %in% BS_top3$artistName),
                      filter(df3, df3$artistName %in% JB_top3$artistName))
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName
)

n <- nrow(data_frame(id = c(data$from, data$to)) %>% distinct())
nl <- data_frame(id = c(data$from, data$to)) %>% distinct() 
node_all <- data_frame(id = c(data$from, data$to)) %>% distinct() %>%
  mutate(idn = 0:(n-1), user = c("Szymon","Janek","Bartek", rep("Artists", n-3)), size = c(10,10,10, rep(3, n-3)))

edge_all <- data %>% mutate(from_num = apply(select(data, from), 1, FUN = pom)) %>%
  mutate(to_num = apply(select(data, to), 1, FUN = pom))

write.csv(node_all, "node_all.csv")
write.csv(edge_all, "edge_all.csv")

pom <- function(x, t = nl$id) {
  return(which(t == x) - 1)
}


el <- edge_bart
nl <- node_bart

el <- data_frame(
  from_num=c(0),
  to_num=c(0)
)
nl <- data_frame(
  id = c(0),user = c(0),b = c(0),c = c(0),d = c(0),
)
colors <- 'd3.scaleOrdinal(["white"])'

colors <- 'd3.scaleOrdinal(["red", "blue", "green", "orange"])'
forceNetwork(Links = el, Nodes = nl, Source="from_num", Target="to_num", NodeID = "id",
             Group = "user", linkWidth = 1,
             colourScale = colors,
             linkColour = "#afafaf", Nodesize=5,fontSize=12, zoom=T, legend=F,
             opacity = 0.8, charge=-400,
             width = 300, height = 300, 
             opacityNoHover = 1)



df1 <- szymon %>%
  group_by(artistName) %>%
  summarise(sum_time = sum(msPlayed) / 60000) %>% 
  arrange(desc(sum_time)) %>%
  mutate(name = "Szymon")
df2 <- janek %>%
  group_by(artistName) %>%
  summarise(sum_time = sum(msPlayed) / 60000) %>% 
  arrange(desc(sum_time)) %>%
  mutate(name = "Janek")


common_artists_top5 <- full_join(df1, df2, by = "artistName") %>% na.omit()
common_artists_top5$min_time <- apply(select(common_artists_top5, sum_time.x, sum_time.y),1 , FUN = min)
common_artists_top5 <- common_artists_top5 %>%
  arrange(desc(min_time)) %>%
  select(artistName) %>%
  head(5)

network_data <- rbind(filter(df1, df1$artistName %in% common_artists_top5$artistName),
                      filter(df2, df2$artistName %in% common_artists_top5$artistName), 
                      head(filter(df1, !df1$artistName %in% common_artists_top5$artistName)), 
                      head(filter(df2, !df2$artistName %in% common_artists_top5$artistName)))
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName
)

# Plot
p <- simpleNetwork(data, zoom = T )
p

