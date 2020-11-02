library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(patchwork)


## ----- Wykresy ------

data("iris")
iris %>%
  pivot_longer(1:4, "TypeofValue") -> iris_modified

head(iris_modified)

ggplot(iris_modified, aes(x = TypeofValue, y = value, fill = Species)) + 
  geom_bar(stat = "summary", fun.y = "mean") + 
  scale_fill_manual(values = c('#1b9e77','#d95f02','#7570b3')) +
  theme_hc() +
  ggtitle(format("Wielkości popularnych gatunków irysów")) +
  theme(
    legend.title = element_blank(),
    legend.text = element_text(face = "italic"),
    # legend.position = "top",
    plot.title = element_text(hjust = 0.5, face="bold"),
    axis.title.x = element_blank(),
    axis.text.x = element_text(face = 'bold'),
    axis.title.y = element_blank(),
    axis.text.y = element_text(face = 'bold')
  ) -> bars_stacked

ggplot(iris_modified, aes(x = TypeofValue, y = value, fill = Species)) + 
  geom_bar(stat = "summary", fun.y = "mean", position = "dodge") +
  scale_fill_manual(values = c('#1b9e77','#d95f02','#7570b3')) +
  ggtitle(format("Wielkości popularnych gatunków irysów")) +
  theme_hc() +
  theme(
    legend.title = element_blank(),
    legend.text = element_text(face = "italic"),
    # legend.position = "top",
    plot.title = element_text(hjust = 0.5, face="bold"),
    axis.title.x = element_blank(),
    axis.text.x = element_text(face = 'bold'),
    axis.title.y = element_blank(),
    axis.text.y = element_text(face = 'bold')
  ) -> bars_dodge

iris_summarised <- iris_modified %>%
  group_by(Species, TypeofValue) %>%
  summarise(mean = mean(value))


## ----- Sortowanie ------

sepal.width_sorted <- iris_summarised %>%
  filter(TypeofValue=="Sepal.Width") %>%
  arrange(-mean) %>%
  select(Species)

sepal.width_sorted = data.frame(Species = sepal.width_sorted[[1]],
                                Order = c("Najdluzszy", "Sredni", "Najkrotszy"))
sepal.width_sorted %>%
  pivot_wider(names_from = Order, values_from = Species) -> sepal.width_sorted

sepal.length_sorted <- iris_summarised %>%
  filter(TypeofValue=="Sepal.Length") %>%
  arrange(-mean) %>%
  select(Species)

sepal.length_sorted = data.frame(Species = sepal.length_sorted[[1]],
                                Order = c("Najdluzszy", "Sredni", "Najkrotszy"))
sepal.length_sorted %>%
  pivot_wider(names_from = Order, values_from = Species) -> sepal.length_sorted


data_width_sorting=data.frame(Wykres=rep(c(1,2), each=15),
                        Najdluzszy=c(rep("setosa", 14), "virginica",
                                     rep("setosa", 15)),
                        Sredni=c(rep("virginica", 14), "setosa",
                                 rep("virginica", 15)),
                        Najkrotszy=c(rep("versicolor", 15),
                                     rep("versicolor", 15)),
                        stringsAsFactors = FALSE)

data_length_sorting=data.frame(Wykres=rep(c(1,2), each=15),
                              Najdluzszy=c("veriscolor", rep("virginica", 8),"versicolor", "virginica", 
                                           "versicolor", "virginica", "versicolor", "virginica",
                                           rep("virginica", 15)),
                              Sredni=c("virginica", "versicolor", "setosa", rep("versicolor", 6),"virginica",
                                       "versicolor","virginica", "versicolor","virginica" , "versicolor",
                                       rep("versicolor", 15)),
                              Najkrotszy=c(rep("setosa", 2), "versicolor", rep("setosa", 12),
                                           rep("setosa", 15)),
                              stringsAsFactors = FALSE)

  
