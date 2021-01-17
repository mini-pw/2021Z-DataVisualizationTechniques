# skrypt tworzy dane potrzebne trzeciej stronie dashboarda

read.csv("data/allCount.csv", stringsAsFactors = F) %>%
  mutate(category = ifelse(domain %in% c("stackoverflow.com", "wikipedia.org", "github.com","pw.edu.pl"), "edu", "ent")) %>%
  mutate(date = as.Date(paste0(lubridate::year(date), "-", lubridate::month(date), "-01"))) %>%
  group_by(user, date, category) %>%
  summarise(avg = mean(count)) %>%
  tidyr::pivot_wider(names_from = category, values_from = avg) # %>%
  write.csv("data/balance.csv", row.names = F)

