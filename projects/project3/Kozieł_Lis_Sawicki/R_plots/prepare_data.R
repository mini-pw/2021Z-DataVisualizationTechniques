
library(readr)
library(dplyr)
library(stringr)

path <- "data_preparation/data"

names <- c("Kuba", "Jakub", "Bartek")
surnames <- c("Lis", "Koziel", "Sawicki")
people <- paste0(names, " ", substr(surnames, 1, 1), ".")
people[2] <- "Kuba K."
csv_names <- paste0("messages_", names, "_", surnames)

for (i in 1:3) {
  
  # messages_Kuba_Lis <- ...
  
  human <- csv_names[i]
  assign(human, read_csv(paste0(path, "/", human, ".csv")))
  
  # messages_Kuba_Lis_emoji <- ...
  
  assign(paste0(human, "_emoji"), get(human) %>% filter(!is.na(emojis)))
} 

all_messages <- rbind(
  cbind(get(csv_names[1]), person = people[1]),
  rbind(
    cbind(get(csv_names[2]), person = people[2]),
    cbind(get(csv_names[3]), person = people[3])
  )
)

messages <- rbind(
  rbind(get(paste0(csv_names[1], "_emoji")),
        get(paste0(csv_names[2], "_emoji"))),
  get(paste0(csv_names[3], "_emoji"))
)

all_emojis <- read_csv(paste0(path, "/all_emoji.csv"))
names(all_emojis) <- c("emoji", "url", "label")
counter <- data.frame("emoji" = NULL, "usage" = NULL,
                      "url" = NULL, "label" = NULL)

for(i in 1:nrow(all_emojis)) {
  emoji <- all_emojis[[i,"emoji"]]
  counter[i, "emoji"] <- emoji
  counter[i, "usage"] <- sum(str_count(messages$emojis, as.character(emoji) ))
  counter[i, "url"] <- all_emojis[i,"url"]
  counter[i, "label"] <- all_emojis[i,"label"]
}

all_emojis <- counter %>%
  filter(usage >= 6)

plot_emoji <- function(start, end, ppl) {
  
  emojis <- data.frame("emoji" = NULL, "url" = NULL, "label" = NULL)
  
  ffilter <- function(df) {
    df %>%
      filter(timestamp > 1000 * as.numeric(as.POSIXct(
        as.character(start), format="%Y-%m-%d"
      ))) %>%
      filter(timestamp < 1000 * as.numeric(as.POSIXct(
        as.character(end), format="%Y-%m-%d"
      )))
  }
  
  for (i in 1:3) {
    if (people[i] %in% ppl) {
      
      # messLis <- ...
      
      assign(paste0("mess", str_sub(people[i], -2, -2)), ffilter(
        get(paste0(csv_names[i], "_emoji"))
      ))
    }
  }
  
  for (mess in paste0(rep("mess", length(ppl)), str_sub(ppl, -2, -2))) {
    mess <- get(mess)
    counter <- data.frame("emoji" = all_emojis[,1],
                          "usage" = rep(0, length(all_emojis[,1])),
                          "url" = all_emojis[,"url"],
                          "label" = all_emojis[,"label"])
    
    for(i in 1:nrow(all_emojis)) {
      counter[i, "usage"] <- sum(
        str_count(mess$emojis, as.character(counter[i,"emoji"]) )
      )
    }
    n <- nrow(emojis)
    p <- (length(ppl)**2-9*length(ppl)+24) %/% 2
    emojis <- rbind(emojis, arrange(counter, desc(usage)) %>%
                      slice(1:p) %>%
                      filter(usage > 0) %>%
                      select(emoji, url, label))
  }
  
  # najczesciej uzywane emojis
  emojis <- emojis %>% distinct(emoji, .keep_all = TRUE)
  
  df <- data.frame(
    "person" = rep(ppl, each = nrow(emojis)),
    "emoji" = rep(emojis$emoji, times = length(ppl)),
    "label" = rep(emojis$label, times = length(ppl)),
    "numberOfUses" = rep(0, length(ppl)*nrow(emojis))
  )
  
  
  for(i in 1:nrow(df)) {
    df[i, "numberOfUses"] <- sum(
      str_count(
        get(paste0('mess', str_sub(df[[i, "person"]],-2,-2)))$emojis,
        as.character(df[i,"emoji"])
      )
    )
  }
  
  
  
  df %>%
    ggplot(aes(fct_reorder(label, numberOfUses, .desc = TRUE), numberOfUses,
               fill = person)) +
    geom_col(position = position_dodge()) +
    theme_minimal() +
    labs(x = NULL, y = NULL) +
    scale_fill_manual(values=c("Kuba L." = '#5741A6',
                               "Kuba K." = '#F2133C',
                               "Bartek S." = '#F2BD1D')) +
    scale_y_continuous(expand = c(0, 0)) +
    ggtitle("Number of emoji uses") +
    theme_solarized() +
    theme(axis.text.x = element_markdown(),
          axis.text.y = element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20),
          legend.text = element_text(size = 15),
          legend.title = element_text(size = 18))
}

prepare_data_table <- function(start, end, person) {
  
  k <- match(person, people)
  
  mess <- get(paste0(csv_names[k], "_emoji")) %>%
    filter(timestamp > 1000 * as.numeric(as.POSIXct(
      as.character(start), format="%Y-%m-%d"
    ))) %>%
    filter(timestamp < 1000 * as.numeric(as.POSIXct(
      as.character(end), format="%Y-%m-%d"
    )))
  
  df <- data.frame(
    "emoji" = all_emojis$emoji,
    "label" = all_emojis$label,
    "numberOfUses" = rep(0, nrow(all_emojis))
  )
  
  for(i in 1:nrow(df)) {
    df[i, "numberOfUses"] <- sum(
      str_count(mess$emojis, as.character(df[i,"emoji"]) )
    )
  }
  
  df <- df %>% select(label, numberOfUses) %>%
    arrange(desc(numberOfUses))
  names(df) <- c("emoji", "numberOfUses")
  
  return(df)
}

# tab 3 functionality
plot_activity_time <- function(start, end, ppl, weekday){
  if(weekday != "all"){
    tmp_df <- all_messages %>%
      filter(day_of_the_week == weekday)
  }else{
    tmp_df <- all_messages
  }
  tmp_df %>% filter(person %in% ppl) %>%
    filter(date>start)%>%
    filter(date<end)%>%
    ggplot()+
    geom_bar(aes(x = floored_hour, group = person, fill = person),stat = "count", position = position_dodge(preserve = 'single')) +
    labs(x = "message hour", y = NULL) +
    ggtitle("Number of messages") +
    scale_y_continuous(expand = c(0, 0))+
    scale_fill_manual(values=c("Kuba L." = '#5741A6',
                               "Kuba K." = '#F2133C',
                               "Bartek S." = '#F2BD1D'))+
    theme_solarized() +
    theme(axis.text.x = element_text(size = 15),
          axis.text.y = element_text(size = 15),
          axis.title.x = element_text(size = 18),
          plot.title = element_text(hjust = 0.5, size = 20),
          legend.text = element_text(size = 15),
          legend.title = element_text(size = 18))

}
