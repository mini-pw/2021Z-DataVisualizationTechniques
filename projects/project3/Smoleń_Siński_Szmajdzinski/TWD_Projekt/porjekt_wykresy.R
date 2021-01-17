library(jsonlite)
library(igraph)
library(networkD3)
library(dplyr)

# Reading and processing data 

#Bartek

history_b0 <- fromJSON("bartek0.json")
history_b1 <- fromJSON("bartek1.json")
history_b2 <- fromJSON("bartek2.json")
history_b3 <- fromJSON("bartek3.json")

bartek <- rbind(history_b0, history_b1, history_b2, history_b3) %>% mutate(name = "Bartek")
bartek$endTime <- as.Date(factor(bartek$endTime) , format = "%Y-%m-%d")

#Janek

history_j0 <- fromJSON("jan0.json")
history_j1 <- fromJSON("jan1.json")

janek <- rbind(history_j0, history_j1) 
janek$endTime <- as.Date(factor(janek$endTime) , format = "%Y-%m-%d")

#Szymon 

szymon <- fromJSON("szymon0.json")  %>% mutate(name = "Szymon")

szymon$endTime <- as.Date(factor(szymon$endTime) , format = "%Y-%m-%d")


# Wykres minut słychanych w ciągu tygodnia 

week_bartek <- bartek %>% group_by(name)%>% group_by(week = cut(endTime, "week")) %>%
  mutate(weekly_time = sum(msPlayed)/ 60000) %>%
  filter(endTime >= as.Date('2020-1-1') & endTime < as.Date('2020-11-1')) %>%
  select(week, weekly_time) %>%
  distinct() %>% mutate(name = "Bartek")
week_janek <- bartek %>% group_by(name)%>% group_by(week = cut(endTime, "week")) %>%
  mutate(weekly_time = sum(msPlayed)/ 60000) %>%
  filter(endTime >= as.Date('2020-1-1') & endTime < as.Date('2020-11-1')) %>%
  select(week, weekly_time) %>%
  distinct() %>% mutate(name = "Janek")
week_szymon <- szymon %>% group_by(week = cut(endTime, "week")) %>%
  mutate(weekly_time = sum(msPlayed)/ 60000) %>%
  filter(endTime >= as.Date('2020-1-1') & endTime < as.Date('2020-11-1')) %>%
  select(week, weekly_time) %>%
  distinct() %>% mutate(name = "Szymon")

timePer_week <- rbind(week_janek, week_szymon)
p1 <- ggplot(data = timePer_week, aes(x = as.Date(week), y = weekly_time)) +
  geom_line(aes(color = name)) +
  scale_x_date(date_labels = "%b/%d")
ggplotly(p1)


# Wykres miesieczny minut idsłuchan

wanted_month <- '03'
dailyMinutesMonth <- data_temp %>%
  mutate(month = format(endTime, "%m")) %>%
  filter(endTime >= as.Date('2020-1-1') & endTime < as.Date('2020-11-1') & month == wanted_month )%>%
  group_by(endTime) %>%
  summarise(sum_time = sum(msPlayed) / 60000)
  

p2 <- ggplot(dailyMinutesMonth, aes(x = endTime, y = sum_time)) +
  geom_col()
ggplotly(p2)


# Network plot test 


df1 <- bartek %>%
  group_by(artistName) %>%
  summarise(sum_time = sum(msPlayed) / 60000) %>% 
  arrange(desc(sum_time)) %>%
  mutate(name = "Bratek")
df2 <- janek %>%
  group_by(artistName) %>%
  summarise(sum_time = sum(msPlayed) / 60000) %>% 
  arrange(desc(sum_time)) %>%
  mutate(name = "Janke")


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

# Static plot

# create data:
links <- data.frame(
  source=network_data$name,
  target=network_data$artistName,
  importance=(network_data$sum_time/5000)
)
nodes <- data.frame(
  name=c("Bratek", "Janke", unique(network_data$artistName))
)

# Turn it into igraph object
network <- graph_from_data_frame(d=links, vertices=nodes, directed=F) 

# Make the plot
plot(network,vertex.size=20, edge.width=2 )

# Interactive plot 

# create a dataset:
data <- data_frame(
  from=network_data$name,
  to=network_data$artistName
)

# Plot
p <- simpleNetwork(data, zoom = T )
p

# network_data <- bartek %>%
#   group_by(artistName) %>%
#   summarise(sum_time = sum(msPlayed) / 60000)  %>% 
#   mutate(name= "Bartek") %>%
#   filter(sum_time > 900)
# network_data <- rbind(df1, df2)




