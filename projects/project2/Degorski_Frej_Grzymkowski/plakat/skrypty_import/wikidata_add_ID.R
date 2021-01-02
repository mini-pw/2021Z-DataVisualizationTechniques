# JUŻ NIE POTRZEBNY -> był useful do stworzenia "dane/powiaty_pop_id.csv"

read.csv("dane/raw/powiaty_dane.csv", fileEncoding = "UTF-8", stringsAsFactors = FALSE, sep =";") %>%
  as.tbl() %>%
  mutate_at("Powiat", stringr::str_to_lower) ->
  powiaty_pop



powiaty %>%
  mutate_at("Nazwa", as.character) %>%
  mutate_at("Nazwa", stringr::str_to_lower) %>%
  group_by(Kod, Nazwa) %>%
  summarise(avg = mean(Liczba_chorych)) %>%
  select(-(avg)) ->
  nazwykody

nazwykody %>% 
  group_by(Nazwa) %>% 
  summarise(count = n()) %>% 
  filter(count > 1) %>%
  select(Nazwa)-> 
  duplikaty
duplikaty <- pull(duplikaty, Nazwa)

powiaty_pop %>%
  filter(!(Powiat %in% duplikaty)) ->
  powiaty_pop_nd

powiaty_pop %>%
  filter((Powiat %in% duplikaty)) ->
  powiaty_pop_dup


join_easy <- function(df) {
  df$Powiat[df$Powiat == "warszawa"] <- "powiat m. st. warszawa"
  miasta <- df$Powiat[!stringr::str_starts(df$Powiat, "powiat")]
  miasta <- paste("powiat m.", miasta, sep="")
  df$Powiat[!stringr::str_starts(df$Powiat, "powiat")] <- miasta
  df
}


inner_join(nazwykody, join_easy(powiaty_pop_nd), by=c("Nazwa" = "Powiat")) %>%
  mutate_at(c("Powierzchnia", "Liczba_ludności", "Gęstość_zaludnienia"), polski_do_R) ->
  powiaty_pop_nd_id
powiaty_pop_nd_id

powiaty_pop_dup %>%
  mutate_at(c("Powierzchnia", "Liczba_ludności", "Gęstość_zaludnienia"), polski_do_R) ->
  powiaty_pop_dup_fix
