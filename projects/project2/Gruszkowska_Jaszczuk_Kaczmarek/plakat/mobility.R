library(dplyr)
library(data.table)
library(ggplot2)

wynikowe <- fread("2020_PL_Region_Mobility_Report.csv")
wynikowe <- wynikowe %>%
  select(date,retail_and_recreation_percent_change_from_baseline,grocery_and_pharmacy_percent_change_from_baseline,parks_percent_change_from_baseline,transit_stations_percent_change_from_baseline,workplaces_percent_change_from_baseline,residential_percent_change_from_baseline)
wynikowe$date = as.Date(wynikowe$date)
Sys.setlocale("LC_ALL", "English")

pp2<-ggplot(rbind(data.frame(x=wynikowe$date,y=wynikowe$retail_and_recreation_percent_change_from_baseline,Type="Retail and recreation"),
                  data.frame(x=wynikowe$date,y=wynikowe$grocery_and_pharmacy_percent_change_from_baseline,Type="Grocery and pharmacy"),
                  data.frame(x=wynikowe$date,y=wynikowe$workplaces_percent_change_from_baseline,Type='Workplaces'),
                  data.frame(x=wynikowe$date,y=wynikowe$residential_percent_change_from_baseline,Type='Residential')),
            aes(x=x,y=y/100,color=Type))+
  geom_smooth(se = TRUE, show.legend = FALSE, size = 1.3)+
  geom_smooth(se = FALSE)+
  scale_color_manual(values = c("Retail and recreation" = 'yellow',
                                "Grocery and pharmacy" = '#56B4E9',
                                "Workplaces" = '#009E73',
                                "Residential" = "firebrick1"))+
  scale_y_continuous(name = "Change",labels = scales::percent)+
  theme_minimal()+
  ggtitle("Comparison of mobility in Poland in 2020")+
  xlab("Date")+
  theme(legend.position = c(0.7,0.2),
        legend.title = element_text(hjust = 0.5, size=15, face='bold', color = "orange"),
        axis.title.x = element_text(size=15, face='bold', color = "orange"),
        axis.title.y = element_text(size=15, face='bold', color = "orange"),
        axis.text.x = element_text(size = 17, color = "orange"),
        axis.text.y = element_text(size = 17, color = "orange"),
        legend.text = element_text(size = 13,face = 'bold', color = "orange"),
        legend.key = element_rect(colour =NA, fill = NA),
        plot.title = element_text(hjust = 0.5, color = "orange", face = "bold", size = 30),
        panel.background = element_rect(fill = '#2e2b2b', colour = 'orange'),
        plot.background = element_rect(fill="#2e2b2b"),
        legend.background = element_rect(fill = "#2e2b2b"),
        panel.grid.major = element_line(colour = "orange"),
        panel.grid.minor = element_line(colour = "orange"))
pp2

