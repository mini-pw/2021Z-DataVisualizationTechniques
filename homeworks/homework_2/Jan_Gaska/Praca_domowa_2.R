library(ggplot2)

data_frame <- data.frame(
  "Typ_energii" =  c("Wêgiel kamienny", "Wêgiel brunatny","Gaz ziemny", "Olej opa³owy",
                     "Paliwo j¹drowe","Biomasa","Biogaz","Energia wodna","Energia wiatru","Energia s³oneczna"),
  "Procent" = c(30,23,7,1,19,5,1,1,12,1))

data_frame$Typ_energii <- factor(data_frame$Typ_energii,levels = data_frame$Typ_energii[order(data_frame$Procent)])

ggplot(data_frame, aes(x = Procent,y = Typ_energii,fill = Typ_energii)) +
      geom_col() +
      scale_color_brewer(palette="Dark2") +
      labs(title = "                  Struktura wytwarzania energii elektrycznej w Polsce w 2030 roku", x = "Procent",y = "Typ energii")+
      scale_x_continuous(labels = paste(seq(from = 0, to = 30, by = 5),"%"), breaks = seq(from = 0, to = 30, by = 5))+
      geom_text(aes(label = paste(factor(Procent),"%")),nudge_x = 1) +
      theme_bw()+
      theme(legend.position = "none") 
      