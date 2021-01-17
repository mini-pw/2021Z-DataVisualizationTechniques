library("readxl")
library(dplyr)


# Matematyka dla 4 klasy
M4 <- read_xlsx("./data/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  filter(Country != "TIMSS Scale Centerpoint") %>% 
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
M4 <- M4[1:58, ]


# Dla 8 klasy bedzie:
M8 <- read_xlsx("./data/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  filter(Country != "TIMSS Scale Centerpoint") %>% 
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
M8 <- M8[1:39, ]


# Przyroda dla 4 klasy
S4 <- read_xlsx("./data/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  filter(Country != "TIMSS Scale Centerpoint") %>% 
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
S4 <- S4[1:58, ]


# Dla 8 klasy bedzie:
S8 <- read_xlsx("./data/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  filter(Country != "TIMSS Scale Centerpoint") %>% 
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
S8 <- S8[1:39, ]



M4comp <- read_xlsx("./data/14-1_computer-access-instruction-M4.xlsx", skip = 7) %>% 
  select(3, 6, 19, 23, 27) 
colnames(M4comp) <- c("Country", "Computer availability", "Ans1", "Ans2", "Ans3")
M4comp <- M4comp[1:58, ]


M8comp <- read_xlsx("./data/14-3_computer-access-instruction-M8.xlsx", skip = 7) %>% 
  select(3, 6, 19, 23, 27) %>% 
  na.omit()
colnames(M8comp) <- c("Country", "Computer availability", "Ans1", "Ans2", "Ans3")
M8comp <- M8comp[1:39, ]
M8comp$Ans2 <- as.numeric(M8comp$Ans2)

S4comp <- read_xlsx("./data/14-2_computer-access-instruction-S4.xlsx", skip = 7) %>% 
  select(3, 6, 19, 23, 27) 
colnames(S4comp) <- c("Country", "Computer availability", "Ans1", "Ans2", "Ans3")
S4comp <- S4comp[1:58, ]


S8comp <- read_xlsx("./data/14-4_computer-access-instruction-S8.xlsx", skip = 7) %>% 
  select(3, 6, 19, 23, 27) %>% 
  na.omit()
colnames(S8comp) <- c("Country", "Computer availability", "Ans1", "Ans2", "Ans3")
S8comp <- S8comp[1:39, ]
S8comp$`Computer availability` <- as.numeric(S8comp$`Computer availability`)
S8comp$Ans1 <- as.numeric(S8comp$Ans1)
S8comp$Ans2 <- as.numeric(S8comp$Ans2)
S8comp$Ans3 <- as.numeric(S8comp$Ans3)


M4 <- M4 %>% left_join(M4comp)
M4$Country <- stringi::stri_replace_all_regex(M4$Country, " \\([0-9]\\)", "")

M8 <- M8 %>% left_join(M8comp)
M8$Country <- stringi::stri_replace_all_regex(M8$Country, " \\([0-9]\\)", "")

S4 <- S4 %>% left_join(S4comp)
S4$Country <- stringi::stri_replace_all_regex(S4$Country, " \\([0-9]\\)", "")

S8 <- S8 %>% left_join(S8comp)
S8$Country <- stringi::stri_replace_all_regex(S8$Country, " \\([0-9]\\)", "")
 



