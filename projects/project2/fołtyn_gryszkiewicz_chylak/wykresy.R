library(ggplot2)
library(ggrepel)
library(dplyr)


wojewodztwa = c("dolnolaskie", "kujawsko-pomorskie", "lubelskie", "lubuskie", "lodzkie", "malopolskie", "mazowieckie",
                "opolskie", "podkarpackie", "podlaskie", "pomorskie", "slaskie", "swietokrzyskie", "warminsko-mazurskie",
                "wielkopolskie", "zachodniopomorskie")
suma_zakazen = c(63266, 49675, 44878, 19107, 59414, 91340, 107823, 25936, 47606, 23606, 49683, 118593, 28315, 26667,
                 88839, 32344)
uczestnicy_imprez_2019 = c(2403467, 2075106, 1022428, 674835, 1780652, 2606796, 3849989, 455024, 892136, 556864, 2603589,
                           4339302, 677772, 576739, 2388898, 922965)
przewozy_pasazerskie_na_1_mieszkanca_2019 = c(89.83, 83.97, 69.45, 42.94, 104.02, 133.69, 189.62, 27.12, 34.22,
                                              81.90, 128.11, 82.96, 37.42, 45.86, 88.46, 124.18)
populacja_2019 = c(2900163, 2072373, 2108270, 1011592, 2454779, 3410901, 5423168, 982626,
                   2127164, 1178353, 2343928, 4517635, 1233961, 1422737, 3498733, 1696193)
lozka = c(3170, 2152, 2401, 1160, 3059, 3637, 5377, 1138, 2288, 1653, 1783, 3807, 1636, 1177, 3245, 1541)
hospitalizowani = c(1539, 1255, 1475, 699, 1517, 1557, 2902, 667, 1145, 788, 1103, 1986, 823, 760, 1891, 952)
bezrobocie_stan_do_konca_czerwca_2020 = c(69076, 72133, 75733, 23529, 67236, 79677, 143052, 24999, 86159, 37280, 52341, 86784, 45778, 52928, 59978, 49788)
bezrobocie_stan_do_konca_czerwca_2019 = c(57718, 64660, 68057, 19507, 61314, 64076, 126653, 20166, 74684, 33262, 41845, 72409, 40556, 45114, 46220, 40852)
populacja_2020 = c(2898525,  2069273, 2103342,  1010177, 2448713, 3413931, 5428031, 980771,2125901,1176576,2346717, 4508078,1230044,1420514,3500361,1693219)
bezrobocie_na_populacje_2020 <- (bezrobocie_stan_do_konca_czerwca_2020 / populacja_2020) * 100
bezrobocie_na_populacje_2019 <- (bezrobocie_stan_do_konca_czerwca_2019 / populacja_2019) * 100
uczetnicy_na_populacje <- (uczestnicy_imprez_2019 / populacja_2019)
suma_zakazen_czerwiec = c(2919, 672, 650, 151, 3124, 1745, 5023, 941, 649, 843, 667, 12686, 798, 244, 2669, 611)
bezrobocie_roznica <- (bezrobocie_stan_do_konca_czerwca_2020 - bezrobocie_stan_do_konca_czerwca_2019)
zakazenia_per_capita_czerwiec <- suma_zakazen_czerwiec/populacja_2019
bezrobocie_roznica_per_capita <- bezrobocie_roznica/populacja_2019
suma_zakazen_czerwiec_percapita <- suma_zakazen_czerwiec / populacja_2020
per_capita_zak = suma_zakazen / populacja_2020
per_capita_loz = lozka / populacja_2020
hotele_2019 <- c(353942, 132194, 111581, 67018, 144417, 515068, 541250, 40359, 128797, 65056, 290319, 271776, 62058, 137132, 203263, 283613)
hotele_2020 <- c(272698, 90572, 81344, 48912, 72399, 274651, 244200, 28708, 93700, 45339, 238613, 167063, 45078, 108831, 119146, 262753)
suma_zakazen_wrzesien <- c(5163, 2685, 2685, 1018, 6725, 11216, 12740, 2361, 3885, 2054, 4950, 22619, 2118, 1643, 7812, 1811)
wrzesien_per_capita <- suma_zakazen_wrzesien / populacja_2020
hotele_zmiana <- hotele_2020/hotele_2019 * 100


