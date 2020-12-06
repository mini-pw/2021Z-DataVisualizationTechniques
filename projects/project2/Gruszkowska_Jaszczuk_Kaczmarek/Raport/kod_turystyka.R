# --- Wykresy dotycz¹ce turystyki krajowej i zagranicznej ---

# --- loading packages ---
library(dplyr)
library(ggplot2)
library(rgdal)
library(ggmap)
library(broom)

# --- data aggregation ---

data <- read.csv("Noclegi_udzielone_turystom.csv" , sep = ';')

data %>% filter(Rok == 2019 & Miesi¹c %in% c("3", "4", "5", "6"), Rodzaj.obiektu.noclegowego == "ogó³em") %>% 
  select(Kraj.turysty, Wartoœæ, Miesi¹c) %>% 
  mutate(Wartoœæ = as.numeric(as.character(Wartoœæ))) -> data19

data19 = aggregate(data19$Wartoœæ, by=list(Kraje=data19$Kraj.turysty), FUN=sum)

data %>% filter(Rok == 2020 & Miesi¹c %in% c("3", "4", "5", "6"), Rodzaj.obiektu.noclegowego == "ogó³em") %>% 
  select(Kraj.turysty, Wartoœæ, Miesi¹c) %>% 
  mutate(Wartoœæ = as.numeric(as.character(Wartoœæ))) -> data20

data20 = aggregate(data20$Wartoœæ, by=list(Kraje=data20$Kraj.turysty), FUN=sum)

data_for_chart <- data.frame(kraj = data19$Kraje, t2019 = data19$x, t2020 = data20$x)
data_for_chart <- filter(data_for_chart, kraj != "Zagranica" & kraj != "Polska" & kraj != "Ogó³em" & kraj != "Niemcy"
               & t2019 >= 50000)

data_for_chart <- mutate(data_for_chart, spadek_procentowy = (t2019 - t2020)/t2019*100)

# --- plots ---

ggplot(data_for_chart, aes(y=kraj)) + 
  geom_point(aes(x = data_for_chart$t2020/1000, color = "2020"), size = 3, shape = I(15)) +
  geom_point(aes(x=data_for_chart$t2019/1000, color = "2019"), size = 3, shape = I(15)) +
  geom_segment(aes(x = data_for_chart$t2019/1000,
                   y = kraj,
                   xend = data_for_chart$t2020/1000,
                   yend = kraj),
               size = 1) +
  ylab("Kraj turysty") + xlab("Liczba turystów [tyœ]") +
  ggtitle("Ró¿nica w liczbie turystów odwiedzaj¹cych Polskê 
          \nw miesi¹cach marzec - czerwiec w latach 2019 i 2020")+
  labs(color = "Rok") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data_for_chart, aes(x = spadek_procentowy, y = kraj)) +
  geom_bar(stat = "identity", fill = "brown", color = "black", width=0.7) +
  ylab("Kraj turysty") + xlab("Spadek procentowy") +
  ggtitle("Spadek procentowy liczby turystów odwiedzaj¹cych Polskê 
          \nw miesi¹cach marzec - czerwiec w 2020 roku 
          \nw porównaniu do roku 2019") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
  
# ----------------------------------------------------------


# --- data aggregation ---

df17 <- read.csv("turysci17.csv" , sep = ';')
df18 <- read.csv("turysci18.csv" , sep = ';')
df19 <- read.csv("turysci19.csv" , sep = ';')
df20 <- read.csv("turysci20.csv" , sep = ';')
df_przypadki <- read.csv("przypadki.csv" , sep = ';')

colnames_ <- c("kod", "nazwa", "marzec", "kwiecien", "maj",
                    "czerwiec", "lipiec", "sierpien", "wrzesien", "cos")
kody <- c("02", "04", "06", "08", "10", "12",
          "14", "16", "18", "20", "22", "24", "26", "28", "30", "32")
long <- c(16.3, 18.5, 22.9, 15.2, 19.4, 20.3, 21.0, 17.9, 22.2, 22.9, 17.9, 19.0, 20.7, 20.7, 17.1, 15.4)
lat <- c(51.1, 53.0, 51.2, 52.1, 51.5, 49.7, 52.4, 50.6, 49.9, 53.2, 54.2, 50.4, 50.7, 53.8, 52.2, 53.5)

colnames(df17) <- colnames_
colnames(df18) <- colnames_
colnames(df19) <- colnames_
colnames(df20) <- colnames_

df17 <- mutate(df17, suma = marzec + kwiecien + maj + czerwiec + lipiec + sierpien + wrzesien )
df17 <- select(df17, c("nazwa", "suma"))
df18 <- mutate(df18, suma = marzec + kwiecien + maj + czerwiec + lipiec + sierpien + wrzesien )
df18 <- select(df18, c("nazwa", "suma"))
df19 <- mutate(df19, suma = marzec + kwiecien + maj + czerwiec + lipiec + sierpien + wrzesien )
df19 <- select(df19, c("nazwa", "suma"))
df20 <- mutate(df20, suma = marzec + kwiecien + maj + czerwiec + lipiec + sierpien + wrzesien )
df20 <- select(df20, c("nazwa", "suma"))

df_sr <- data.frame("nazwa" = df19$nazwa, srednia = (df19$suma +  df18$suma + df17$suma)/3)

df_przypadki <- cbind(df_przypadki, long, lat)
data_for_map <- data.frame(nazwa = df20$nazwa, spadek_procentowy = (df_sr$srednia - df20$suma)/df_sr$srednia*100, kod = kody)

wojewodztwa <- readOGR("Województwa.shp", "Województwa")
wojewodztwa <- spTransform(wojewodztwa, CRS("+init=epsg:4326"))

wojewodztwa_df <- tidy(wojewodztwa, region="JPT_KOD_JE")

mapki <- left_join(wojewodztwa_df,
                   data_for_map %>%
                     select(kod, nazwa, spadek_procentowy),
                   by=c("id"="kod"))

ggplot(mapki) +
  geom_polygon(aes(long, lat, group=group,  fill=spadek_procentowy), color="black") +
  scale_fill_gradient(low = "yellow", high = "red") +
  coord_map() +
  geom_point(data = df_przypadki, aes(long, lat, size = SUMA)) +
  scale_size(range = c(4,14)) +
  theme_void() +
  labs(fill="Spadek \nw procentach", size = "Liczba \nzachorowañ") +
  ggtitle(label = "Spadek liczby turystów w roku 2020 \nw porównaniu do œredniej z poprzednich 3 lat \nw poszczególnych województwach w miesi¹cach marzec - wrzesieñ", subtitle = "w odniesieniu do liczby zachorowañ w danych województwach") +
  theme(plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5))
