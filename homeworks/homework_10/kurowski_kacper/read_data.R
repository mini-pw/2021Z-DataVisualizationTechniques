setwd("/home/kurowskik/RStudio/TWD/Lab10/")


library(readxl)
library(dplyr)
library(stringr)
dataxlsx <- read_xlsx("1-5_achievement-gender-M4.xlsx", skip = 4)

dataxlsx <- dataxlsx %>%
  select( "Country",
          "Girl.Percentage" = "Girls", "Girl.Score" = "...8",
          "Boy.Percentage" = "Boys", "Boy.Score" = "...14")
dataxlsx <- dataxlsx[2:60, ]
dataxlsx <- dataxlsx %>%
  mutate( Country = str_remove( Country, " \\(5\\)"))

df_girlPart <- dataxlsx %>% 
  select( "Country", "Percentage" = "Girl.Percentage","Score" = "Girl.Score") %>%
  mutate( "Gender" = "Girls")

df_malePart <- dataxlsx %>% 
  select( "Country", "Percentage" = "Boy.Percentage","Score" = "Boy.Score") %>%
  mutate( "Gender" = "Boys")

df2 <- data.frame( rbind( df_girlPart, df_malePart)) %>%
  arrange( Country)

df2$Percentage <- as.numeric( df2$Percentage)
df2$Score <- as.numeric( df2$Score)

write.csv( df2, "TIMSS_2019_Gender_Comparison_data.csv") 
