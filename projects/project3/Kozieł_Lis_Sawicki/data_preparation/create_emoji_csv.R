# Only used to make csv file with emojis used more than 9 times

library(readr)

emoji_to_link <- function(x) {
  paste0("https://emojipedia.org/emoji/",x) %>%
    read_html() %>%
    html_nodes("tr td a") %>%
    .[1] %>%
    html_attr("href") %>%
    paste0("https://emojipedia.org/", .) %>%
    read_html() %>%
    html_node('div[class="vendor-image"] img') %>%
    html_attr("src")
}

link_to_img <- function(x, size = 25) {
  paste0("<img src='", x, "' width='", size, "'/>")
}

path <- "data"

messages <- read_csv(paste(path,"/messages_Kuba_Lis.csv",sep = '')) %>%
  filter(!is.na(emojis))
messages <- rbind(messages,
                  read_csv(paste(path,"/messages_Bartek_Sawicki.csv",sep = '')) %>%
                    filter(!is.na(emojis)))
messages <- rbind(messages,
                  read_csv(paste(path,"/messages_Jakub_Kozieł.csv",sep = '')) %>%
                    filter(!is.na(emojis)))

all_emojis_tmp <- read.delim(
  paste0(path, "/all_emoji.txt"), header = FALSE, sep = "\n"
) 

counter <- data.frame("emoji" = NULL, "usage" = NULL)

for(i in 1:nrow(all_emojis_tmp)) {
  emoji <- all_emojis_tmp[[i,"V1"]]
  counter[i, "emoji"] <- emoji
  counter[i, "usage"] <- sum(str_count(messages$emojis, emoji))
}

all_emoji <- counter %>% filter(usage >= 10)


all_emoji <- all_emoji %>%
  mutate(url = map_chr(emoji, slowly(~emoji_to_link(.x), rate_delay(0.01),
                                     quiet = FALSE)),
         label = link_to_img(url))

all_emoji <- all_emoji %>% select(emoji, url, label)

write.csv(all_emoji, paste0(path,"/all_emoji.csv"), row.names = FALSE)
