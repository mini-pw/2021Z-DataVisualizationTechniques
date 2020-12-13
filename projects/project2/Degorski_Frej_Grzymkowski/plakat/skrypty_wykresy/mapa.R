library("maptools") 
library("rgdal") 
library("ggplot2") 


gestosc <- function() {
  
  # JPT_KOD_JE ma kod 
  readOGR("dane/mapa/powiaty/Powiaty.shp") %>%
    broom::tidy(powiaty_gis, region = "JPT_KOD_JE") %>%
    inner_join(powiaty_pop_id %>%
                 mutate(id = sprintf("%04d",Kod/1000)) %>%
                 select(id, Gestosc_zaludnienia),
              by="id") %>% 
    select(long, lat, group, Gestosc_zaludnienia) -> 
    map_df
  
  ggplot(map_df) +
    geom_polygon(aes(x = long, y= lat, group=group, fill = Gestosc_zaludnienia), color= "black") +
    theme_void()
}

readOGR("dane/mapa/powiaty/Powiaty.shp") %>%
  broom::tidy(powiaty_gis, region = "JPT_KOD_JE") %>%
  inner_join(read.csv("dane/scatter_dane.csv") %>%
               mutate(id = sprintf("%04d",Kod/1000)) %>%
               select(id, Procent_chorych),
             by="id") %>% 
  select(long, lat, group, Procent_chorych) %>%
  mutate(Procent_chorych = floor(Procent_chorych * 1000)) -> 
  map_covid_df


ggplot(map_covid_df) +
  geom_polygon(aes(x = long, y= lat, group=group, fill = Procent_chorych), color= "black") +
  scale_fill_binned(low = "navajowhite", high = "red4") +
  labs(fill = "", caption = "") +
  ggtitle("") +
  theme_void() +
  theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5))
