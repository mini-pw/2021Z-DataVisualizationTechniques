library(ggridges)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(ggrepel)
library(lubridate)

#Zbiory danych
df1 <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv")
gni <- read_excel("gni.xls") #link do źródła danych na plakacie; załączony arkusz jest fragmentem z oryginalnego pliku
groups <- read_excel("CLASS.xls", "Groups") #link do źródła danych na plakacie
gdp <- read_excel("gdp_change.xls") #link do źródła danych na plakacie

#Początkowa obróbka - połączenie ramek
groups %>%  filter (GroupName %in% c("High income", "Lower middle income", "Low income", "Upper middle income")) %>% 
  select("CountryCode", "GroupName", "CountryName") -> groups

names(df1)[names(df1) == "iso_code"] <- "code"
names(groups)[names(groups) == "CountryCode"] <- "code"    

df <- groups %>% left_join(df1, by = "code") %>% 
  left_join(gni, by = "code")

df$GroupName <- factor(df$GroupName, levels = c("Low income", "Lower middle income", "Upper middle income","High income"), ordered = TRUE)

#Wykres 1 - distribution of GNI
#dowolna data - na wykresie i tak nie korzystamy z danych COVIDowych
df %>% filter(date == "2020-11-30") -> df1

ggplot(df1, aes(x = gnipc, y = GroupName, fill = GroupName)) +
  geom_density_ridges(jittered_points = TRUE,
                      alpha = 0.8, scale = 1) +
  scale_fill_manual(values = rev(c("#512179", "#0085AD", "#ED8B00", "#A6192E"))) + 
  theme_ridges() + 
  theme_minimal() + 
  theme(legend.position = "none") +
  theme(panel.grid = element_blank(), panel.background = element_blank(), 
        plot.title = element_text(hjust = 0.4, face = "bold", size=16, color ="#154042")) +
  scale_x_log10(breaks = c(1000, 10000, 100000), labels = c("1 000", "10 000", "100 000"), expand=c(0,0)) +
  scale_y_discrete(limits = rev(levels(df1$GroupName)), expand = c(0,0.2)) +
  xlab("Gross National Income per capita in current USD
       (logarithmic scale)") +
  ylab("Country groups by income") + 
  ggtitle("GNI per capita distribution") +
  theme(axis.text = element_text(size=14, color = "#154042"),
        axis.title.x = element_text(size = 14, color ="#154042"),
        axis.title.y = element_text(size = 14, color ="#154042"),
        legend.text = element_text(size = 14, color ="#154042"),
        legend.title = element_text(size = 14, color ="#154042")) -> p1
ggsave("gni.png", p1, bg = "transparent", width = 10, height = 6)


#Wykres 2 - case fatality rate
#Kraje zgrupowane od momentu kiedy dla grupy było łączne 5000 przypadków. 
df %>% select(GroupName, date, total_deaths, total_cases) %>% 
  group_by(GroupName, date) %>% 
  summarise(deaths = sum(total_deaths, na.rm = TRUE), cases= sum(total_cases, na.rm = TRUE)) %>% 
  filter(cases > 5000) %>% 
  mutate(fatality_rate = deaths/cases) -> df2

#Wybór po 5 krajów spośród HICs i LICs
df %>% select(CountryName, GroupName, date, total_deaths, total_cases) %>% 
  filter(date == "2020-11-30") %>% 
  group_by(GroupName) %>% 
  slice_max(order_by = total_cases, n = 5) %>% 
  pull(CountryName) -> countries

df %>% select(CountryName, GroupName, date, total_deaths, total_cases) %>% 
  filter(CountryName %in% countries, GroupName %in% c("Low income", "High income"), total_cases > 1000) %>% 
  mutate(fatality_rate = total_deaths/total_cases) -> df2b

ggplot() +
  geom_line(data = df2, aes(x = as.Date(date), y = fatality_rate, color = GroupName), size = 1.7) +
  geom_line(data = df2b, aes(x = as.Date(date), y= fatality_rate, fill = CountryName, color = GroupName), alpha = 0.3) +
  scale_color_manual(name = "Country groups", values = rev(c("#512179", "#0085AD", "#ED8B00", "#A6192E"))) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b") + 
  scale_y_continuous(breaks = c(0, 0.04, 0.08, 0.12, 0.16), labels = c("0%","4%", "8%", "12%", "16%")) +
  theme_minimal() + 
  theme(legend.position = "bottom") +
  guides(color=guide_legend(nrow=2,byrow=TRUE)) + 
  theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(color = "grey"),
        plot.title = element_text(hjust = 0.5, face = "bold", size=20, color = "#154042"),
        panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA)) +
  xlab("Date (Year 2020)") +
  ylab("Case fatality rate") + 
  ggtitle("Case Fatality Rate (CFR) over time") +
  theme(axis.text = element_text(size=20, color = "#154042"),
        axis.title.x = element_text(size = 20, color ="#154042"),
        axis.title.y = element_text(size = 20, color ="#154042"),
        legend.text = element_text(size = 20, color ="#154042"),
        legend.title = element_text(size = 20, color ="#154042")) -> p2
 
