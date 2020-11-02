library(tidyverse)
library(GGally)
library(patchwork)

raw <- read_csv("dane/responses.csv")



df <- raw%>%
  select(colnames(raw)[2:15])

# nastawienie NA 8 pierwszym rekordom dla w3 - pomyłka przy wstawianiu wykresu do ankiety
df[(nrow(df)-8):nrow(df),3] <- NA


colnames(df) <- c("wstep1", "wstep2", "w3", "w4", "w5", "w6", "w7",
                  "w8", "w9", "w10", "w11", "w12", "start_time", "stop_time")

# odfiltrowanie wg pytan zamknietych, dodanie kolumny ID
filtered <- df%>%
  mutate_at("wstep1", function(x){x=="74%"})%>%
  mutate_at("wstep2", function(x){x=="35%"})%>%
  mutate(response_time = difftime(stop_time, start_time, units = 'min'))%>%
  filter(wstep1 & wstep2 == TRUE)%>%
  mutate(id = row_number())%>%
  select(-wstep1, -wstep2)

# ramka danych z czasami odpowiedzi dla danego respondenta
response_times <- filtered%>%select(id, start_time, stop_time,response_time)

# wyliczenie roznic miedzy odpowiedziami a wlasciwymi wartosciami
differences <- filtered %>%
  mutate(w3 = abs(w3-61.7), w4 = abs(w4-71.4), w5 = abs(w5-33.3),
         w6 = abs(w6-70.5), w7 = abs(w7-70), w8 = abs(w8-70.5),
         w9 = abs(w9-50), w10 = abs(w10-50), w11 = abs(w11-35),
         w12 = abs(w12-33.3), response_time = NULL,
         start_time = NULL, stop_time = NULL)

# przelozenie na blad log2
errors <- differences%>%
  mutate_if(is.double, function(x){log2(x+0.125)})

# podzielone na T typy
errors_t <- errors%>%
  transmute(id = id, t1 = (w3+w6)/2, t4 = w4, t5 = w7, t6 = (w5+w9)/2,
            t1_3d = (w8+w11)/2, t6_3d = (w10+w12))



# rozwiniecie errors
errors_long <- gather(errors, key="type", value = "error", -id, na.rm = TRUE)%>%
  mutate(type = as.factor(type))

errors_t_long <- gather(errors_t, key = 'type', value = 'error', -id, na.rm = TRUE)%>%
  mutate(type = as.factor(type))


plots_errors <- data.frame(
  t1 = c(errors$w3, errors$w6),
  t4 = errors$w4,
  t5 = errors$w7,
  t6 = c(errors$w5, errors$w9),
  t1_3d = c(errors$w8, errors$w11),
  t6_3d = c(errors$w10, errors$w12)
)

plots_errors_long <- gather(plots_errors, key = 'type', value = 'error', na.rm = TRUE)%>%
  mutate(type = as.factor(type))

ggplot(plots_errors_long, aes(x=key, y=value))+
  geom_point(position = position_jitter(width = 0.1, height = 0.1))




# blad a godzina odpowiedzi
ggplot(errors_t_long%>%left_join(response_times))+
  geom_point(aes(x = lubridate::hour(start_time), y =error), size = 0.5)+
  facet_wrap(~type)+
  theme_bw()


# blad a czas odpowiedzi
error_vs_time <- ggplot(errors_t_long%>%left_join(response_times))+
  geom_point(aes(x = response_time, y = error), size = 0.5)+
  xlim(c(0,7.5))+
  facet_wrap(~type)+
  theme_bw()+
  labs(x = "Czas odpowiedzi w minutach", y ="Błąd")

# error_vs_time zbiorczo
error_vs_time_aggr <- errors_t_long%>%left_join(response_times)%>%
  group_by(id, response_time)%>%
  summarise(mean_error = mean(error))%>%
  ggplot(aes(x = response_time, y = mean_error), size = 0.5)+
  geom_point()+
  xlim(0,7.5)+
  theme_bw()+
  labs(x = "Czas odpowiedzi w minutach", y = "Średni błąd popelniany w odpowiedziach")
# ggsave("error_vs_time.png", plot = error_vs_time | error_vs_time_aggr, dpi = 150, width = 25/1.5, height = 13/1.5, units = "cm")

# odtworzenie wykresu z badań

prev_study <- data.frame(type = factor(c('t6', 't5', 't4', 't1')),
                         lower = c(315,305,230,0)/300 + 1,
                         mid = c(358,375,296,74)/300 + 1,
                         higher = c(400, 448,363,150)/300 + 1)

prev_plot <- ggplot(prev_study, aes(x=factor(type, level = c('t6', 't5', 't4', 't1')), y = mid))+
  geom_point()+
  geom_errorbar(aes(ymin = lower, ymax = higher),width = 0.2)+
  coord_flip()+
  theme_bw()+
  ylim(0,5)+
  theme(axis.title.x = element_blank())+
  labs(title = "Wyniki badań Heer & Bostock", x = "Typ wykresu")


lower_ci <- function(mean, se, n, conf_level = 0.95){
  lower_ci <- mean - qt(1 - ((1 - conf_level) / 2), n - 1) * se
}
upper_ci <- function(mean, se, n, conf_level = 0.95){
  upper_ci <- mean + qt(1 - ((1 - conf_level) / 2), n - 1) * se
}


my_error_plot <- plyr::ddply(errors_t_long, c('type'), summarise, N = length(error),
      mean = mean(error),
      sd   = sd(error),
      se   = sd / sqrt(N))%>%
  ggplot(aes(x = factor(type, level = c('t6_3d', 't6', 't5', 't4', 't1_3d', 't1')), y = mean))+
  geom_point(size = 2)+
  geom_errorbar(aes(ymin=lower_ci(mean, se, N), ymax=upper_ci(mean,se,N)),
                width = 0.2)+
  coord_flip()+
  theme_bw()+
  ylim(0,5)+
  labs(x = "Typ wykresu", y = "średni błąd z 95% przedziałem ufności", title = "Wyniki ankiety")

comparison_plot <- prev_plot / my_error_plot




# zaleznoci pomiedzy bledami?
ggpairs(errors_t%>%left_join(response_times)%>%
          mutate(start_time = as.numeric(lubridate::hour(start_time)),
                 end_time = NULL,
                 response_time = as.numeric(response_time))%>%
          filter(response_time < 1000), columns = c('t1', 't4', 't5', 't6'))+
  theme_bw()

