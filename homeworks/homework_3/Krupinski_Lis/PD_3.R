library(ggplot2)
# install.packages("treemapify")
library(treemapify)


# PIERWSZY EKSPERYMENT

values <- c(18, 20, 21, 19, 22)

# pie chart 1

pie(values, labels = LETTERS[1:5])

# bar plot

df <- data.frame(letters = LETTERS[1:5], val = values)

ggplot(data=df, aes(x = letters, y = val)) +
  geom_bar(stat="identity", fill="#b3697a", width = .7) +
  ylab("values")

# DRUGI EKSPERYMENT

# pie chart 2

values_2 <- c(15, 14, 18, 22, 12, 19)

pie(values_2, labels = LETTERS[1:6], 
    col = c("#EF9A9A", "#85E993", "#858FEF", "#EFE185", "#F2AF4B", "#D56858"))

# tree map

df_2 <- data.frame(letters = LETTERS[1:6], val = values_2)

ggplot(df_2, aes(area = val, label = letters)) +
  geom_treemap(fill = c("#EF9A9A", "#85E993", "#858FEF", "#EFE185", "#F2AF4B", "#D56858")) +
  geom_treemap_text(fontface = "italic", colour = "white", place = "centre",
                    grow = FALSE)


