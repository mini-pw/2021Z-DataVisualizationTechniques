library(readxl)
library(dplyr)

# This file is used to preprocess data. 


fileExtension <- ".xlsx"
path <- "rawData/"

processMathsHours <- function(path,filename,fileExtension){
  my_data <- read_excel(paste(path,filename,fileExtension,sep=""))
  endOfCountries <- which(apply(my_data[3], 1, function(r) r == c("International Average")))
  df <- my_data %>%
    select(c(3,6,10)) %>%
    slice(6:endOfCountries-1) 
  colnames(df) <- c("Country","TotalHours","MathsHours")
  df <- df %>%
    mutate_at(c("TotalHours","MathsHours"),as.numeric)
  write.csv(df,paste("finalData/",filename,".csv",sep=""))
}


processScienceHours <- function(path,filename,fileExtension){
  my_data <- read_excel(paste(path,filename,fileExtension,sep=""))
  endOfCountries <- which(apply(my_data[3], 1, function(r) r == c("International Average")))
  df <- my_data %>%
    select(c(3,6,10)) %>%
    slice(6:endOfCountries-1) 
  colnames(df) <- c("Country","TotalHours","ScienceHours")
  df <- df %>%
    mutate_at(c("TotalHours","ScienceHours"),as.numeric)
  write.csv(df,paste("finalData/",filename,".csv",sep=""))
}


processAchievements <- function(path,filename,fileExtension){
  my_data <- read_excel(paste(path,filename,fileExtension,sep=""))
  print(my_data)
  df <- my_data %>%
    select(c(3,5,7,9,11,13,15))
  df<-df[-c(1,2,3,4,5), ]
  endOfCountries <- which(apply(df[1], 1, function(r) is.na(r)))
  df <- df%>%
    slice(1:endOfCountries[1]-1)
  colnames(df) <- c("Country","2019","2015","2011","2007","2003","1995")
  df <- df %>%
    mutate_at(c("2019","2015","2011","2007","2003","1995"),as.numeric)
  write.csv(df,paste("finalData/",filename,".csv",sep=""))
}

processAchievementsSheet2 <- function(path,filename,fileExtension){
  my_data <- read_excel(paste(path,filename,fileExtension,sep=""),sheet=2)
  end1<- which(apply(my_data[1], 1, function(r) r == c("Benchmarking Participants")))
  end2<- which(apply(my_data[2], 1, function(r) r == c("Benchmarking Participants")))
  endOfCountries<-max(end1,end2)
  df <- my_data %>%
    select(c(1,3,19,20,5,23,24)) %>%
    slice(7:endOfCountries-1)
  df[1,1]<-"Country"
  
  for (i in 2:nrow(df)){
    if(is.na(df[i,3])){
      if(!is.na(df[i,2])){
        df[i,1]=df[i,2]
      }
      
    }
  }
  for (i in 1:nrow(df)){
    if(is.na(df[i,1])){
      if(!is.na(df[i-1,1])){
        df[i,1]=df[i-1,1]
      }
    }
  }
  df[1,2]<-"Year"
  for (i in 1:nrow(df)){
    if(is.na(df[i,3])) {
      df<-df[-c(i), ]
    }
  }
  df <- df%>%
    slice(3:nrow(df))
  colnames(df)<-c("Country","Year","5P","25P","AVG/50P","75P","95P")
  df <- df %>%
    mutate_at(c("Year","5P","25P","AVG/50P","75P","95P"),as.numeric)
  write.csv(df,paste("finalData/",filename,"Sheet2",".csv",sep=""))
}

processAchievements <- function(path,filename,fileExtension){
  my_data <- read_excel(paste(path,filename,fileExtension,sep=""))
  print(my_data)
  df <- my_data %>%
    select(c(3,5,7,9,11,13,15))
  df<-df[-c(1,2,3,4,5), ]
  endOfCountries <- which(apply(df[1], 1, function(r) is.na(r)))
  df <- df%>%
    slice(1:endOfCountries[1]-1)
  colnames(df) <- c("Country","2019","2015","2011","2007","2003","1995")
  df <- df %>%
    mutate_at(c("2019","2015","2011","2007","2003","1995"),as.numeric)
  write.csv(df,paste("finalData/",filename,".csv",sep=""))
}

processAchievementsSheet2x2 <- function(path,filename,fileExtension){
  my_data <- read_excel(paste(path,filename,fileExtension,sep=""),sheet=2)
  end1<- which(apply(my_data[1], 1, function(r) r == c("Benchmarking Participants")))
  end2<- which(apply(my_data[2], 1, function(r) r == c("Benchmarking Participants")))
  endOfCountries<-max(end1,end2)
  df <- my_data %>%
    select(c(1,3,21,22,5,25,26)) %>%
    slice(7:endOfCountries-1)
  df[1,1]<-"Country"
  
  for (i in 2:nrow(df)){
    if(is.na(df[i,3])){
      if(!is.na(df[i,2])){
        df[i,1]=df[i,2]
      }
      
    }
  }
  for (i in 1:nrow(df)){
    if(is.na(df[i,1])){
      if(!is.na(df[i-1,1])){
        df[i,1]=df[i-1,1]
      }
    }
  }
  df[1,2]<-"Year"
  for (i in 1:nrow(df)){
    if(is.na(df[i,3])) {
      df<-df[-c(i), ]
    }
  }
  df <- df%>%
    slice(3:nrow(df))
  colnames(df)<-c("Country","Year","5P","25P","AVG/50P","75P","95P")
  df <- df %>%
    mutate_at(c("Year","5P","25P","AVG/50P","75P","95P"),as.numeric)
  write.csv(df,paste("finalData/",filename,"Sheet2",".csv",sep=""))
}

processMathsHours(path,"12-2_instruction-time-M4",fileExtension)
processMathsHours(path,"12-3_instruction-time-M8",fileExtension)
processScienceHours(path,"13-2_instruction-time-S4",fileExtension)
processScienceHours(path,"13-3_instruction-time-S8",fileExtension)

processAchievements(path,"1-4_achievement-trends-M4",fileExtension)
processAchievements(path,"2-4_achievement-trends-S4",fileExtension)
processAchievements(path,"3-4_achievement-trends-M8",fileExtension)
processAchievements(path,"4-4_achievement-trends-S8",fileExtension)

processAchievementsSheet2(path,"1-4_achievement-trends-M4",fileExtension)
processAchievementsSheet2(path,"2-4_achievement-trends-S4",fileExtension)
processAchievementsSheet2x2(path,"3-4_achievement-trends-M8",fileExtension)
processAchievementsSheet2x2(path,"4-4_achievement-trends-S8",fileExtension)
