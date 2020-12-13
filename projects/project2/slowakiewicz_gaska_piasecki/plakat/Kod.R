library(ggplot2)
library(dplyr)
library(data.table)
library(ggrepel)
library(RColorBrewer)
library(png)

covid_data_word <- read.csv("owid-covid-data.csv")

interesujace_panstwa <- c("Russia","Japan","Poland","France","India","Italy","China","Brazil","Mexico","USA","Sudan",
                          "Israel","Australia","Iran","Germany","Spain","Canada","Uganda","World","San Marino","Peru",
                          "Andorra","United Kingdom","Burundi","Tanzania")

data_sample_1 <-  select(covid_data_word,date,continent,total_tests_per_thousand,human_development_index,
       total_cases,total_deaths,total_tests,population,location)
data_sample_2 <-  select(covid_data_word,date,total_cases_per_million,location,continent,total_deaths_per_million,
                         population_density,human_development_index)
data_sample_3 <- subset(data_sample_2,date == "2020-11-23")

data_sample_3 <- data_sample_3 %>% 
  mutate(label_for_plot = ifelse((location %in% interesujace_panstwa),
                                 as.character(location), "")) 
data_sample_3 <- data_sample_3 %>% 
  mutate(Developed_Index = ifelse((human_development_index > 0.7),
                                 "Developed", "Not Developed")) 
data_sample_3 <- data_sample_3 %>% 
  mutate(HDI_Group = case_when((human_development_index > 0.8)~"Very High HDI",
                                     (human_development_index > 0.7&human_development_index <= 0.8)~"High HDI",
                                     (human_development_index > 0.550&human_development_index <= 0.7)~"Medium HDI",
                                     (human_development_index > 0.350&human_development_index <= 0.550)~"Low HDI",
                                     TRUE ~ "0"))
    
    data_sample_3_modified <- data_sample_3[which(data_sample_3$continent != ""),]
    data_sample_3_modified$continent <- factor(data_sample_3_modified$continent, levels = data_sample_3_modified$continent)
##Zastosowano skale logarytmiczna na osi y
ggplot(data_sample_3_modified, aes(x = total_deaths_per_million, y = total_cases_per_million,color = continent,label=label_for_plot)) +
  geom_point(size = 3.25) + theme(plot.background = element_rect(fill = "#e5d2c7",color ='black'),panel.background = element_rect(fill = "#ffffff",colour = 'black'),
                               panel.grid.major.y = element_blank(),
                               panel.grid.major.x = element_blank()
  ) + coord_trans(y="log2")+ geom_text_repel(color="black",force=2.5,size=4) + xlab("Deaths per million")+
  ylab("Contaminations per million") + colScale

ggplot(na.omit(data_sample_3), aes(x = total_deaths_per_million, y =total_cases_per_million,color = continent)) +
  geom_point(size = 3) + theme(plot.background = element_rect(fill = "#e5d2c7",color= "black"),panel.background = element_rect(fill = "white",color = "black"),
                               panel.grid.major.y = element_line(color ="gray"),
                               panel.grid.major.x = element_line(color ="gray")
  ) + xlab("Deaths per million")+ylab("Contamination per million")+
  stat_ellipse(geom="polygon", aes(fill = continent), alpha = 0.2, show.legend = TRUE,  level = 0.95) + colScale1

ggplot(data_sample_3, aes(x = total_deaths_per_million, y =total_cases_per_million,color = Developed_Index)) +
  geom_point(size = 3) + theme_bw() + coord_trans(y="log2") + xlab("Œmierci na milion mieszkañców")+
  ylab("Zaka¿enia na milion mieszkañców") 

ggplot(na.omit(data_sample_3), aes(x = total_deaths_per_million, y =total_cases_per_million,)) +
  geom_point(size = 4) + theme_bw() + xlab("Œmierci na milion mieszkañców")+ylab("Zaka¿enia na milion mieszkañców")+
  stat_ellipse(geom="polygon", aes(fill = Developed_Index), alpha = 0.2, show.legend = TRUE,  level = 0.95)

ggplot(na.omit(data_sample_3), aes(x = total_deaths_per_million, y =total_cases_per_million)) +
  geom_point(size = 4) + theme(plot.background = element_rect(fill = "#e5d2c7"),panel.background = element_rect(fill = "white"),
                               panel.grid.minor.y = element_line(colour = "black"),
                               panel.grid.minor.x = element_line(colour = "black")
  ) + xlab("Deths per million")+ylab("Contamination per million")+
  stat_ellipse(geom="polygon", aes(fill = HDI_Group,), alpha = 0.2, show.legend = TRUE,  level = 0.95,colour = "black") +colScale



## Odrzucam dziewiêæ pierwszych wyników o najwy¿szym zagêszczeniu populacji
##S¹ to niewielkie pañstwa lub niewielkie enklawy, zawy¿aj¹ce œredni¹ zagêszczenia
data_sample_4 <- data_sample_3 %>% arrange(desc(population_density))
data_sample_4 <- tail(data_sample_4,nrow(data_sample_4)-9)
data_sample_4$HDI_Group <- factor(data_sample_4$HDI_Group, levels = c("Low HDI","Medium HDI","High HDI","Very High HDI"))
data_sample_3$HDI_Group <- factor(data_sample_3$HDI_Group, levels = c("Low HDI","Medium HDI","High HDI","Very High HDI"))
ggplot(na.omit(data_sample_4), aes(y = total_cases_per_million, x =population_density,color = HDI_Group)) +
  geom_point(size = 4) +theme(plot.background = element_rect(fill = "#e5d2c7"),panel.background = element_rect(fill = "white"),
                              panel.grid.major.y = element_line(colour = "black"),
                              panel.grid.major.x = element_line(colour = "black")
                              ) +coord_trans(y="log10")+ ylab("Contamination per million")+
  xlab("Population density in persons per square kilometre") + geom_smooth(se = FALSE) +colScale 



myColors <- brewer.pal(10,"Set2")
names(myColors) <- levels(data_sample_4$HDI_Group)
colScale <- scale_colour_manual(name = "HDI_Group",values = myColors)
''
myColors1 <- brewer.pal(10,"Set2")
names(myColors1) <- levels(data_sample_4$continent)
colScale1 <- scale_colour_manual(name = "continent",values = myColors1)

col <- brewer.pal(1,"Pastel1")




