library("readxl")
library(dplyr)


# Math 4th grade
M4 <- read_xlsx("1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

M4<- data.frame(M4)
write.csv(M4[1:59, ], "math_4_grade_score.csv", row.names = FALSE)

# Math 8th grade
M8 <- read_xlsx("3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

M8<- data.frame(M8)
write.csv(M8[1:40, ], "math_8_grade_score.csv", row.names = FALSE)


# Science 4th grade
S4 <- read_xlsx("2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

S4<- data.frame(S4)
S4
write.csv(S4[1:59, ], "science_4_grade_score.csv", row.names = FALSE)

# Science 8th grade
S8 <- read_xlsx("4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

S8<- data.frame(S8)
S8
write.csv(S8[1:40, ], "science_8_grade_score.csv", row.names = FALSE)



## ----------- Achevements by gender -----------


# Math 4th grade


AM_4 <- read_xlsx("1-5_achievement-gender-M4.xlsx", skip = 5) %>%
  select(3,8,14)%>%
  na.omit()
AM_4<- data.frame(AM_4)
colnames(AM_4)<- c("Countries", "Girls", "Boys")
write.csv(AM_4, "gender_math_4.csv", row.names = FALSE)


# Math 8th grade
AM_8 <- read_xlsx("3-5_achievement-gender-M8.xlsx", skip = 5) %>%
  select(3,8,14)%>%
  na.omit()
AM_8<- data.frame(AM_8)
colnames(AM_8)<- c("Countries", "Girls", "Boys")
write.csv(AM_8, "gender_math_8.csv", row.names = FALSE)

# Science 4th grade
AS_4 <- read_xlsx("2-5_achievement-gender-S4.xlsx", skip = 5) %>%
  select(3,8,14)%>%
  na.omit()
AS_4<- data.frame(AS_4)
colnames(AS_4)<- c("Countries", "Girls", "Boys")
write.csv(AS_4, "gender_science_4.csv", row.names = FALSE)

# Science 8th grade
AS_8 <- read_xlsx("4-5_achievement-gender-S8.xlsx", skip = 5) %>%
  select(3,8,14)%>%
  na.omit()
AS_8<- data.frame(AS_8)
colnames(AS_8)<- c("Countries", "Girls", "Boys")
write.csv(AS_8, "gender_science_8.csv", row.names = FALSE)
