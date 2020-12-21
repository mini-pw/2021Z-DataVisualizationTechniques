library(ggplot2)

# wczytanie danych
df_2017 <- data.frame(miesiac = c("styczen", "luty", "marzec", "kwiecien", "maj", "czerwiec", "lipiec", "sierpien", "wrzesien"),
                      l_biletow_dl = c(497080, 418868, 457022, 418741, 459549, 389147, 374528, 398830, 432578),
                      l_biletow_jedn = c(1990344, 2399919, 2767695, 2731703, 2858958, 3002447, 2879621, 2982841, 2624369),
                      l_biletow_czas = c(2743248, 3254748, 3699459, 3630476, 3926011, 4043401, 3860454, 4176525, 3447325),
                      l_biletow_wszystkie = c(5365708, 6262848, 7133433, 6997985, 7513288, 7705856, 7410617, 7899219, 6708109))

df_2018 <- data.frame(miesiac = c("styczen", "luty", "marzec", "kwiecien", "maj", "czerwiec", "lipiec", "sierpien", "wrzesien"),
                      l_biletow_dl = c(498562, 415973, 430168, 447370, 425274, 394653, 388516, 391950, 442074),
                      l_biletow_jedn = c(2137639, 2307206, 2810794, 2688444, 2816230, 2644717, 2840715, 2768332, 2707566),
                      l_biletow_czas = c(3081365, 3244880, 3616377, 3762728, 3863155, 3741899, 3839056, 3886824, 3680825),
                      l_biletow_wszystkie = c(5856510, 6125454, 7037543, 7102156, 7341540, 6988259, 7340536, 7344414, 7040488))


df_2019 <- data.frame(miesiac = c("styczen", "luty", "marzec", "kwiecien", "maj", "czerwiec", "lipiec", "sierpien", "wrzesien"),
                      l_biletow_dl = c(491905, 430204, 458437, 437393, 450981, 387951, 403407, 409183, 471092),
                      l_biletow_jedn = c(2359610, 2286652, 2510213, 2736328, 2632765, 2710735, 2821868, 2870990, 2749657),
                      l_biletow_czas = c(3427220, 3289402, 3494849, 3922930, 3720401, 3704072, 3799334, 3905159, 3716242),
                      l_biletow_wszystkie = c(6425792, 6171158, 6629805, 7305451, 7011393, 7020085, 7284763, 7477625, 7141702))

df_2020 <- data.frame(miesiac = c("styczen", "luty", "marzec", "kwiecien", "maj", "czerwiec", "lipiec", "sierpien", "wrzesien"),
                      l_biletow_dl = c(510453, 444920, 269678, 85988, 171588, 214880, 207798, 264118, 318748),
                      l_biletow_jedn = c(2633615, 2413978, 1151986, 234553, 1133184, 2173193, 2717197, 2370797, 2564480),
                      l_biletow_czas = c(3663544, 3281702, 1627243, 288298, 1499562, 2912192, 3661179, 3292808, 3397818),
                      l_biletow_wszystkie = c(6969993, 6298759, 3106838, 614273, 2838232, 5401876, 6767131, 6100731, 6418385))


# polaczenie ramek danych z lat 2017-2019
df_years_bf <- data.frame()
df_years_bf <- data.frame(miesiac = c("styczen", "luty", "marzec", "kwiecien", "maj", "czerwiec", "lipiec", "sierpien", "wrzesien"),
                         l_biletow_dl = df_2017$l_biletow_dl, l_biletow_jedn = df_2017$l_biletow_jedn,
                         l_biletow_czas = df_2017$l_biletow_czas, l_biletow_wszystkie = df_2017$l_biletow_wszystkie,
                         rok = rep("2017", 9))

df_years_bf <- rbind(df_years_bf, data.frame(miesiac = c("styczen", "luty", "marzec", "kwiecien", "maj", "czerwiec", "lipiec", "sierpien", "wrzesien"),
                                             l_biletow_dl = df_2018$l_biletow_dl, l_biletow_jedn = df_2018$l_biletow_jedn,
                                             l_biletow_czas = df_2018$l_biletow_czas, l_biletow_wszystkie = df_2018$l_biletow_wszystkie,
                                             rok = rep("2018", 9)))
df_years_bf <- rbind(df_years_bf, data.frame(miesiac = c("styczen", "luty", "marzec", "kwiecien", "maj", "czerwiec", "lipiec", "sierpien", "wrzesien"),
                                             l_biletow_dl = df_2019$l_biletow_dl, l_biletow_jedn = df_2019$l_biletow_jedn,
                                             l_biletow_czas = df_2019$l_biletow_czas, l_biletow_wszystkie = df_2019$l_biletow_wszystkie,
                                             rok = rep("2019", 9)))
