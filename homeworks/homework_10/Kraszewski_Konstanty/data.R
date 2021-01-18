library(readxl)

M4 <- read_xlsx("./TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit() %>%
  inner_join(read_xlsx("./TIMSS-2019/1-5_achievement-gender-M4.xlsx", skip = 4) %>%
               select(3, 5, 8, 11, 14) %>%
               na.omit(), "Country")

M8 <- read_xlsx("./TIMSS-2019/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit() %>%
  inner_join(read_xlsx("./TIMSS-2019/3-5_achievement-gender-M8.xlsx", skip = 4) %>%
               select(3, 5, 8, 11, 14) %>%
               na.omit(), "Country")

S4 <- read_xlsx("./TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit() %>%
  inner_join(read_xlsx("./TIMSS-2019/2-5_achievement-gender-S4.xlsx", skip = 4) %>%
               select(3, 5, 8, 11, 14) %>%
               na.omit(), "Country")

S8 <- read_xlsx("./TIMSS-2019/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit() %>%
  inner_join(read_xlsx("./TIMSS-2019/4-5_achievement-gender-S8.xlsx", skip = 4) %>%
               select(3, 5, 8, 11, 14) %>%
               na.omit(), "Country")