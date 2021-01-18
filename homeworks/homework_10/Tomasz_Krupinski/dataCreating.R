library(dplyr)
library(readxl)


# matematyka
# 4
m4ResultsGender <- read_xlsx("TIMSS-2019/1-5_achievement-gender-M4.xlsx", skip = 5)
m4ResultsGender <- select(m4ResultsGender, 3, 8, 14)
colnames(m4ResultsGender) <- c("Country", "GirlsAverage", "BoysAverage")
m4ResultsGender <- na.omit(m4ResultsGender)

m4Results <- read_xlsx("TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 5)
m4Results <- select(m4Results, 3, 5)
colnames(m4Results) <- c("Country", "Average")
m4Results <- na.omit(m4Results)
m4Results <- inner_join(m4Results, m4ResultsGender, by = "Country")
write.csv(m4Results, "m4Results.csv")

# 8
m8ResultsGender <- read_xlsx("TIMSS-2019/3-5_achievement-gender-M8.xlsx", skip = 5)
m8ResultsGender <- select(m8ResultsGender, 3, 8, 14)
colnames(m8ResultsGender) <- c("Country", "GirlsAverage", "BoysAverage")
m8ResultsGender <- na.omit(m8ResultsGender)

m8Results <- read_xlsx("TIMSS-2019/3-1_achievement-results-M8.xlsx", skip = 5)
m8Results <- select(m8Results, 3, 5)
colnames(m8Results) <- c("Country", "Average")
m8Results <- na.omit(m8Results)
m8Results <- inner_join(m8Results, m8ResultsGender, by = "Country")
write.csv(m8Results, "m8Results.csv")

# science
# 4
s4ResultsGender <- read_xlsx("TIMSS-2019/2-5_achievement-gender-S4.xlsx", skip = 5)
s4ResultsGender <- select(s4ResultsGender, 3, 8, 14)
colnames(s4ResultsGender) <- c("Country", "GirlsAverage", "BoysAverage")
s4ResultsGender <- na.omit(s4ResultsGender)

s4Results <- read_xlsx("TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 5)
s4Results <- select(s4Results, 3, 5)
colnames(s4Results) <- c("Country", "Average")
s4Results <- na.omit(s4Results)
s4Results <- inner_join(s4Results, s4ResultsGender, by = "Country")
write.csv(s4Results, "s4Results.csv")

# 8
s8ResultsGender <- read_xlsx("TIMSS-2019/4-5_achievement-gender-S8.xlsx", skip = 5)
s8ResultsGender <- select(s8ResultsGender, 3, 8, 14)
colnames(s8ResultsGender) <- c("Country", "GirlsAverage", "BoysAverage")
s8ResultsGender <- na.omit(s8ResultsGender)

s8Results <- read_xlsx("TIMSS-2019/4-1_achievement-results-S8.xlsx", skip = 5)
s8Results <- select(s8Results, 3, 5)
colnames(s8Results) <- c("Country", "Average")
s8Results <- na.omit(s8Results)
s8Results <- inner_join(s8Results, s8ResultsGender, by = "Country")
write.csv(s8Results, "s8Results.csv")