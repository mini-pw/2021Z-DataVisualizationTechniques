library(ggplot2)
library(dplyr)
library(readxl)
library(readr)
library(scales)
library(lubridate)
Sys.setlocale("LC_TIME", "English")

MIESIACE <- c("styczeń","luty","marzec","kwiecień","maj","czerwiec","lipiec","sierpień","wrzesień","październik","listopad","grudzień")

ConfCases <- read_csv("data/biweekly-confirmed-covid-19-cases.csv", 
                                              col_types = cols(`Biweekly cases` = col_number(), 
                                                               `Biweekly cases Annotations` = col_skip(), 
                                                               Date = col_date(format = "%Y-%m-%d")))
ConfCases <- ConfCases %>% filter(Code == "POL") %>% select(Date, cases = `Biweekly cases`)
MonCases <- aggregate(ConfCases[,2],list(month(ConfCases$Date)),sum) %>% select(mies = Group.1,cases) %>% filter(mies < 10)
temp <- data.frame(c(1,2),c(0,0))
names(temp) <- c("mies","cases")
MonCases <- rbind(temp,MonCases)
MonCases$mies <- MIESIACE[MonCases$mies]

IntMovRes <- read_csv("data/internal-movement-covid.csv", 
                      col_types = cols(Date = col_date(format = "%Y-%m-%d"), 
                                       restrictions_internal_movements = col_integer()))
IntMovRes <- IntMovRes %>% filter(Code == "POL") %>% select(Date, restrictions_internal_movements)

ExtMovRes <- read_csv("data/international-travel-covid.csv", 
                      col_types = cols(Date = col_date(format = "%Y-%m-%d"), 
                                       international_travel_controls = col_integer()))
ExtMovRes <- ExtMovRes %>% filter(Code == "POL") %>% select(Date, international_travel_controls)

Turystyka <- read_excel("data/Turstyka.xlsx", 
                        col_types = c("skip", "skip", "text", 
                                              "skip", "skip", "numeric", "numeric", 
                                              "skip", "skip"))
Turystyka <- Turystyka %>% select(Rok, Miesiące, Wartosc)
Turystyka2020 <- Turystyka %>% filter(Rok==2020)
Turystyka2020 <- Turystyka2020 %>% rename(Mies = Miesiące) %>% select(Mies, Wartosc)
Turystyka <- Turystyka %>% filter(Rok!=2020)

Turystyka$Miesiące <- match(Turystyka$Miesiące, MIESIACE)
Turystyka2020$Mies <- match(Turystyka2020$Mies, MIESIACE)

stacje_tranzytowe <- read_csv("data/visitors-transit-covid.csv", 
                                   col_types = cols(Date = col_date(format = "%Y-%m-%d")))
stacje_tranzytowe <- stacje_tranzytowe %>% filter(Code == "POL") %>% select(Date, transit_stations)

Aver20152019 <- aggregate(Turystyka[,3], list(Turystyka$Miesiące), mean)
temp <- aggregate(Turystyka[,3], list(Turystyka$Miesiące), sd)
Aver20152019 <- merge(Aver20152019, temp, by = "Group.1")
Aver20152019 <- Aver20152019 %>% rename(Mies = Group.1, Srednia = Wartosc.x, sd = Wartosc.y)

SredI20 <- merge(Aver20152019, Turystyka2020)
SredI20 <- SredI20 %>%
  mutate(Mies =  factor(Mies+1, levels = 2:13)) %>%
  arrange(Mies)   
SredI20$Day <- ymd(paste(2020,SredI20$Mies,1,sep = "-"))

#ggplot() +
#  geom_path(data = stacje_tranzytowe, aes(x=Date, y=transit_stations, group=1)) +
#  labs(x="",y="Liczba osób na stacjach tranzytowych\n względem początku roku (%)", color = " ") +
#  theme(legend.position = "none")

#ggplot() +
#    geom_path(data = ConfCases %>% filter(Date < "2020-09-01"), aes(x=Date, y=`cases`, group=1)) +
#    labs(x="",y="Liczba potwierdzonych zakarzeń w tygodniu", color = " ") +
#    theme(legend.position = "none") +
#    scale_y_continuous(labels = comma)

#ggplot() +
#    geom_path(data = ConfCases, aes(x=Date, y=`cases`, group=1)) +
#    labs(x="",y="Liczba potwierdzonych zakarzeń w tygodniu", color = " ") +
#    theme(legend.position = "none") +
#    scale_y_continuous(labels = comma)

ggplot() +
  geom_ribbon(data = SredI20,aes(x=Day, ymax= Srednia - Wartosc + sd,ymin= Srednia - Wartosc - sd,group = 1), 
              fill="#ff0000",alpha =.2) +
  geom_line(data = SredI20,aes(x=Day, y=Srednia - Wartosc,colour="Red", group=2), lwd=1.5) +
  
  geom_line(data= ConfCases%>%filter(Date<ymd("2020-10-2")), aes(x=Date, y=200*cases, colour="Green", group=1), alpha=.8, lwd=1.5) +
  scale_y_continuous(
    labels = c(0,"1 M","2 M","3 M","4 M"),
    breaks = 10^6 * c(0,1,2,3,4),
    name = "Difference betwean the mean of 2015-2019\nand value in 2020",

    sec.axis = sec_axis( trans=~.*1/10, name="Infections",
                         labels = c("0","4 K","8 K","12 K","16 K","20 K"), 
                         breaks = 2*10^4 * c(0,4,8,12,16,20))
    ) +
  
  
  #geom_line(data= Turystyka, aes(x=Miesiące, y=10*cases, group=1), color="Black", alpha=.5) +
  

  #geom_path(data = SredI20, aes(x=Mies, y=Srednia, group=1, color="red")) +
  #geom_path(data = SredI20, aes(x=Mies, y=Wartosc, group=1, color="green")) +

  scale_color_manual(name = "", labels = c("Infections", "Difference in tourism"),values = c("#0000ff", "#ff0000"))+
  scale_x_date(date_labels="%b",date_breaks  ="1 month", limits = c(ymd("2020-2-1"),ymd("2020-10-2")))+
  #xlim(ymd("2020-2-1"),ymd("2020-10-2")) +
  labs(x="",y="") +
  theme_minimal() +
#  theme(axis.text.y = element_text( color="#993333")) 
 theme(legend.position = c(0.15, 0.8),
       legend.text=element_text(size=16),
       axis.text.y.right = element_text(color = "blue",size = 16),
       axis.text.y.left= element_text(color = "red",size = 16),
       axis.text.x = element_text(size = 16),
       axis.title.y.left = element_text(size = 16),
       axis.title.y.right = element_text(size = 16)) 












