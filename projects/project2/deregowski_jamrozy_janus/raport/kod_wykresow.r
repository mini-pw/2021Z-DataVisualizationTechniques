library(ggplot2)
library(tidyr)
library(scales)
library(patchwork)
library("dplyr")
library("tidyverse")
dates <- seq(as.Date("2020-03-01"),by=1,len=275)

poland_stayathome <- c(rep(0,22),rep(1,27),rep(0,275-22-27))
poland_schoolsworkplaces <- c(rep(0,6),rep(1,4),rep(5,20),rep(6,34),rep(5,55),rep(3,61),rep(4,275-6-4-20-34-55-61))
poland_mask <- c(rep(0,45),rep(2,44),rep(1,132),rep(2,275-45-44-132))
poland_publicplaces <- c(rep(0,13),rep(5,2),rep(6,35),rep(7,16),rep(5,14),rep(4,12),rep(2,69),rep(1,79),rep(2,3),rep(3,275-13-2-35-16-14-12-69-79-3))
poland_massgathering <- c(rep(0,13),rep(1,5),rep(4,20),rep(0,58),rep(3,49),rep(1,19),rep(2,67),rep(0,27),rep(5,275-13-5-20-58-49-19-67-27))

germany_stayathome <- c(rep(0,275))
germany_schoolsworkplaces <- c(rep(0,12),rep(3,94),rep(2,14),rep(1,2),rep(0,275-12-94-14-2))
germany_mask <- c(rep(0,57),rep(1,275-57))
germany_publicplaces <- c(rep(0,14),rep(2,7),rep(3,30),rep(2,49),rep(1,120),rep(2,7),rep(3,19),rep(4,275-14-7-30-49-120-7-19))
germany_massgathering <- c(rep(0,6),rep(1,15),rep(5,100),rep(3,92),rep(4,35),rep(5,275-6-15-100-92-35))

iceland_stayathome <- c(rep(0,275))
iceland_schoolsworkplaces <- c(rep(0,15),rep(3,50),rep(1,275-15-50))
iceland_mask <- c(rep(0,275))
iceland_publicplaces <- c(rep(0,14),rep(3,72),rep(1,21),rep(0,77),rep(1,50),rep(2,11),rep(3,275-14-72-21-77-50-11))
iceland_massgathering <- c(rep(0,14),rep(3,9),rep(4,63),rep(2,66),rep(3,40),rep(2,26),rep(4,275-14-9-63-66-40-26))

sweden_stayathome <- c(rep(0,275))
sweden_schoolsworkplaces <- c(rep(0,16),rep(1,2),rep(3,8),rep(4,82),rep(2,275-16-2-8-82))
sweden_mask <- c(rep(0,275))
sweden_publicplaces <- c(rep(0,122),rep(1,275-122))
sweden_massgathering <- c(rep(0,11),rep(2,16),rep(4,77),rep(5,275-11-16-77))

czechia_stayathome <- c(rep(0,15),rep(1,40),rep(0,178),rep(1,275-15-40-178))
czechia_schoolsworkplaces <- c(rep(0,9),rep(4,13),rep(5,49),rep(3,111),rep(0,43),rep(3,9),rep(5,30),rep(3,275-9-13-49-111-43-9-30))
czechia_mask <- c(rep(0,18),rep(2,107),rep(0,21),rep(1,88),rep(2,275-18-107-21-88))
czechia_publicplaces <- c(rep(0,9),rep(1,3),rep(3,1),rep(5,2),rep(6,57),rep(5,14),rep(4,14),rep(3,83),rep(2,35),rep(3,8),rep(4,8),rep(6,275-9-3-1-2-57-14-14-83-35-8-8))
czechia_massgathering <- c(rep(0,3),rep(3,8),rep(4,61),rep(3,14),rep(2,28),rep(5,11),rep(1,95),rep(4,14),rep(5,275-3-8-61-14-28-11-95-14))

spain_stayathome <- c(rep(0,12),rep(1,59),rep(0,164),rep(1,275-12-59-164))
spain_schoolsworkplaces <- c(rep(0,7),rep(1,4),rep(5,30),rep(6,137),rep(2,275-7-4-30-137))
spain_mask <- c(rep(0,63),rep(1,17),rep(0,74),rep(2,275-63-17-74))
spain_publicplaces <- c(rep(0,13),rep(4,99),rep(3,108),rep(6,275-13-99-108))
spain_massgathering <- c(rep(0,13),rep(5,80),rep(4,20),rep(0,101),rep(5,275-13-80-20-101))

abc <- function(a,color,limity){
  x<-data.frame(dates,a)
  x
  x<-x %>%
    pivot_longer(2:ncol(x), names_to ="obostrzenie") %>% arrange(obostrzenie)
  x
  
  
  ggplot(x, aes(y=obostrzenie,x=dates,fill =value )) + geom_bar(stat="identity", width = 0.5) +theme_void() +
    scale_fill_gradientn(colours=c("snow2",color), limits=c(0,limity)) + theme(legend.position = "none")

}



