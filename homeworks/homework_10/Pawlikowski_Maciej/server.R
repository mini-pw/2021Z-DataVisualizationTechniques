
library(ggplot2)
library(plotly)
library(dplyr)
library("readxl")
library(dplyr)
library("rnaturalearth")
library("rnaturalearthdata")
library(ggplot2)
library("sf")
library("rgeos")


function(input, output, session){
  output$plotly_3<-renderPlotly({
    
    M42019 <- read_xlsx("1-1_achievement-results-M4.xlsx", skip = 4) %>%
      select(3, 9,10,11,5,12,13,14) %>%
      rename("Score" = "Average \r\nScale Score") %>%
      filter(Country=="Singapore"|Country=="Malesia"|Country=="Indonesia"|Country=="Vietnam")%>%
    na.omit()
    M82019 <- read_xlsx("3-1_achievement-results-M8.xlsx", skip = 4) %>%
      select(3, 9,10,11,5,12,13,14) %>%
      rename("Score" = "Average \r\nScale Score") %>%
      filter(Country=="Singapore"|Country=="Malesia"|Country=="Indonesia"|Country=="Vietnam")%>%
    na.omit()
    S42019 <- read_xlsx("2-1_achievement-results-S4.xlsx", skip = 4) %>%
      select(3, 9,10,11,5,12,13,14) %>%
      rename("Score" = "Average \r\nScale Score") %>%
      filter(Country=="Singapore"|Country=="Malesia"|Country=="Indonesia"|Country=="Vietnam")%>%
    na.omit()
    S82019 <- read_xlsx("4-1_achievement-results-S8.xlsx", skip = 4) %>%
      select(3, 9,10,11,5,12,13,14) %>%
      rename("Score" = "Average \r\nScale Score") %>%
      filter(Country=="Singapore"|Country=="Malesia"|Country=="Indonesia"|Country=="Vietnam")%>%
    na.omit()
    data=data.frame(x='M4', y=as.numeric(t(M42019[1,2:8])))
    data=rbind(data,data.frame(x='M8', y=as.numeric(t(M82019[1,2:8]))))
    data=rbind(data,data.frame(x='S4', y=as.numeric(t(S42019[1,2:8]))))
    data=rbind(data,data.frame(x='S8', y=as.numeric(t(S82019[1,2:8]))))
    if (input$check1 == 1){
    plt<-data%>%
      ggplot(aes(x=x,y=y))+
      geom_boxplot(fill="slateblue", alpha=0.2)+
      scale_y_continuous(limits=c(0,800))+
      theme(axis.title.x=element_blank(),axis.title.y=element_blank())+
      ggtitle("2019 results")
    }else{
      data=data.frame(x1='M4', y1=t(M42019[1,5]))
      data=rbind(data,data.frame(x1='M8', y1=t(M82019[1,5])))
      data=rbind(data,data.frame(x1='S4', y1=t(S42019[1,5])))
      data=rbind(data,data.frame(x1='S8', y1=t(S82019[1,5])))
      plt<-data%>%
        ggplot(aes(x=x1,y=y1))+
        geom_bar(fill="slateblue",stat = 'identity', alpha=0.6,width=0.3)+
        coord_cartesian(ylim=c(0,800))+
        geom_hline(yintercept = 500)+
        theme(axis.title.x=element_blank(),axis.title.y=element_blank())+
        ggtitle("2019 results")
    }
    ggplotly(plt)
  })
  output$plotly_4<-renderPlotly({
    date=c('1986','1994','1998','2002','2006')
    math=c((605-590)/590,(593-595)/595,(611-600)/600,(622-606)/606,(616-618)/618)
    science=c((568-524)/524,(567-565)/565,(590-587)/587,(597-583)/583,(608-591)/591)
    if(input$input_1=='M'){
      plt<-data.frame(x=date,y=math)%>%
        mutate(Color = ifelse(y > 0, "forestgreen", "firebrick4")) %>%
        ggplot(aes(x=x,y=y,fill=Color))+
        geom_bar(stat='identity')+
        scale_fill_identity()+
        theme(
          legend.position="none"
        )+
        theme(axis.title.x=element_blank(),axis.title.y=element_blank())+
        ggtitle("Vintage result change in math")
    }
    if(input$input_1=='S'){
      plt<-data.frame(x=date,y=science)%>%
        mutate(Color = ifelse(y > 0, "forestgreen", "firebrick4")) %>%
        ggplot(aes(x=x,y=y,fill=Color))+
        geom_bar(stat='identity')+
        theme(
          legend.position="none"
          )+
        scale_fill_identity()+
        theme(axis.title.x=element_blank(),axis.title.y=element_blank())+
        ggtitle("Vintage result change in science")
    }
    if(input$input_1=='MS'){
      df<-data.frame(date,math,science)
      require(reshape2)
      df <- melt(df, id = "date")
      plt<-df%>%
        ggplot(aes(x=date,y = value, fill = variable))+
        geom_bar( position = "dodge",stat='identity')+
        theme(axis.title.x=element_blank(),axis.title.y=element_blank())+
        ggtitle("Vintage result change")
    }
    ggplotly(plt)
  })
  output$plotly_2<-renderPlotly({
    
    scale=input$plot_1_sample
    x1=102.07
    x2=106.13
    y1=0.01
    y2=2.78
    world <- ne_countries(scale = "medium", returnclass = "sf")
    world$mapcolor13[world$sovereignt=="Singapore"]<-100
    if(scale==0){
      plt<-world%>%
        ggplot+
        geom_sf(aes(fill=mapcolor13),color='white')+
        coord_sf(xlim = c(x1-30, x2+30), ylim = c(y1-30, y2+30))+
        theme(legend.position='none',
              axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank(),
              axis.title.y=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks.y=element_blank(),
              panel.grid.minor=element_blank(),
              panel.grid.major=element_blank())+
        ggtitle("Singapore Location")
    }
    if(scale==1){
      plt<-world%>%
        ggplot+
        geom_sf(aes(fill=mapcolor13),color='white')+
        coord_sf(xlim = c(x1-10, x2+10), ylim = c(y1-10, y2+10), expand = FALSE)+
        theme(legend.position='none',
              axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank(),
              axis.title.y=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks.y=element_blank(),
              panel.grid.minor=element_blank(),
              panel.grid.major=element_blank())+
        ggtitle("Singapore Location")
        
    }
    if(scale==2){
      plt<-world%>%
        ggplot+
        geom_sf(aes(fill=mapcolor13),color='white')+
        coord_sf(xlim = c(x1, x2), ylim = c(y1-2, y2+2), expand = FALSE)+
        theme(legend.position='none',
              axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank(),
              axis.title.y=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks.y=element_blank(),
              panel.grid.minor=element_blank(),
              panel.grid.major=element_blank())+
        ggtitle("Singapore Location")
    }
    
    ggplotly(plt)
    
    
  })
 
  
}
