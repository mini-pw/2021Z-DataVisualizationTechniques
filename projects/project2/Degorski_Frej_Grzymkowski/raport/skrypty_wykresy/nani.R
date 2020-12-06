bind_rows(syt_epidemiczna %>% 
            mutate(Typ = "Liczba osób na kwarantannie") %>%
            rename(Liczba = osoby_kwarantanna, Data = data) %>%
            select(Data, Liczba, Typ),
          aktywne %>% 
            mutate(Typ = "Liczba potwierdzonych przypadków") %>%
            rename(Liczba = Liczba_aktywnych) %>% 
            select(Data, Liczba, Typ)
          ) %>%
  bind_rows(testy_polska %>% 
              mutate(Typ = "Liczba wykonanych testów na dobę") %>%
              rename(Liczba = testy_na_dobe, Data = data) %>%
              select(Data, Liczba, Typ)) %>%
  ggplot() +
  geom_line(aes(x = Data, y = Liczba, color = Typ)) +
  scale_color_manual(values = c("Liczba osób na kwarantannie" = "blue",
                                "Liczba potwierdzonych przypadków" = "red",
                                "Liczba wykonanych testów na dobę" = "gold")) +
  theme_bw() + 
  theme(legend.title = element_blank()) 

syt_epidemiczna %>% 
  select(data, liczba_hospitalizowanych) %>%
  rename("Data" = "data", "Liczba" = liczba_hospitalizowanych) %>%
  mutate(Typ = "Osoby hospitalizowane") %>%
  bind_rows(aktywne %>% rename(Liczba = Liczba_aktywnych) %>% mutate(Typ = "Osoby chore")) -> x

ggplot(x) +
  geom_line(aes(x = Data, y = Liczba, color = Typ)) +
  theme(legend.title = element_blank()) +
  scale_color_manual(values = c("Osoby hospitalizowane" = "gold", "Osoby chore" = "red")) +
  theme_bw()
