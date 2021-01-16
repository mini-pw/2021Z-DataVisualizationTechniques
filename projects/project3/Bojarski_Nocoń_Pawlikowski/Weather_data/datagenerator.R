library(dplyr)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

data<-read.csv("k_d_04_2018.csv")
data<-data.frame(data)
colnames(data)<-1:18
data<-data%>%
  filter(.[[1]]=="252200230")
for(j in 5:9){
  tst<-paste("k_d_0",j,"_2018.csv",sep="")
  data1<-read.csv(tst)%>%
    filter(.[[1]]=="252200230")
  data1<-data.frame(data1)
  colnames(data1)<-1:18
  data<-rbind(data,data1)
}
for(j in 10:12){
  tst<-paste("k_d_",j,"_2018.csv",sep="")
  data1<-read.csv(tst)%>%
    filter(.[[1]]=="252200230")
  data1<-data.frame(data1)
  colnames(data1)<-1:18
  data<-rbind(data,data1)
}
for(j in 1:9){
  tst<-paste("k_d_0",j,"_2019.csv",sep="")
  data1<-read.csv(tst)%>%
    filter(.[[1]]=="252200230")
  data1<-data.frame(data1)
  colnames(data1)<-1:18
  data<-rbind(data,data1)
}
for(j in 10:12){
  tst<-paste("k_d_",j,"_2019.csv",sep="")
  data1<-read.csv(tst)%>%
    filter(.[[1]]=="252200230")
  data1<-data.frame(data1)
  colnames(data1)<-1:18
  data<-rbind(data,data1)
}
for(j in 1:9){
  tst<-paste("k_d_0",j,"_2020.csv",sep="")
  data1<-read.csv(tst)%>%
    filter(.[[1]]=="252200230")
  data1<-data.frame(data1)
  colnames(data1)<-1:18
  data<-rbind(data,data1)
}

  tst<-paste("k_d_",10,"_2020.csv",sep="")
  data1<-read.csv(tst)%>%
    filter(.[[1]]=="252200230")
  data1<-data.frame(data1)
  colnames(data1)<-1:18
  data<-rbind(data,data1)
  data<-data%>%
    select(c(3,4,5,10,14,16))
  colnames(data)<-c("year","month","day","temperature","precipitation","precipitation_type")
data<-data%>%
  replace(.=="", "dry")%>%
  replace(.=="S", "snow")%>%
  replace(.=="W", "rain")
  
  


write.csv(data, "weatherdata.csv")