#Dane do strzałek 
df2b %>% group_by(CountryName) %>% slice_max(order_by = fatality_rate, n = 1)

ggsave("cfr.png", p2, bg = "transparent", width = 15, height = 8)


#Wykres 3 - number of deaths - ostatecznie nie znalazł się na plakacie
df %>% select(CountryName, GroupName, date,total_deaths_per_million, total_cases) %>% 
  filter(date == "2020-11-30", total_cases > 1000) %>% 
  mutate(label = ifelse(GroupName == "Lower middle income", ifelse(total_deaths_per_million > 500, CountryName, ""),
                        ifelse(total_deaths_per_million > 940, CountryName, ""))) -> df3

ggplot(df3, aes(x = GroupName, y = total_deaths_per_million, color = GroupName, label = label)) +
  geom_jitter(position=position_jitter(0.2), cex=1.2) +
  scale_color_manual(name = "Country groups", values = rev(c("#512179", "#0085AD", "#ED8B00", "#A6192E"))) +
  theme_minimal() + 
  theme(legend.position = "none") +
  theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(color = "grey"),
        plot.title = element_text(hjust = 0.5, face = "bold", size=16, color = "#154042"),
        panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA)) +
  xlab("Country groups")+
  ylab("Number of deaths per million citizens") + 
  ggtitle("Number of deaths by income") +
  theme(axis.text = element_text(size=14, color = "#154042"),
        axis.title.x = element_text(size = 14, color ="#154042"),
        axis.title.y = element_text(size = 14, color ="#154042"),
        legend.text = element_text(size = 14, color ="#154042"),
        legend.title = element_text(size = 14, color ="#154042")) +
  geom_text_repel(size = 5) -> p3

ggsave("deaths.png", p3, bg = "transparent", width = 10, height = 8)


#Wykres 4 - GDP change
#Wybór po 15 krajów z każdej grupy, które mają najwięcej przypadków na milion mieszkańców
df %>% filter(date == "2020-11-30") %>% 
  select(date, CountryName, GroupName, total_cases_per_million, total_deaths_per_million) %>% 
  inner_join(gdp, on = "CountryName")  %>% 
  mutate(gdpchange = as.numeric(change)) %>% 
  group_by(GroupName) %>% 
  slice_max(order_by = total_cases_per_million, n = 15) -> df4

df %>% filter(date == "2020-11-30") %>% 
  select(date, CountryName, GroupName, total_cases, total_deaths, population) %>% 
  inner_join(gdp, on = "CountryName")  %>% 
  mutate(gdpchange = as.numeric(change)) %>% 
  na.omit() %>% 
  group_by(GroupName) %>% 
  summarise(gdpchange = mean(gdpchange), total_cases_per_million = sum(total_cases)/sum(population) * 1000000, 
            total_deaths_per_million = sum(total_deaths)/sum(population)* 1000000) -> df4b

