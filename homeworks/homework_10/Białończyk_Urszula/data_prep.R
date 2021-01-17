require(ggplot2)
require(dplyr)

# ------------------------- Przygotowanie danych ------------------- #


M4_trends <- read_xlsx("./TIMSS-2019/1-3_achievement-trends-M4.xlsx",skip = 4) %>%
  select(3,5,7,9)%>%
  na.omit()

math_results <- read_xlsx("./TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

science_results <- read_xlsx("./TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

S4_gender <- read_xlsx("./TIMSS-2019/2-5_achievement-gender-S4.xlsx",skip = 4) %>%
  select(3,8,14)%>%
  na.omit()
colnames(S4_gender)[2:3] <- c("Average_score_girls", "Average_score_boys")

M4_gender <- read_xlsx("./TIMSS-2019/1-5_achievement-gender-M4.xlsx",skip = 4) %>%
  select(3,8,14)%>%
  na.omit()
colnames(M4_gender)[2:3] <- c("Average_score_girls", "Average_score_boys")

math_results <- rbind(math_results, math_results) 
colnames(M4_gender)[c(2,3)] <- c("Average_score", "Average_score")
gender_math <- rbind(M4_gender[,c(1,2)], M4_gender[,c(1,3)])
gender_math$Gender <- c(rep("Girls", 65), rep("Boys", 65))
data_cale <- full_join(math_results, gender_math, by="Country")
data_cale <- data_cale[1:129, ] # zdublowaly sie, biore polowe danych
data_cale <- data_cale[-75, ] # usuwam jakis rzad TMISS-scale
data_cale$Average_score <- as.numeric(data_cale$Average_score)

science_results <- rbind(science_results, science_results) 
colnames(S4_gender)[c(2,3)] <- c("Average_score", "Average_score")
gender_science <- rbind(S4_gender[,c(1,2)], S4_gender[,c(1,3)])
gender_science$Gender <- c(rep("Girls", 65), rep("Boys", 65))
data_cale_science <- full_join(science_results, gender_science, by="Country")
data_cale_science <- data_cale_science[-71, ] # usuwam jakis rzad TMISS-scale
data_cale_science <- data_cale_science[1:128, ] # zdublowaly sie, biore polowe danych
data_cale_science$Average_score <- as.numeric(data_cale_science$Average_score)


# korzystamy z data_cale - matma / data_cale_science - przyroda

write.csv(data_cale,"/Users/urszulabialonczyk/Documents/Techniki Wizualizacji Danych/shiny_app/data_cale.csv")
write.csv(data_cale_science,"/Users/urszulabialonczyk/Documents/Techniki Wizualizacji Danych/shiny_app/data_cale_science.csv")
