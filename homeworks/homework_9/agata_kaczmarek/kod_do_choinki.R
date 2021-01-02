library(rbokeh)
library(maps)
data(world.cities)
world.cities
caps <- subset(world.cities, capital == 1)

colors_to_tree<-rep(0, 230)

#1 to te co bêd¹ zielone, jak choinka
  colors_to_tree[caps$name=="Longyearbyen"]<-1
  colors_to_tree[caps$name=="Dublin"]<-1
  colors_to_tree[caps$name=="Moscow"]<-1
  colors_to_tree[caps$name=="Longyearbyen"]<-1
  colors_to_tree[caps$name=="Luxemburg"]<-1
  colors_to_tree[caps$name=="Kiev"]<-1
  colors_to_tree[caps$name=="Lisbon"]<-1
  colors_to_tree[caps$name=="Yerevan"]<-1
  colors_to_tree[caps$name=="Algiers"]<-1
  colors_to_tree[caps$name=="Ankara"]<-1
  colors_to_tree[caps$name=="al-'Ayun"]<-1
  colors_to_tree[caps$name=="al-Kuwayt"]<-1
  colors_to_tree[caps$name=="San'a"]<-1
  colors_to_tree[caps$name=="Asmara"]<-1
  colors_to_tree[caps$name=="Khartoum"]<-1
  colors_to_tree[caps$name=="Nouakchott"]<-1
  colors_to_tree[caps$name=="Muscat"]<-1
  colors_to_tree[caps$name=="Banjul"]<-1
  colors_to_tree[caps$name=="Bamako"]<-1
  colors_to_tree[caps$name=="Bissau"]<-1
  colors_to_tree[caps$name=="Ouagadougou"]<-1
  colors_to_tree[caps$name=="Niamey"]<-1
  colors_to_tree[caps$name=="N'Djamena"]<-1
#2 to pieñ
  colors_to_tree[caps$name=="Libreville"]<-2
  colors_to_tree[caps$name=="Kampala"]<-2
#3 to bombki pierwsze
  colors_to_tree[caps$name=="Tripoli"]<-3
  colors_to_tree[caps$name=="Riyadh"]<-3
  colors_to_tree[caps$name=="Cairo"]<-3
  colors_to_tree[caps$name=="Sofia"]<-3
  colors_to_tree[caps$name=="Warsaw"]<-3
  colors_to_tree[caps$name=="Madrid"]<-3
  colors_to_tree[caps$name=="Oslo"]<-3
#4 to bombki drugie
  colors_to_tree[caps$name=="Riga"]<-4
  colors_to_tree[caps$name=="Chisinau"]<-4
  colors_to_tree[caps$name=="Abu Dhabi"]<-4
  colors_to_tree[caps$name=="Amsterdam"]<-4
  colors_to_tree[caps$name=="Tunis"]<-4
  colors_to_tree[caps$name=="Athens"]<-4

  

caps2<-cbind(caps,colors_to_tree)
caps2$population <- prettyNum(caps$pop, big.mark = ",")
#kolorowe bombki
caps5 <- subset(caps2, colors_to_tree == 3)
caps6 <- subset(caps2, colors_to_tree == 4)
#zielona czesc choinki
caps3 <- subset(caps2, colors_to_tree == 1)
last_row<-caps3[caps3$name=="Longyearbyen",]
caps3<-rbind(caps3, last_row)
str(caps3)
caps3$sort<-c(19,5,9,14,16,15,22,10,3,20,1,21,2,7,11,12,17,13,8,4,18,6,23)
caps3<-caps3[order(caps3$sort),]
#pieñ choinki
colors_to_tree[caps2$name=="N'Djamena"]<-2
colors_to_tree[caps2$name=="Khartoum"]<-2
caps2<-cbind(caps,colors_to_tree)
caps4 <- subset(caps2, colors_to_tree == 2)
last_row<-caps4[caps4$name=="Khartoum",]
caps4<-rbind(caps4, last_row)
caps4$sort<-c(2,1,3,4,5)
caps4<-caps4[order(caps4$sort),]


figure(width = 800, height = 450, padding_factor = 0) %>%
  ly_map("world", col = "gray") %>%
  ly_points(long, lat, data = caps3, size = 5,
            hover = c(name, country.etc, population), color="#006633")%>%
  ly_points(long, lat, data = caps4, size = 5,
            hover = c(name, country.etc, population), color="#663300")%>%
  ly_points(long, lat, data = caps5, size = 5,
            hover = c(name, country.etc, population), color="#3333FF")%>%
  ly_points(long, lat, data = caps6, size = 5,
            hover = c(name, country.etc, population), color="#CC0066")%>%
  ly_lines(long, lat, data = caps3, color="#006633", width=2)%>%
  ly_lines(long, lat, data = caps4, color="#663300", width=2)


