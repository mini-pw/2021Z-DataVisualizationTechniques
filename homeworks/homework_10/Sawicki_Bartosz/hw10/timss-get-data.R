library("readxl")
library(dplyr)



# Matematyka dla 4 klasy
M4 <- read_xlsx("files/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("M4" = "Average \r\nScale Score") %>%
  na.omit()

M4_instruction_type <- read_xlsx("files/12-2_instruction-time-M4.xlsx", skip = 3) %>%
  select(3, 6, 10) %>%
  rename("total_h" = "...6", "mat_h" = "...10") %>%
  mutate(mat_h = as.numeric(mat_h)) %>%
  na.omit()

M4_student_bullying <-  read_xlsx("files/8-12_student-bullying-M4.xlsx", skip = 3) %>%
  select(3, 6, 9, 12, 15, 18, 21, 24) %>%
  rename("never_avg" = "...9", "monthly_avg" = "...15", "weekly_avg" = "...21") %>%
  mutate_at(2:8,as.numeric) %>%
  na.omit()

M4_student_like <- read_xlsx("files/11-2_students-like-learning-M4.xlsx", skip = 3)%>%
  select(3,6,9,12,15,18,21,24) %>%
  rename("like_avg" = "...9", "middle_avg" = "...15", "hate_avg" = "...21") %>%
  mutate_at(2:8,as.numeric) %>%
  na.omit()  
  

M4_student_confident <- read_xlsx("files/11-8_students-confident-M4.xlsx", skip = 3)%>%
  select(3,6,9,12,15,18,21,24) %>%
  rename("confident_avg" = "...9", "middle_avg" = "...15", "not_confident_avg" = "...21") %>%
  mutate_at(2:8,as.numeric) %>%
  na.omit()  






# Dobry punkt wyjścia dla poprzednich lat:
# https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study
# Uwaga, czasem wygodniej jest przepisać kilka liczb niż automatyzowaćich pobranie.