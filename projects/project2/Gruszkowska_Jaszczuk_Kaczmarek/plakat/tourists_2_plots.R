# --- Wykresy dotycz¹ce turystyki krajowej i zagranicznej ---

# --- loading packages ---
library(dplyr)
library(ggplot2)
library(rgdal)
library(ggmap)
library(broom)

library(plotly)
library(dplyr)
library(tidyr)

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

data_for_chart <- data.frame(kraj = data19$Kraje, t2019 = data19$x, t2020 = data20$x, roznica = data19$x - data20$x)
data_for_chart <- filter(data_for_chart, kraj != "Zagranica" & kraj != "Polska" & kraj != "Ogó³em" & kraj != "Niemcy"
               & t2019 >= 50000)

countries <- c("Belgium", "Belarus", "China", "Czech Republic", " Denmark", 
               "Finland", "France", "Spain", "Netherlands", "Israel", "Lithuania", "Norway",
               "Russia", "Slovakia", "Sweden", "Ukraine", "USA", "Hungary", "UK", "Italy")

data_for_chart <- mutate(data_for_chart, kraj = countries)
data_for_chart
# --- plots ---

p <- ggplot(data_for_chart, aes(y=reorder(kraj, roznica))) + 
  geom_point(aes(x = data_for_chart$t2020/1000, color = "2020"), size = 3, shape = I(15)) +
  geom_point(aes(x=data_for_chart$t2019/1000, color = "2019"), size = 3, shape = I(15)) +
  geom_segment(aes(x = data_for_chart$t2019/1000,
                   y = kraj,
                   xend = data_for_chart$t2020/1000,
                   yend = kraj),
               size = 1, color = "white") +
  ylab("Tourist country") + xlab("Number of tourists in thousands") +
  ggtitle("Difference in number of tourists \nvisiting Poland")+
  labs(color = "Year") +
  xlim(c(0,605)) +
  theme_minimal() +
  theme(legend.position = c(0.8,0.2), 
        axis.text.x = element_text(size=15, color = "orange"),
        axis.text.y = element_text(size=15, color = "orange"),
        axis.title.x = element_text(size = 15, face = "bold", color = "orange"),
        axis.title.y = element_text(size = 15, face = "bold", color = "orange"),
        plot.title = element_text(hjust = 0.5, color = "orange", face = "bold", size = 30),
        legend.title = element_text(size = 15, face = "bold", color = "orange"),
        legend.text = element_text(size = 15, face = "bold", color = "orange"),
        panel.background = element_rect(fill = '#2e2b2b', colour = 'orange'),
        plot.background = element_rect(fill="#2e2b2b"),
        panel.grid.major = element_line(colour = "orange"),
        panel.grid.minor = element_line(colour = "orange"),
        legend.background = element_rect(fill = '#2e2b2b', color = "black"))
p

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
lat <- c(51.1, 53.1, 51.2, 52.1, 51.6, 49.9, 52.4, 50.6, 49.9, 53.2, 54.2, 50.4, 50.7, 53.8, 52.2, 53.5)
zal_woj <- c(2904207, 2086210, 2139726, 1018075, 2493603, 3372618,
             5349114, 996011, 2127657, 1188800, 2307710, 4570849,
             1257179, 1439675, 3475323, 1710482)

stosunek <- cbind(zal_woj, suma = df_przypadki$SUMA, woj = df19$nazwa)
stosunek <- as.data.frame(stosunek)
stosunek <- mutate(stosunek, stosunek = round(suma/zal_woj*100000))

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

data_for_map <- data.frame(nazwa = df20$nazwa, spadek_procentowy = (df_sr$srednia - df20$suma)/df_sr$srednia*100, kod = kody)

wojewodztwa <- readOGR("Województwa.shp", "Województwa")
wojewodztwa <- spTransform(wojewodztwa, CRS("+init=epsg:4326"))

wojewodztwa_df <- tidy(wojewodztwa, region="JPT_KOD_JE")

mapki <- left_join(wojewodztwa_df,
                   data_for_map %>%
                     select(kod, nazwa, spadek_procentowy),
                   by=c("id"="kod"))
stosunek
ggplot(mapki) +
  geom_polygon(aes(long, lat, group=group,  fill=spadek_procentowy), color="black") +
  scale_fill_gradient(low = "yellow", high = "red") +
  coord_map() +
  annotate("text", x = long, y = lat, label = stosunek[[3]], size = 8, color = "black") +
  theme_void() +
  labs(fill="Percentage \ndecrease") +
  ggtitle(label = "Decrease in number of tourists in 2020", subtitle = "in relation to the number of cases per 100,000 inhabitants") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 30, color = "orange"),
        plot.subtitle = element_text(hjust = 0.5, face = "bold", size = 16, color = "orange"),
        legend.title = element_text(hjust = 0.5, size = 14, face = "bold", color = "orange"),
        legend.box = "horizontal", legend.position="bottom",
        legend.text = element_text(size = 12, color = "orange"),
        plot.background = element_rect(fill = "#2e2b2b"),
        panel.background = element_rect(fill = "#2e2b2b"))