ggplot(df4, aes(x = gdpchange, y = total_deaths_per_million, size = total_cases_per_million, color = GroupName)) +
  geom_point( alpha = 0.4) +
  geom_point(data = df4b, aes(x = gdpchange, y = total_deaths_per_million, size = total_cases_per_million, color = GroupName)) +
  scale_color_manual(name = "Country groups", values = rev(c("#512179", "#0085AD", "#ED8B00", "#A6192E"))) +
  scale_size(range = c(.1, 15), name="Total cases per million") + 
  theme_minimal() +
  theme(legend.position="bottom", legend.box="vertical", legend.margin=margin()) +
  guides(color=guide_legend(nrow=2, byrow=TRUE, override.aes = list(size=10))) +
  scale_x_continuous(limits = c(-15, 2), breaks = seq(-15, 5, 5), labels = paste(seq(-15, 5, 5), "%", sep = "")) +
  theme(panel.grid.minor = element_line(color = "grey"),
        panel.grid.major = element_line(color = "grey"),
        plot.title = element_text(hjust = 0.5, face = "bold", size=16, color = "#154042"),
        panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA)) +
  xlab("GDP change in 2020")+
  ylab("Number of deaths per million citizens") + 
  ggtitle("GDP change and Covid-19 stats") +
  theme(axis.text = element_text(size=18, color = "#154042"),
        axis.title.x = element_text(size = 18, color ="#154042"),
        axis.title.y = element_text(size = 18, color ="#154042"),
        legend.text = element_text(size = 18, color ="#154042"),
        legend.title = element_text(size = 18, color ="#154042")) -> p4

ggsave("bubble.png", p4, bg = "transparent", width = 15, height = 9)


#Wykres 5 - waves
#Przygotowanie danych - która fala gorsza w jakim państwie, zgrupowanie i obliczenie procentów + przygotowanie labeli
df %>% mutate(date = as.Date(date)) %>% 
  mutate(year = year(date), month = month(date)) %>% 
  filter(year ==2020) %>% 
  mutate(wave = ifelse(month <= 8, "first_wave", "sec_wave")) %>% 
  group_by(CountryName, GroupName, wave) %>% 
  summarise(max_new_cases = max(new_cases_smoothed_per_million, na.rm = TRUE)) %>% 
  pivot_wider(names_from = wave, values_from = max_new_cases) %>% 
  mutate(worse_wave = ifelse(abs(first_wave - sec_wave) <= 0.25 * min(first_wave, sec_wave, na.rm = TRUE), "similar", 
                             ifelse(first_wave >= sec_wave, "1st wave", "2nd wave"))) %>% 
  na.omit() %>% 
  group_by(GroupName, worse_wave) %>% 
  count() %>% 
  mutate(worse_wave = factor(worse_wave, levels = c("1st wave", "similar", "2nd wave"))) %>% 
  group_by(GroupName) %>% arrange(GroupName, worse_wave) %>% 
  mutate(pct = n/sum(n), pos = 1 - (cumsum(pct) - 0.5*pct)/sum(pct)) -> df5


ggplot(df5, aes(x = GroupName, y=pct, fill=worse_wave, label = scales::percent(pct, accuracy = 0.01))) + 
  geom_bar(position="fill", stat="identity", width = 0.75, size = 1.02, color = "black") +
  geom_text(aes(x = GroupName, y = pos), size = 6, color = "white") +
  theme_minimal() + 
  theme(legend.position="bottom", legend.box="vertical") + 
  guides(fill=guide_legend(ncol=1, override.aes = list(size=10))) + 
  scale_fill_manual(name = "Wave", values = c("#154042", "#2AA7AD", "#548082"), 
                    labels = c("1st wave has hit the hardest", "Both waves have hit with a similar force", "2nd wave has hit the hardest")) + 
  scale_y_continuous(breaks = seq(0, 1, 0.2), labels = paste(seq(0, 100, 20), "%", sep = ""), expand = c(0, 0.02)) +
  theme(panel.grid.major.x  = element_blank(),
        plot.title = element_text(hjust = 0.5, face = "bold", size=16, color = "#154042"),
        panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA)) +
  xlab("Country groups")+
  ylab("Percentage of countries in group") + 
  ggtitle("Which wave has hit the hardest?") +
  theme(axis.text.y = element_text(size=18, color = "#154042"),
        axis.text.x = element_text(size=18, color = "#154042"),
        axis.title.x = element_text(size = 18, color ="#154042"),
        axis.title.y = element_text(size = 18, color ="#154042"),
        legend.text = element_text(size = 18, color ="#154042"),
        legend.title = element_text(size = 18, color ="#154042"))  -> p5

ggsave("wavescomp.png", p5, bg = "transparent", width = 12, height = 9)