set_values <- function(data, key) {
  size = length(data$Najdluzszy)
  data$Najdluzszy <- ifelse(data$Najdluzszy == rep(as.character(key[[1]]), size), 1, 0)
  data$Sredni <- ifelse(data$Sredni == rep(as.character(key[[2]]), size), 1, 0)
  data$Najkrotszy <- ifelse(data$Najkrotszy == rep(as.character(key[[3]]), size), 1, 0)
  return(data)
}

set_values(data_length_sorting, sepal.length_sorted) %>%
  mutate(Sum = Najdluzszy + Sredni + Najkrotszy)  %>%
  group_by(Wykres) %>%
  summarise(Sum = mean(Sum)/3) -> sort_length_summarised

set_values(data_width_sorting, sepal.width_sorted) %>%
  mutate(Sum = Najdluzszy + Sredni + Najkrotszy)  %>%
  group_by(Wykres) %>%
  summarise(Sum = mean(Sum)/3) -> sort_width_summarised



data.frame(Wykres = c(1,2),
           Sepal.Length = paste(format(sort_length_summarised[[2]]*100, digits = 3),"%", sep = ""),
           Sepal.Width =paste(format(sort_width_summarised[[2]]*100, digits = 3),"%", sep = "")) -> sorting_data


## ----- Szacowanie ------

data_petal_width = data.frame(Wykres=rep(c(1,2), each=15),
                              Setosa=c(2,0.2,0.08,0.1,0.3,0.5,0.7,0.1,0.3,0.1,0.1,0.1,0.15,0.1,0.3,
                                       0.1,0.2,0.2,0.3, 0.1,0.2,0.3,0.25,0.25,0.2,0.2,0.2,0.2,0.22,0.2),
                              Versicolor=c(1, 1, 1, 1, 1.7,1,1.4,1,1.2,1,1,1,1.1,1,1.4,
                                           1.75,1.6,1.1,1.3,1.1,1.2,1.1,1.2,1.2,1.3,1.1,1.3,1.3,1.25,1.2),
                              Virginica=c(0.1, 1.8, 1.5,2.2,2,1.7,2,1.6,2.4,2.5,2,2.3,2.4,2.3,2.3,
                                          2,2,2.01,2.1,2.1,2.03,2.2,2,2,2,2.1,2.01,2.05,2,2)
                              )

data_summary = rep(2, 15)

petal_width_correct <- iris_summarised %>%
  filter(TypeofValue=="Petal.Width") %>%
  select(-2)

data_petal_width$Setosa <- abs(data_petal_width$Setosa - petal_width_correct[[1,2]])
data_petal_width$Versicolor <- abs(data_petal_width$Versicolor - petal_width_correct[[2,2]])
data_petal_width$Virginica <- abs(data_petal_width$Virginica - petal_width_correct[[3,2]])

data_petal_width %>%
  pivot_longer(2:4, "Species") -> data_petal_width

data_petal_width$Wykres <- ifelse(data_petal_width$Wykres==1, format("W\ny\nk\nr\ne\ns\n \n1"),
                                  format("W\ny\nk\nr\ne\ns\n \n2"))
       

# ggplot(data_petal_width, aes(x = value, fill=Species)) +
#   geom_boxplot() + 
#   facet_wrap(~Wykres, strip.position="left", ncol = 1) +
#   theme_hc() +
#   scale_fill_manual(values = c('#1b9e77','#d95f02','#7570b3')) +
#   xlab("Błąd bezwzględny") +
#   scale_x_continuous(limits = c(0,0.8)) +
#   theme(
#     axis.title.x = element_text(size=14, face = "bold.italic"),
#     axis.text.y = element_blank(),
#     strip.text.y.left = element_text(size=14,angle = 0, face = "bold.italic"),
#     strip.placement = "outside",
#     strip.background = element_rect(colour=NA, fill=NA),
#     
#     legend.position = "none"
#   )
  