DF = data.frame(suma_zakazen, wojewodztwa, uczestnicy_imprez_2019, przewozy_pasazerskie_na_1_mieszkanca_2019, populacja_2019, lozka, hospitalizowani, bezrobocie_stan_do_konca_czerwca_2020, bezrobocie_stan_do_konca_czerwca_2019, populacja_2020,bezrobocie_na_populacje_2020, bezrobocie_na_populacje_2019, uczetnicy_na_populacje, suma_zakazen_czerwiec, bezrobocie_roznica, 
                zakazenia_per_capita_czerwiec, bezrobocie_roznica_per_capita, suma_zakazen_czerwiec_percapita, per_capita_zak, per_capita_loz, wrzesien_per_capita, hotele_zmiana)
DF$wojewodztwa <- factor(wojewodztwa, levels = (c("dolnolaskie", "kujawsko-pomorskie", "lubelskie", "lubuskie", "lodzkie", "malopolskie", "mazowieckie",
                                                  "opolskie", "podkarpackie", "podlaskie", "pomorskie", "slaskie", "swietokrzyskie", "warminsko-mazurskie",
                                                  "wielkopolskie", "zachodniopomorskie")))
DF <- DF %>% mutate (plotlabel = c("DS", "KP", "LD", "LB", "LS", "MP", "MZ", "OP", "PK", "PL",
                                   "PM", "SL", "SK", "WM", "WP", "ZP"))

ggplot(data = DF, aes(x= zakazenia_per_capita_czerwiec, y = bezrobocie_roznica_per_capita, color = wojewodztwa, group = 1, label = plotlabel)) + 
  geom_point(size = 3) +
  geom_smooth(method = lm, se= FALSE, show.legend = FALSE) +
  geom_text_repel(show.legend = FALSE) +
  labs(x = "Zakazeni per capita - czerwiec 2020", y = "Wzrost bezrobocia per capita - 2019/2020") + 
  theme_bw() + 
  guides(colour = guide_legend(override.aes = list(size=5)))

ggplot(data = DF, aes(x= uczetnicy_na_populacje, y = per_capita_zak, color = wojewodztwa, label = plotlabel, group = 1 )) + 
  geom_point(aes(size = populacja_2020))  +
  geom_text_repel(show.legend = FALSE) +
  labs(x = "Uczestnicy imprez per capita", y = "Liczba zakazen per capita") + 
  guides(size = FALSE, colour = guide_legend(override.aes = list(size=5))) + 
  geom_smooth(method = lm, se= FALSE, show.legend = FALSE) +
  theme_bw()

ggplot(data = DF, aes(x= przewozy_pasazerskie_na_1_mieszkanca_2019, y = per_capita_zak, color = wojewodztwa, label = plotlabel, group = 1 )) + 
  geom_point(aes(size = populacja_2020))  +
  geom_text_repel(show.legend = FALSE) +
  theme_bw() + 
  labs(x = "Przewozy pasazerskie per capita", y = "Liczba zakazen per capita") + 
  guides(size = FALSE, colour = guide_legend(override.aes = list(size=5))) + 
  geom_smooth(method = lm, se= FALSE, show.legend = FALSE)

ggplot(data = DF, aes(y= hotele_zmiana, x = wrzesien_per_capita, color = wojewodztwa, label = plotlabel, group = 1 )) + 
  geom_point(aes(size = populacja_2020))  +
  geom_text_repel(show.legend = FALSE) + scale_y_continuous(labels = scales::percent) +
  theme_bw() + 
  labs(y = "Ilosc uzytkowników hoteli w 2020 w stosunku do 2019", x = "Liczba zakazen we wrzesniu per capita") + guides(size = FALSE, colour = guide_legend(override.aes = list(size=5))) +
  geom_smooth(method = lm, se= FALSE, show.legend = FALSE)
