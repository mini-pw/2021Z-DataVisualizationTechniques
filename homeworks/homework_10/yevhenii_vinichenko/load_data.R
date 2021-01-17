library("readxl")
library(dplyr)
library(plotly)

countries <<- read_xlsx("homeworks/homework_10/yevhenii_vinichenko/1-8_benchmarks-results-M4.xlsx", skip = 5) %>%
  select(3) %>%
  na.omit()

countries <<- countries[-(59:65), ]

countries <<- countries[[1]]


load_data <- function(path1, path2){
  # funckja dla załadowania danych dla scatterplot'a
  
  experience <- read_xlsx(path1, skip = 5) %>%
    select(3, 30) %>%
    na.omit()
  colnames(experience) <- c("country", "experience")
  
  mark <- read_xlsx(path2, skip = 5) %>%
    select(3, 5) %>%
    na.omit()
  
  colnames(mark) <- c("country", "mark")
  
  res <- full_join(experience, mark, by = "country")
  
  res %>% filter(is.element(country, countries)) -> res
  
  res
  
}

data_m4 <- load_data("homeworks/homework_10/yevhenii_vinichenko/9-9_teacher-experience-M4.xlsx",
                   "homeworks/homework_10/yevhenii_vinichenko/1-1_achievement-results-M4.xlsx")

data_s4 <- load_data("homeworks/homework_10/yevhenii_vinichenko/9-10_teacher-experience-S4.xlsx",
                   "homeworks/homework_10/yevhenii_vinichenko/2-1_achievement-results-S4.xlsx")

data_m8 <- load_data("homeworks/homework_10/yevhenii_vinichenko/9-11_teacher-experience-M8.xlsx",
                     "homeworks/homework_10/yevhenii_vinichenko/3-1_achievement-results-M8.xlsx")

data_s8 <- load_data("homeworks/homework_10/yevhenii_vinichenko/9-12_teacher-experience-S8.xlsx",
                     "homeworks/homework_10/yevhenii_vinichenko/4-1_achievement-results-S8.xlsx")

write.csv(data_m4, "data_m4.csv")
write.csv(data_s4, "data_s4.csv")
write.csv(data_m8, "data_m8.csv")
write.csv(data_s8, "data_s8.csv")
