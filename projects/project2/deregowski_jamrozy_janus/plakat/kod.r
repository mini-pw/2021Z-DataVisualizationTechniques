library(ggplot2)
library(tidyr)
library(scales)
library(patchwork)
library("dplyr")
library("tidyverse")
library(scales)
library(reader)
dates <- seq(as.Date("2020-03-01"),by=1,len=275)

abc <- function(a,color,limity){
  x<-data.frame(dates,a)
  x
  x<-x %>%
    pivot_longer(2:ncol(x), names_to ="obostrzenie") %>% arrange(obostrzenie)
  x
  
  
  ggplot(x, aes(y=obostrzenie,x=as.Date(dates),fill =value )) + geom_bar(stat="identity", width = 0.5) + theme_void() +
    scale_fill_gradientn(colours=c("snow2",color), limits=c(0,limity)) + theme(legend.position = "none") 

}



abc2<-function(color,a){
  x<-data.frame(dates,a)
  x
  x<-x %>%
    pivot_longer(2:ncol(x), names_to ="obostrzenie") %>% arrange(obostrzenie)
  x
  
  
  ggplot(x, aes(y=obostrzenie,x=dates,fill = -value )) + geom_bar(stat="identity", width = 0.5) +
    theme_void() +
    scale_fill_gradient(low = color, high = "snow2") + theme(legend.position = "none") 
}



restrykcje<-read.csv("restrykcje.csv")
data<-read.csv(url("https://github.com/owid/covid-19-data/raw/master/public/data/owid-covid-data.csv"))

range_moving_mean=7
data_start=as.Date("2020-03-01")
data_end=as.Date("2020-11-30")
county_code="POL"


plot <-function(country_code,country_name,bool){
  if(bool){
    tytul_y="Nowe przypadki\n średnia 7-dniowa per milion"}
  else{
    tytul_y=""
  }
  
  country_date<- dplyr::filter(data,iso_code==country_code)
  country_date<-country_date %>% mutate(Date=as.Date(date))
  country_date<-country_date %>% filter(Date>data_start & Date<data_end)
  ggplot(country_date, aes(x=Date,y=new_cases_smoothed_per_million)) +
    geom_line(size=1.2)+
    #theme_dark()+
    theme_minimal()+
    labs(x="",y=tytul_y)+
       
    labs(title = country_name)+
    theme(plot.title = element_text(hjust = 0.5, size =20, face="bold"),
                                    axis.title.x = element_text(color="black", size=14, vjust = 2),
                                    axis.title.y = element_text(color="black", size=18,vjust=2.5),
                                    axis.text = element_text(size=16, color="black")) +
    scale_x_date(labels = date_format("%b"), breaks = date_breaks("month"))
  
  
  
}


#Legenda


abc2("#E64C4C",c(rep(0,137),rep(1,138)))+ ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+
abc2("#D95F02", c((rep(0,39)), (rep(1,39)), (rep(2,39)), (rep(3,39)), (rep(4,39)), (rep(5,40)), (rep(6,40))))+ ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+
abc2("blue4",c(rep(0,92), rep(1,92), rep(2,91))) + ggtitle("Maski")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+
abc2("#1B9E77", c(rep(0,34),rep(1,34),rep(2,34),rep(3,34),rep(4,34),rep(5,35),rep(6,35), rep(7,35))) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+
abc2("#E7298A", c(rep(0,46),rep(1,46),rep(2,46),rep(3,46),rep(4,46),rep(5,45))) +ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+ plot_layout(ncol=1)


ggsave("legenda.png")
# Wykresy



plot_all <-function(country_code,country_name,country_name_data, boola){
  
  stayathome=       restrykcje[[paste(country_name_data,"stayathome",sep="_")]]
  schoolsworkplaces=restrykcje[[paste(country_name_data,"schoolsworkplaces",sep="_")]]
  mask             =restrykcje[[paste(country_name_data,"mask",sep="_")]]
  publicplaces     =restrykcje[[paste(country_name_data,"publicplaces",sep="_")]]
  massgathering    =restrykcje[[paste(country_name_data,"massgathering",sep="_")]]
  
  
  plot(country_code,country_name, boola) +(abc(stayathome,"#E64C4C",1) + ggtitle("Zakaz opuszczania domu")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+
                                      abc(schoolsworkplaces,"#D95F02" ,7) + ggtitle("Szkoła i miejsca pracy")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+
                                      abc(mask,"blue4" ,3) + ggtitle("Maski")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+
                                      abc(publicplaces, "#1B9E77",8) + ggtitle("Przestrzeń publiczna")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+
                                      abc(massgathering, "#E7298A",6) + ggtitle("Zgromadzenia publiczne")+ theme(plot.title = element_text(size=15,hjust = 0.5, vjust=-2))+plot_layout(ncol=1)) +plot_layout(ncol=1)
                                     
  
  
}
plot_all("SWE","Szwecja","sweden", TRUE)
ggsave("szwecja_1.png")
plot_all("POL",'Polska',"poland", TRUE)
ggsave("polska_1.png")
plot_all("DEU",'Niemcy',"germany", TRUE)
ggsave("niemcy_1.png")
plot_all("IND",'Islandia',"iceland", TRUE)
ggsave("islandia_1.png")
plot_all("CZE",'Czechy',"czechia", TRUE)
ggsave("czechy_1.png")
plot_all("ESP",'Hiszpania',"spain", TRUE)
ggsave("hiszpania_1.png")