df_years_bf <- cbind(df_years_bf, miesiac_num=rep(1:9, 3))


library(dplyr)

df_years_bf <- df_years_bf %>%
  mutate(l_biletow_kr = l_biletow_jedn + l_biletow_czas)

# procentowy udzial

df_proc_2020 <- df_2020 %>%
  mutate(proc_biletow_dl = l_biletow_dl/l_biletow_wszystkie * 100, 
         proc_biletow_kr = (l_biletow_jedn + l_biletow_czas)/l_biletow_wszystkie * 100, 
         miesiac_num = c(1:9), rok = rep("2020", 9)) %>%
  select(miesiac_num, proc_biletow_dl, proc_biletow_kr, rok)

df_sum <- df_years_bf %>%
  group_by(miesiac_num) %>%
  summarise(suma_biletow_dl = sum(l_biletow_dl), 
            suma_biletow_kr = sum(l_biletow_kr),
            suma_biletow_wszystkie = sum(l_biletow_wszystkie))
df_sum <- cbind(df_sum, rok = rep("Average"))

df_proc_bf <- df_sum %>%
  mutate(proc_biletow_dl = suma_biletow_dl/suma_biletow_wszystkie * 100, 
            proc_biletow_kr = suma_biletow_kr/suma_biletow_wszystkie * 100) %>%
  select(miesiac_num, proc_biletow_dl, proc_biletow_kr, rok)


df_proc_all <- rbind(df_proc_bf, df_proc_2020)


### RYSOWANIE WYKRESU
## czcionka
library(showtext)
fam <- "Aleo"
font_add_google(name = "Aleo", family = fam)

showtext_auto()

month = seq(as.Date("2020/1/1"), as.Date("2020/9/1"), "months")
df_proc_all <- cbind(df_proc_all, month)

col_1 <- "#324376"
w2 <- ggplot(df_proc_all,aes(x=miesiac_num, y=proc_biletow_kr ,group=rok, color=rok)) +
  scale_x_discrete(limits = 1:9) +
  scale_y_continuous(limits = c(80, 100)) +
  geom_line(size=1)+
  theme_minimal() +
  theme(
    text = element_text(size = 40, family = fam),
    
    plot.title = element_text(lineheight = 0.2),
    
    # schowanie siatki
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    
    # ustawienie czarnych linii z lewej i z dolu
    axis.line = element_line(colour = "black", linetype = "solid"),
    
    # dodanie kreseczek
    axis.ticks = element_line(colour = "black"),
    
    # formatowanie legendy
    legend.title = element_blank(), # bez tytulu
    legend.position = c(0.9,0.9), # pozycja prawy gorny rog
    legend.text = element_text(margin = margin(l = -0.5, unit = "cm"), size = 35, face = "bold"), # odlegosc miedzy znakiem linii a podpisem
    legend.key.size = unit(1, 'lines'), # dlugosc linii
    legend.key.height = unit(0.5, 'line') # wysokosc zanku w legendzie
  ) +
  ggtitle("Percentage share of single ZTM tickets\nin Warsaw in 2020 in comparison to average 2017-2019") +
  xlab("month") +
  ylab("%") +
  scale_colour_manual(values = c(col_1, "#e5383b")) + 
  # strzaleczki 
  geom_segment(aes(x = 2, y = 85, xend = 3.2, yend = 87),
               lineend = "round", # See available arrow types in example above
               linejoin = "round",
               size = 0.5, 
               arrow = arrow(length = unit(0.2, "cm")),
               show.legend = FALSE) +
  geom_segment(aes(x = 3.2, y = 81, xend = 3.5, yend = 86),
               lineend = "round", # See available arrow types in example above
               linejoin = "mitre",
               size = 0.5, 
               arrow = arrow(length = unit(0.2, "cm")),
               show.legend = FALSE) + 
  geom_segment(aes(x = 5.5, y = 84.5, xend = 4.8, yend = 89.5),
               lineend = "round", # See available arrow types in example above
               linejoin = "mitre",
               size = 0.5, 
               arrow = arrow(length = unit(0.2, "cm")),
               show.legend = FALSE) + 
  # podpisy do strzalek
  geom_text(aes(x=3.2, y=80.5, label="25.03 Public transport restrictions"),
            color=col_1, 
            size=12,
            family = fam) +
  geom_text(aes(x=2, y=84.5, label="12.03 Closing schools"),
            color=col_1, 
            size=12,
            family = fam) + 
  geom_text(aes(x=5.5, y=84, label="20.04 Loosening the restrictions"), 
            color=col_1, 
            size=12,
            family = fam)
