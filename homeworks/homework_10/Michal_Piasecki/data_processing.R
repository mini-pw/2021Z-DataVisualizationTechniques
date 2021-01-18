install.packages('rsconnect')
library("readxl")
library(dplyr)
library(ggplot2)
library(plotly)


Math_4 <- read_xlsx("czwarta_klasa.xlsx") %>%
  select(3,5) %>%
  filter(row_number() > 4 ) %>%
  rename("Score" = "...5", "Country" = "...3") %>%
  arrange(desc(Score)) %>%
  na.omit()
Math_4$Country <- factor(Math_4$Country, levels = rev(Math_4$Country))
                            


Math_8 <- read_xlsx("osma_klasa.xlsx") %>%
  select(3,5) %>%
  filter(row_number() > 4) %>%
  rename("Score" = "...5", "Country" = "...3") %>%
  arrange(desc(Score)) %>%
  na.omit()
Math_8$Country <- factor(Math_8$Country, levels = rev(Math_8$Country))
                            



Science_4 <- read_xlsx("czwarta_klasa_Science.xlsx") %>%
  select(3,5) %>%
  filter(row_number() > 4 ) %>%
  rename("Score" = "...5", "Country" = "...3") %>%
  arrange(desc(Score)) %>%
  na.omit()
Science_4$Country <- factor(Science_4$Country, levels = rev(Science_4$Country))
                              


Science_8 <- read_xlsx("czwarta_klasa_Science.xlsx") %>%
  select(3,5) %>%
  filter(row_number() > 4 ) %>%
  rename("Score" = "...5", "Country" = "...3") %>%
  arrange(desc(Score)) %>%
  na.omit()
Science_8$Country <- factor(Science_8$Country, levels = rev(Science_8$Country))
                               


#p <- ggplot(data=fourth_grade, aes(x = Country, y = Score)) +
#  geom_bar(stat = "identity", width= 0.8) +
#  scale_fill_manual(name = "Country", values=c("#ECDD7B","#561D25")) +
#  theme(panel.background = element_blank())
#ggplotly(p)
#x = c(1,2,3)
#-x
