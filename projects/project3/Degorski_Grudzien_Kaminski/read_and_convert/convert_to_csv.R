

source('read_and_convert/read_functions.R')


#-----------------------------READING-----------------------------
# steps
steps_ada <- read_file_csv("data/samsung_ada_new.csv")
steps_adrian <- read_file_csv("data/samsung_adrian_new.csv")
steps_karol <- read_file_csv_forKarol("data/samsung_steps_karol_new.csv")

ddF <- data.frame(step_count = c(2666, 2663),
                  update_time = c("2021-01-09", "2021-01-10"),
                  distance = c(2.05, 2.01),
                  calorie = c(96, 95))

steps_ada <- rbind(steps_ada, ddF) %>%
  arrange(update_time)

sleep_adrian <- read_file_json("data/sleep_adrian_new.txt")
sleep_karol <- read_file_json("data/sleep_karol_new.txt")
sleep_ada <- sleep_adrian # zapelnienie danych tymczasowe

asleep <- as.hms(c("06:54:00:000000","05:58:00:000000", "08:37:00:000000", "07:11:00:000000", "06:47:00:000000", "06:41:00:000000", 
            "09:19:00:000000","08:00:00:000000", "07:59:00:000000", "06:00:00:000000", "07:46:00:000000", "06:53:00:000000",
            "06:07:00:000000","06:35:00:000000", "07:31:00:000000", "07:01:00:000000", "08:55:00:000000", "06:19:00:000000", 
            "07:36:00:000000","07:33:00:000000", "05:58:00:000000", "08:29:00:000000",
            "05:19:00:000000","06:32:00:000000", "06:36:00:000000", "06:31:00:000000", "07:01:00:000000"))

sleep_ada$asleep <- asleep

sleep_karol <- sleep_karol[1:27,]


#-----------------------------CONVERTING & WRITING-----------------------------
days_number <- nrow(steps_ada) # liczba dni

steps_ada <- steps_ada %>% 
  mutate('name' = rep('Ada',1,days_number), 'day' = 1:days_number)
steps_adrian <- steps_adrian %>% 
  mutate('name' = rep('Adrian',1,days_number), 'day' = 1:days_number)
steps_karol <- steps_karol %>%
  mutate('name' = rep('Karol',1,days_number), 'day' = 1:days_number)

steps_adrian %>%
  inner_join(sleep_adrian, by = 'day') -> steps_adrian
steps_karol %>%
  inner_join(sleep_karol, by = 'day') -> steps_karol
steps_ada %>%
  inner_join(sleep_ada, by = 'day') -> steps_ada

sub_df <- read.csv2('data/dane_subiektywne_new.csv', dec = ".")
colnames(sub_df)[1] <- "jakosc_snu"


sub_df <- sub_df %>%
  mutate(Feelings = (2*samopoczucie + motywacja_do_nauki + 3*motywacja_do_wstania_rano)/6)


df <- rbind(steps_ada, steps_adrian, steps_karol)

df1 <- df %>%
  inner_join(sub_df, by = c("day" = "nr_dnia",
                            "name" = "imie"))

write.csv(df1, 'data/converted_data.csv', row.names = F)