ggsave("w2_proc.png", plot=w2, dpi=500, units = ("cm"), width = 12, height = 8)

###################################################### ADA
pasazerowie <- read.csv("pasazerowie.csv")
p <- ggplot(data=pasazerowie, aes(x=miesiace, y=liczba_pasazerow, group=rok, color=rok)) +
  scale_x_discrete(limits = 1:12) +
  geom_line(size=0.6)+
  theme_minimal()+
  ggtitle("Statistics on rail passenger transport in Poland") +
  labs(col = "year") +
  xlab("month") +
  ylab("number of passengers [mln]") + 
  
  theme_minimal() +
  theme(
    # text = element_text(size = 30, family = fam),
    
    plot.title = element_text(lineheight = 0.18),
    text = element_text(size = 40, family = fam),
    
    # schowanie siatki
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    
    # ustawienie czarnych linii z lewej i z dolu
    axis.line = element_line(colour = "black", linetype = "solid"),
    
    # dodanie kreseczek
    axis.ticks = element_line(colour = "black"),
    
    # formatowanie legendy
    # legend.position = c(0.9,0.9), # pozycja prawy gorny rog
    legend.key.size = unit(0.8, 'lines'), # dlugosc linii
    legend.key.height = unit(0.8, 'line') # wysokosc zanku w legendzie
  ) +

# 12 marca - zawieszenie zajÄ™Ä‡ dydaktycznych - schools closure
# 20 marca - lockdown
# 17 paÅºdziernika - 50% miejsc
 
  geom_text(aes(x=2.5, y=2, label="20.03 Lockdown"),
            color="black", 
            size=12,
            family = fam) + 
  geom_segment(aes(x = 2.5, y = 2.5, xend = 3.6, yend = 7),
               lineend = "round", # See available arrow types in example above
               linejoin = "round",
               size = 0.5, 
               color = "black",
               arrow = arrow(length = unit(0.2, "cm")),
               show.legend = FALSE) 
 


p
ggsave("w1_proc.png", plot=p, dpi=500, units = ("cm"), width = 12, height = 8)
##################################################### TOMEK
d1 <- data.frame(
  months = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov"),
  price = c(4.066, 3.831, 3.226,  2.914, 3.16, 3.439, 3.594, 3.502, 3.448, 3.445, 3.449))

d2 <- data.frame(
  months = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov"),
  price = c(3.718, 3.558, 3.599, 3.809, 3.876, 3.814, 3.804, 3.78, 3.815, 3.784, 3.885))