abc2<-function(color,a){
  x<-data.frame(dates,a)
  x
  x<-x %>%
    pivot_longer(2:ncol(x), names_to ="obostrzenie") %>% arrange(obostrzenie)
  x
  
  
  ggplot(x, aes(y=obostrzenie,x=dates,fill = -value )) + geom_bar(stat="identity", width = 0.5) +theme_void() +
    scale_fill_gradient(low = color, high = "snow2") + theme(legend.position = "none") 
}


library(reader)
data<-read.csv(url("https://github.com/owid/covid-19-data/raw/master/public/data/owid-covid-data.csv"))

range_moving_mean=7
data_start=as.Date("2020-03-01")
data_end=as.Date("2020-11-30")
county_code="POL"


plot <-function(country_code,country_name){
  
  country_date<- dplyr::filter(data,iso_code==country_code)
  country_date<-country_date %>% mutate(Date=as.Date(date))
  country_date<-country_date %>% filter(Date>data_start & Date<data_end)
  ggplot(country_date, aes(x=Date,y=new_cases_smoothed_per_million)) +
    geom_line(size=1.2)+
    theme_minimal()+
    labs(x="",y="Nowe przypadki")+
    labs(title = country_name)+
    theme(plot.title = element_text(hjust = 0.5, size =20, face="bold"))
  
  
  
}

head(data)

#Legenda


abc2("red",c(rep(0,137),rep(1,138)))+ ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(hjust = 0.5, vjust=-4))+
abc2("blue4", c((rep(0,39)), (rep(1,39)), (rep(2,39)), (rep(3,39)), (rep(4,39)), (rep(5,40)), (rep(6,40))))+ ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(hjust = 0.5, vjust=-4))+
abc2("green",c(rep(0,92), rep(1,92), rep(2,91))) + ggtitle("Maski")+ theme(plot.title = element_text(hjust = 0.5, vjust=-4))+
abc2("purple", c(rep(0,34),rep(1,34),rep(2,34),rep(3,34),rep(4,34),rep(5,35),rep(6,35), rep(7,35))) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(hjust = 0.5, vjust=-4))+
abc2("brown", c(rep(0,46),rep(1,46),rep(2,46),rep(3,46),rep(4,46),rep(5,45))) +ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(hjust = 0.5, vjust=-4))+ plot_layout(ncol=1)




# Wykresy


plot("POL",'Polska')
plot("SWE","Szwecja")

plot("SWE","Szwecja") +(abc(sweden_stayathome,"red",1) + ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                            abc(sweden_schoolsworkplaces,"blue4",7) + ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                            abc(sweden_mask,"green",3) + ggtitle("Maski")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                            abc(sweden_publicplaces, "purple",8) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                            abc(sweden_massgathering, "brown",6) + ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+plot_layout(ncol=1)) +plot_layout(ncol=1)
ggsave("szwecja.png")
plot("POL",'Polska') +(abc(poland_stayathome,"red",1) + ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
  abc(poland_schoolsworkplaces,"blue4",7) + ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
  abc(poland_mask,"green",3) + ggtitle("Maski")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
  abc(poland_publicplaces, "purple",8) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
  abc(poland_massgathering, "brown",6) + ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+plot_layout(ncol=1)) +plot_layout(ncol=1)
ggsave("polska.png")
plot("DEU",'Niemcy') +(abc(germany_stayathome,"red",1) + ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                           abc(germany_schoolsworkplaces,"blue4",7) + ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                           abc(germany_mask,"green",3) + ggtitle("Maski")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                           abc(germany_publicplaces, "purple",8) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                           abc(germany_massgathering, "brown",6) + ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+plot_layout(ncol=1)) +plot_layout(ncol=1)
ggsave("niemcy.png")
plot("IND",'Islandia')+(abc(iceland_stayathome,"red",1) + ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                          abc(iceland_schoolsworkplaces,"blue4",7) + ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                          abc(iceland_mask,"green",3) + ggtitle("Maski")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                          abc(iceland_publicplaces, "purple",8) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                          abc(iceland_massgathering, "brown",6) + ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+plot_layout(ncol=1)) +plot_layout(ncol=1)
ggsave("islandia.png")
plot("CZE",'Czechy')+(abc(czechia_stayathome,"red",1) + ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                         abc(czechia_schoolsworkplaces,"blue4",7) + ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                         abc(czechia_mask,"green",3) + ggtitle("Maski")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                         abc(czechia_publicplaces, "purple",8) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                         abc(czechia_massgathering, "brown",6) + ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+plot_layout(ncol=1)) +plot_layout(ncol=1)
ggsave("czechy.png")
plot("ESP",'Hiszpania')+(abc(spain_stayathome,"red",1) + ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                           abc(spain_schoolsworkplaces,"blue4",7) + ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                           abc(spain_mask,"green",3) + ggtitle("Maski")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                           abc(spain_publicplaces, "purple",8) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+
                           abc(spain_massgathering, "brown",6) + ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(hjust = 0.5, vjust=-2))+plot_layout(ncol=1)) +plot_layout(ncol=1)
ggsave("hiszpania.png")


