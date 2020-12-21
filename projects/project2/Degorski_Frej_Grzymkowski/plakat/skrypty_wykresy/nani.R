library(scales)
Sys.setlocale(category = "LC_ALL", locale = "english")
Sys.setlocale("LC_TIME", "en_US.UTF-8")

bind_rows(syt_epidemiczna %>% 
            mutate(Typ = "People self-isolating") %>%
            rename(Count = osoby_kwarantanna, Date = data) %>%
            select(Date, Count, Typ),
          aktywne %>% 
            mutate(Typ = "Active cases") %>%
            rename(Count = Liczba_aktywnych, Date = Data) %>% 
            select(Date, Count, Typ)
          ) %>%
  bind_rows(testy_polska %>% 
              mutate(Typ = "Tests per 24h") %>%
              rename(Count = testy_na_dobe, Date = data) %>%
              select(Date, Count, Typ)) %>%
  ggplot() +
  geom_line(aes(x = Date, y = Count, color = Typ)) + scale_y_continuous(labels = function(x) format(x, big.mark = " ",
                                                                                                    scientific = FALSE)) +
  scale_color_manual(values = c("People self-isolating" = "blue",
                                "Active cases" = "red",
                                "Tests per 24h" = "gold")) +
  theme_bw() +
  ylab("Number per day") +
  scale_x_date(breaks="month", labels=date_format("%b")) +
  theme(legend.title = element_blank(), legend.position = c(0.2,0.85)) 

syt_epidemiczna %>% 
  select(data, liczba_hospitalizowanych) %>%
  rename("Date" = "data", "Count" = liczba_hospitalizowanych) %>%
  mutate(Typ = "Osoby hospitalizowane") %>%
  bind_rows(aktywne %>% rename(Liczba = Liczba_aktywnych) %>% mutate(Typ = "Osoby chore")) -> x

ggplot(x) +
  geom_line(aes(x = Data, y = Liczba, color = Typ)) +
  theme(legend.title = element_blank()) +
  scale_color_manual(values = c("Osoby hospitalizowane" = "gold", "Osoby chore" = "red")) +
  theme_bw()