d1$months <- factor(d1$months, 
                    levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov"))
d2$months <- factor(d1$months, 
                    levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov"))

d1 <- cbind(d1, rep(2020, 11))
d2 <- cbind(d2, rep("Average", 11))


colnames(d1) <- c("months", "price", "year")
colnames(d2) <- c("months", "price", "year")

d_merge <- rbind(d1, d2)
d_merge
d_merge <- cbind(d_merge, month_num=rep(1:11, 2))
d_merge$month_num <- as.factor(d_merge$month_num)


showtext_auto()

blank_theme <- theme_minimal()+
  theme(
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )


w4 <- ggplot(data = d_merge, aes(x = month_num, y = price, group = year, color = year)) + ylim(0,5) +
  geom_line(size=1) + theme_minimal() +
  theme(axis.text.x= element_text(c(1,2,3,4,5,6,7,8,9,10,11))) +
  theme(
    
    text = element_text(size = 40, family = fam),
    
    plot.title = element_text(lineheight = 0.2),
    
    # schowanie siatki
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    
    # ustawienie czarnych linii z lewej i z dolu
    axis.line = element_line(colour = "black", linetype = "solid"),
    
    # dodanie kreseczek
    axis.ticks = element_line(colour = "black"),
    
    # formatowanie legendy
    legend.title = element_blank(), # bez tytulu
    legend.position = c(0.9,0.9), # pozycja prawy gorny rog
    legend.text = element_text(margin = margin(l = -0.5, unit = "cm"), size = 35, face = "bold"), # odlegosc miedzy znakiem linii a podpisem
    legend.key.size = unit(1, 'lines'), # dlugosc linii
    legend.key.height = unit(0.5, 'line') # wysokosc zanku w legendzie
  ) + 
  ggtitle("Gas prices in 2020 and its average in 2016-2019 in Poland") +
  xlab("month") +
  ylab("price in PLN") + scale_colour_manual(values = c("#e5383b", col_1))+
  # strzaleczki 
  geom_segment(aes(x = 2, y = 1.5, xend = 3.1, yend = 3.1),
               lineend = "round", # See available arrow types in example above
               linejoin = "round",
               size = 0.5, 
               colour = "#e5383b",
               arrow = arrow(length = unit(0.2, "cm")),
               show.legend = FALSE)+
  geom_segment(aes(x = 5, y = 1.5, xend = 3.7, yend = 2.9),
               lineend = "round", # See available arrow types in example above
               linejoin = "round",
               size = 0.5, 
               colour = "#e5383b",
               arrow = arrow(length = unit(0.2, "cm")),
               show.legend = FALSE) +
  # podpisy do strzalek
  geom_text(aes(x=2, y=1.3, label="02.03 flight restriction"),
            color=col_2, 
            size=12,
            family = fam) +
  geom_text(aes(x=5, y=1.3, label="20.03 lockdown"),
            color=col_2, 
            size=12,
            family = fam)


ggsave("w_tomek.png", plot=w4, dpi=500, units = ("cm"), width = 12, height = 8)

######################################### KUBA
library(tidyverse)


df <- read.csv("Turystyka_final.csv", sep = ";", encoding = "UTF-8")
df <- df %>%
  select(Miesi¹ce, Wartosc, Rok)
df$Wartosc <- df$Wartosc/1000000
df$Miesi¹ce[df$Miesi¹ce == "styczeñ"] <- 1
df$Miesi¹ce[df$Miesi¹ce == "luty"] <- 2
df$Miesi¹ce[df$Miesi¹ce == "marzec"] <- 3
df$Miesi¹ce[df$Miesi¹ce == "kwiecieñ"] <- 4
df$Miesi¹ce[df$Miesi¹ce == "maj"] <- 5
df$Miesi¹ce[df$Miesi¹ce == "czerwiec"] <- 6
df$Miesi¹ce[df$Miesi¹ce == "lipiec"] <- 7
df$Miesi¹ce[df$Miesi¹ce == "sierpieñ"] <- 8
df$Miesi¹ce[df$Miesi¹ce == "wrzesieñ"] <- 9
df$Miesi¹ce[df$Miesi¹ce == "paÅºdziernik"] <- 10
df$Miesi¹ce[df$Miesi¹ce == "listopad"] <- 11
df$Miesi¹ce[df$Miesi¹ce == "grudzieñ"] <- 12
df$Miesi¹ce <- factor(df$Miesi¹ce, levels = c(1,2,3,4,5,6,7,8,9,10,11,12))
col_1 <- "#324376"
col_2 <- "#e5383b"
p4 <- ggplot(data=df,aes(x=Miesi¹ce,y=Wartosc,group=Rok,color=Rok)) +
  scale_x_discrete(limits = 1:12) +
  geom_line(size=0.6)+
  theme_minimal()+
  ggtitle("Statistics of tourists renting rooms in tourist facilities") +
  labs(col = "year") +
  xlab("month") +
  ylab("number of tourists [mln]") +
  
  theme_minimal() +
  theme(
    # text = element_text(size = 30, family = fam),
    
    plot.title = element_text(lineheight = 0.18),
    text = element_text(size = 40, family = fam),
    
    # schowanie siatki
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    
    # ustawienie czarnych linii z lewej i z dolu
    axis.line = element_line(colour = "black", linetype = "solid"),
    
    # dodanie kreseczek
    axis.ticks = element_line(colour = "black"),
    
    # formatowanie legendy
    # legend.position = c(0.9,0.9), # pozycja prawy gorny rog
    legend.key.size = unit(0.8, 'lines'), # dlugosc linii
    legend.key.height = unit(0.8, 'line') # wysokosc zanku w legendzie
  ) + 
  geom_text(aes(x=2.2, y=0.5, label="20.03 Lockdown"),
            color="black", 
            size=12,
            family = fam) + 
  geom_segment(aes(x = 2.2, y = 0.4, xend = 3.6, yend = 0.2),
               lineend = "round", # See available arrow types in example above
               linejoin = "round",
               size = 0.5, 
               color = "black",
               arrow = arrow(length = unit(0.2, "cm")),
               show.legend = FALSE) 

ggsave("w_kuba.png", plot=p4, dpi=500, units = ("cm"), width = 12, height = 8)