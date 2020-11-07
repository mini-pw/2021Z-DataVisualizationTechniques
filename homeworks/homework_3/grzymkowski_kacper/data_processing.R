library(dplyr)
library(ggplot2)
library(tidyr)

ankiety <- read.csv("data.csv")

ankiety_actual <- data.frame(Question = c("bw1", "bw2", "bw3", "bw4", "bw5", "col1", "col2", "col3", "col4", "col5"),
                             Actual = c(51, 33, 46, 40, 15, 42, 57, 22, 63, 51)) 

ankiety %>%
  mutate_at(vars(-("Timestamp")), as.double) %>%
  as.tbl %>%
  pivot_longer(2:ncol(ankiety), names_to="Question", values_to="Answer") ->
  ankiety_processed

# warning, że factor -> character
suppressWarnings(
  right_join(ankiety_actual, ankiety_processed, by="Question") %>%
  mutate(Error = Answer- Actual) -> 
    ankiety_merged
)
wikresy <- function() {
ankiety_merged %>% 
  filter(abs(Error) <= 4) %>% # usuwam odstające, aby nie psuły średniej
  mutate_at(c("Error"), abs) %>%
  mutate(Diagram = ifelse(stringr::str_starts(Question, "bw"), "Szary", "Kolorowy")) %>%
  group_by(Diagram) %>% 
  summarise(Suma_bledow = sum(Error), Sredni_blad = mean(Error)) -> x


ankiety_merged %>%
  ggplot(aes(x = Question, y = Error)) +
  geom_boxplot()

ggplot() +
  geom_col(data = ankiety_merged %>% select(Question, Actual) %>% unique(), mapping = aes(x = Question, y = Actual), 
           fill = c(rep("#595959", 5), "#F9766E", "#A3A601", "#00BF7C", "#00B0F6", "#E86BF3")) +
  geom_jitter(data = ankiety_merged, mapping = aes(x = Question, y = Answer), height = 0, alpha = 0.5) +
  scale_x_discrete() +
  labs(y = "", x ="") 
}