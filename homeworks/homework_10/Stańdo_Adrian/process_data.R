library(readxl)
library(dplyr)
library(stringr)

process_data <- function(){
# Process input data to homogeneous data frames.
# One file for one year, subject, grade. Each row corresponds to one country.

# ----------------------------------2011----------------------------------------
# 2011
# Mathematics
# Grade 4
data2011 <- read_xlsx("./data/2011/T11_IR_M_AppendixG.xlsx")

mathematics2011_grade4 <- slice(data2011, 9:58)
colnames(mathematics2011_grade4) <- c("Country", "X5thPercentile", "X10thPercentile", "X25thPercentile", "X50thPercentile", 
                               "X75thPercentile", "X90thPercentile", "X95thPercentile")

mathematics2011_grade4$Country <- str_replace(mathematics2011_grade4$Country, " \\([0-9]\\)", "")

mathematics2011_grade4$X5thPercentile <- substring(mathematics2011_grade4$X5thPercentile, 1, 3)
mathematics2011_grade4$X10thPercentile <- substring(mathematics2011_grade4$X10thPercentile, 1, 3)
mathematics2011_grade4$X25thPercentile <- substring(mathematics2011_grade4$X25thPercentile, 1, 3)
mathematics2011_grade4$X50thPercentile <- substring(mathematics2011_grade4$X50thPercentile, 1, 3)
mathematics2011_grade4$X75thPercentile <- substring(mathematics2011_grade4$X75thPercentile, 1, 3)
mathematics2011_grade4$X90thPercentile <- substring(mathematics2011_grade4$X90thPercentile, 1, 3)
mathematics2011_grade4$X95thPercentile <- substring(mathematics2011_grade4$X95thPercentile, 1, 3)

tmp_gender <- slice(data2011, 153:202) %>% select(1, 4, 6)
colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")
tmp_gender$mean_girls <- substring(tmp_gender$mean_girls, 1, 3)
tmp_gender$mean_boys <- substring(tmp_gender$mean_boys, 1, 3)

mathematics2011_grade4 <- full_join(mathematics2011_grade4, tmp_gender, by = "Country")

write.csv(mathematics2011_grade4, "./data/mathematics_2011_grade4.csv", row.names = FALSE)

rm(mathematics2011_grade4)
rm(tmp_gender)

# 2011
# Mathematics
# Grade 8
mathematics2011_grade8 <- slice(data2011, 84:125)
colnames(mathematics2011_grade8) <- c("Country", "X5thPercentile", "X10thPercentile", "X25thPercentile", "X50thPercentile", 
                                      "X75thPercentile", "X90thPercentile", "X95thPercentile")

mathematics2011_grade8$Country <- str_replace(mathematics2011_grade8$Country, " \\([0-9]\\)", "")

mathematics2011_grade8$X5thPercentile <- substring(mathematics2011_grade8$X5thPercentile, 1, 3)
mathematics2011_grade8$X10thPercentile <- substring(mathematics2011_grade8$X10thPercentile, 1, 3)
mathematics2011_grade8$X25thPercentile <- substring(mathematics2011_grade8$X25thPercentile, 1, 3)
mathematics2011_grade8$X50thPercentile <- substring(mathematics2011_grade8$X50thPercentile, 1, 3)
mathematics2011_grade8$X75thPercentile <- substring(mathematics2011_grade8$X75thPercentile, 1, 3)
mathematics2011_grade8$X90thPercentile <- substring(mathematics2011_grade8$X90thPercentile, 1, 3)
mathematics2011_grade8$X95thPercentile <- substring(mathematics2011_grade8$X95thPercentile, 1, 3)

tmp_gender <- slice(data2011, 229:270) %>% select(1, 4, 6)
colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")
tmp_gender$mean_girls <- substring(tmp_gender$mean_girls, 1, 3)
tmp_gender$mean_boys <- substring(tmp_gender$mean_boys, 1, 3)

mathematics2011_grade8 <- full_join(mathematics2011_grade8, tmp_gender, by = "Country")

write.csv(mathematics2011_grade8, "./data/mathematics_2011_grade8.csv", row.names = FALSE)

rm(data2011)
rm(mathematics2011_grade8)
rm(tmp_gender)

# 2011
# Science
# Grade 4
data2011 <- read_xlsx("./data/2011/T11_IR_S_AppendixG.xlsx")

science2011_grade4 <- slice(data2011, 9:58)
colnames(science2011_grade4) <- c("Country", "X5thPercentile", "X10thPercentile", "X25thPercentile", "X50thPercentile", 
                                      "X75thPercentile", "X90thPercentile", "X95thPercentile")

science2011_grade4$Country <- str_replace(science2011_grade4$Country, " \\([0-9]\\)", "")

science2011_grade4$X5thPercentile <- substring(science2011_grade4$X5thPercentile, 1, 3)
science2011_grade4$X10thPercentile <- substring(science2011_grade4$X10thPercentile, 1, 3)
science2011_grade4$X25thPercentile <- substring(science2011_grade4$X25thPercentile, 1, 3)
science2011_grade4$X50thPercentile <- substring(science2011_grade4$X50thPercentile, 1, 3)
science2011_grade4$X75thPercentile <- substring(science2011_grade4$X75thPercentile, 1, 3)
science2011_grade4$X90thPercentile <- substring(science2011_grade4$X90thPercentile, 1, 3)
science2011_grade4$X95thPercentile <- substring(science2011_grade4$X95thPercentile, 1, 3)

tmp_gender <- slice(data2011, 153:202) %>% select(1, 4, 6)
colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")
tmp_gender$mean_girls <- substring(tmp_gender$mean_girls, 1, 3)
tmp_gender$mean_boys <- substring(tmp_gender$mean_boys, 1, 3)

science2011_grade4 <- full_join(science2011_grade4, tmp_gender, by = "Country")

write.csv(science2011_grade4, "./data/science_2011_grade4.csv", row.names = FALSE)

rm(science2011_grade4)
rm(tmp_gender)

# 2011
# Science
# Grade 8
science2011_grade8 <- slice(data2011, 84:125)
colnames(science2011_grade8) <- c("Country", "X5thPercentile", "X10thPercentile", "X25thPercentile", "X50thPercentile", 
                                      "X75thPercentile", "X90thPercentile", "X95thPercentile")

science2011_grade8$Country <- str_replace(science2011_grade8$Country, " \\([0-9]\\)", "")

science2011_grade8$X5thPercentile <- substring(science2011_grade8$X5thPercentile, 1, 3)
science2011_grade8$X10thPercentile <- substring(science2011_grade8$X10thPercentile, 1, 3)
science2011_grade8$X25thPercentile <- substring(science2011_grade8$X25thPercentile, 1, 3)
science2011_grade8$X50thPercentile <- substring(science2011_grade8$X50thPercentile, 1, 3)
science2011_grade8$X75thPercentile <- substring(science2011_grade8$X75thPercentile, 1, 3)
science2011_grade8$X90thPercentile <- substring(science2011_grade8$X90thPercentile, 1, 3)
science2011_grade8$X95thPercentile <- substring(science2011_grade8$X95thPercentile, 1, 3)

tmp_gender <- slice(data2011, 229:270) %>% select(1, 4, 6)
colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")
tmp_gender$mean_girls <- substring(tmp_gender$mean_girls, 1, 3)
tmp_gender$mean_boys <- substring(tmp_gender$mean_boys, 1, 3)

science2011_grade8 <- full_join(science2011_grade8, tmp_gender, by = "Country")

write.csv(science2011_grade8, "./data/science_2011_grade8.csv", row.names = FALSE)

rm(data2011)
rm(science2011_grade8)
rm(tmp_gender)

# ----------------------------------2015----------------------------------------

# 2015
# Mathematics
# Grade 4

data2015_math_percentiles <- read_xls("./data/2015/G_1_math-percentiles-of-mathematics-achievement-grade-4.xls") %>%
  slice(5:53) %>%
  select(3, 4, 6, 8, 10, 12, 14, 16)
colnames(data2015_math_percentiles) <- c("Country", "X5thPercentile", "X10thPercentile", "X25thPercentile", "X50thPercentile", 
                                      "X75thPercentile", "X90thPercentile", "X95thPercentile")

data2015_math_percentiles$Country <- str_replace(data2015_math_percentiles$Country, " \\([0-9]\\)", "")

tmp_gender <- read_xls("./data/2015/G_3_math-standard-deviations-of-mathematics-achievement-grade-4.xls") %>%
  slice(6:54) %>%
  select(3, 8, 12)

colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")

data2015_math_percentiles <- full_join(data2015_math_percentiles, tmp_gender, by = "Country")

write.csv(data2015_math_percentiles, "./data/mathematics_2015_grade4.csv", row.names = FALSE)

rm(data2015_math_percentiles)
rm(tmp_gender)

# 2015
# Mathematics
# Grade 8

data2015_math_percentiles <- read_xls("./data/2015/G_2_math-percentiles-of-mathematics-achievement-grade-8.xls") %>%
  slice(5:43) %>%
  select(3, 4, 6, 8, 10, 12, 14, 16)
colnames(data2015_math_percentiles) <- c("Country", "X5thPercentile", "X10thPercentile", "X25thPercentile", "X50thPercentile", 
                                         "X75thPercentile", "X90thPercentile", "X95thPercentile")

data2015_math_percentiles$Country <- str_replace(data2015_math_percentiles$Country, " \\([0-9]\\)", "")

tmp_gender <- read_xls("./data/2015/G_4_math-standard-deviations-of-mathematics-achievement-grade-8.xls") %>%
  slice(6:44) %>%
  select(3, 8, 12)

colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")

data2015_math_percentiles <- full_join(data2015_math_percentiles, tmp_gender, by = "Country")

write.csv(data2015_math_percentiles, "./data/mathematics_2015_grade8.csv", row.names = FALSE)

rm(tmp_gender)
rm(data2015_math_percentiles)

# 2015
# Science
# Grade 4

data2015_science_percentiles <- read_xls("./data/2015/G_1_science-percentiles-of-science-achievement-grade-4.xls") %>%
  slice(5:51) %>%
  select(3, 4, 6, 8, 10, 12, 14, 16)
colnames(data2015_science_percentiles) <- c("Country", "X5thPercentile", "X10thPercentile", "X25thPercentile", "X50thPercentile", 
                                         "X75thPercentile", "X90thPercentile", "X95thPercentile")

data2015_science_percentiles$Country <- str_replace(data2015_science_percentiles$Country, " \\([0-9]\\)", "")

tmp_gender <- read_xls("./data/2015/G_3_science-standard-deviations-of-science-achievement-grade-4.xls") %>%
  slice(6:52) %>%
  select(3, 8, 12)

colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")

data2015_science_percentiles <- full_join(data2015_science_percentiles, tmp_gender, by = "Country")

write.csv(data2015_science_percentiles, "./data/science_2015_grade4.csv", row.names = FALSE)

rm(data2015_science_percentiles)
rm(tmp_gender)

# 2015
# Science
# Grade 8

data2015_science_percentiles <- read_xls("./data/2015/G_2_math-percentiles-of-mathematics-achievement-grade-8.xls") %>%
  slice(5:43) %>%
  select(3, 4, 6, 8, 10, 12, 14, 16)
colnames(data2015_science_percentiles) <- c("Country", "X5thPercentile", "X10thPercentile", "X25thPercentile", "X50thPercentile", 
                                         "X75thPercentile", "X90thPercentile", "X95thPercentile")

data2015_science_percentiles$Country <- str_replace(data2015_science_percentiles$Country, " \\([0-9]\\)", "")

tmp_gender <- read_xls("./data/2015/G_4_science-standard-deviations-of-science-achievement-grade-8.xls") %>%
  slice(6:44) %>%
  select(3, 8, 12)

colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")

data2015_science_percentiles <- full_join(data2015_science_percentiles, tmp_gender, by = "Country")

write.csv(data2015_science_percentiles, "./data/science_2015_grade8.csv", row.names = FALSE)

rm(tmp_gender)
rm(data2015_science_percentiles)

# ----------------------------------2019----------------------------------------

# 2019
# Mathematics
# Grade 4

data2019_maths <- read_xlsx("./data/2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  slice(2:60) %>%
  select(3, 9, 10, 11, 12, 13, 14) %>%
  filter(Country != "TIMSS Scale Centerpoint")

colnames(data2019_maths) <- c("Country", "X5thPercentile", "X25thPercentile", "middle1", "middle2",
                                         "X75thPercentile","X95thPercentile")
data2019_maths$Country <- str_replace(data2019_maths$Country, " \\([0-9]\\)", "")
data2019_maths$middle1 <- as.numeric(data2019_maths$middle1)
data2019_maths$middle2 <- as.numeric(data2019_maths$middle2)
data2019_maths$X50thPercentile <- (data2019_maths$middle1 + data2019_maths$middle2) / 2
data2019_maths$X50thPercentile <- round(data2019_maths$X50thPercentile)

data2019_maths <- select(data2019_maths, 1, 2, 3, 6, 7, 8)

data2019_maths <- data2019_maths[, c("Country", "X5thPercentile", "X25thPercentile", 
                                     "X50thPercentile", "X75thPercentile","X95thPercentile")]


tmp_gender <- read_xlsx("./data/2019/E_1_achievement-standard-deviations-gender-M4.xlsx") %>%
  slice(5:62) %>%
  select(3, 11, 17)

colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")

data2019_maths <- full_join(data2019_maths, tmp_gender, by = "Country")

write.csv(data2019_maths, "./data/mathematics_2019_grade4.csv", row.names = FALSE)

rm(data2019_maths)
rm(tmp_gender)

# 2019
# Mathematics
# Grade 8

data2019_maths <- read_xlsx("./data/2019/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  slice(2:41) %>%
  select(3, 9, 10, 11, 12, 13, 14) %>%
  filter(Country != "TIMSS Scale Centerpoint")

colnames(data2019_maths) <- c("Country", "X5thPercentile", "X25thPercentile", "middle1", "middle2",
                              "X75thPercentile","X95thPercentile")
data2019_maths$Country <- str_replace(data2019_maths$Country, " \\([0-9]\\)", "")
data2019_maths$middle1 <- as.numeric(data2019_maths$middle1)
data2019_maths$middle2 <- as.numeric(data2019_maths$middle2)
data2019_maths$X50thPercentile <- (data2019_maths$middle1 + data2019_maths$middle2) / 2
data2019_maths$X50thPercentile <- round(data2019_maths$X50thPercentile)

data2019_maths <- select(data2019_maths, 1, 2, 3, 6, 7, 8)

data2019_maths <- data2019_maths[, c("Country", "X5thPercentile", "X25thPercentile", 
                                     "X50thPercentile", "X75thPercentile","X95thPercentile")]

tmp_gender <- read_xlsx("./data/2019/E_3_achievement-standard-deviations-gender-M8.xlsx") %>%
  slice(5:43) %>%
  select(3, 11, 17)

colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")

data2019_maths <- full_join(data2019_maths, tmp_gender, by = "Country")

write.csv(data2019_maths, "./data/mathematics_2019_grade8.csv", row.names = FALSE)

rm(data2019_maths)
rm(tmp_gender)

# 2019
# Science
# Grade 4

data2019_science <- read_xlsx("./data/2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  slice(2:60) %>%
  select(3, 9, 10, 11, 12, 13, 14) %>%
  filter(Country != "TIMSS Scale Centerpoint")

colnames(data2019_science) <- c("Country", "X5thPercentile", "X25thPercentile", "middle1", "middle2",
                              "X75thPercentile","X95thPercentile")
data2019_science$Country <- str_replace(data2019_science$Country, " \\([0-9]\\)", "")
data2019_science$middle1 <- as.numeric(data2019_science$middle1)
data2019_science$middle2 <- as.numeric(data2019_science$middle2)
data2019_science$X50thPercentile <- (data2019_science$middle1 + data2019_science$middle2) / 2
data2019_science$X50thPercentile <- round(data2019_science$X50thPercentile)

data2019_science <- select(data2019_science, 1, 2, 3, 6, 7, 8)

data2019_science <- data2019_science[, c("Country", "X5thPercentile", "X25thPercentile", 
                                     "X50thPercentile", "X75thPercentile","X95thPercentile")]

tmp_gender <- read_xlsx("./data/2019/E_2_achievement-standard-deviations-gender-S4.xlsx") %>%
  slice(5:62) %>%
  select(3, 11, 17)

colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")

data2019_science <- full_join(data2019_science, tmp_gender, by = "Country")

write.csv(data2019_science, "./data/science_2019_grade4.csv", row.names = FALSE)

rm(data2019_science)
rm(tmp_gender)



# 2019
# Science
# Grade 8

data2019_science <- read_xlsx("./data/2019/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  slice(2:41) %>%
  select(3, 9, 10, 11, 12, 13, 14) %>%
  filter(Country != "TIMSS Scale Centerpoint")

colnames(data2019_science) <- c("Country", "X5thPercentile", "X25thPercentile", "middle1", "middle2",
                                "X75thPercentile","X95thPercentile")
data2019_science$Country <- str_replace(data2019_science$Country, " \\([0-9]\\)", "")
data2019_science$middle1 <- as.numeric(data2019_science$middle1)
data2019_science$middle2 <- as.numeric(data2019_science$middle2)
data2019_science$X50thPercentile <- (data2019_science$middle1 + data2019_science$middle2) / 2
data2019_science$X50thPercentile <- round(data2019_science$X50thPercentile)

data2019_science <- select(data2019_science, 1, 2, 3, 6, 7, 8)

data2019_science <- data2019_science[, c("Country", "X5thPercentile", "X25thPercentile", 
                                         "X50thPercentile", "X75thPercentile","X95thPercentile")]

tmp_gender <- read_xlsx("./data/2019/E_4_achievement-standard-deviations-gender-S8.xlsx") %>%
  slice(5:43) %>%
  select(3, 11, 17)

colnames(tmp_gender) <- c("Country", "mean_girls", "mean_boys")
tmp_gender$Country <- str_replace(tmp_gender$Country, " \\([0-9]\\)", "")

data2019_science <- full_join(data2019_science, tmp_gender, by = "Country")

write.csv(data2019_science, "./data/science_2019_grade8.csv", row.names = FALSE)

rm(data2019_science)
rm(tmp_gender)

}


process_data()






