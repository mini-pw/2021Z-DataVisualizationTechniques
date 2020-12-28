library(readxl)
library(dplyr)

# This file is used to preprocess data. 
# Input .xlsx files are located in 'chosenData' folder in current directory. 
# Output .csv files are saved to folder called 'processedData' in current directory.


fileExtension <- ".xlsx"
path <- "chosenData/"

processBenchmarkResults <- function(path,filename,fileExtension){
  my_data <- read_excel(paste(path,filename,fileExtension,sep=""))
  endOfCountries <- which(apply(my_data[3], 1, function(r) r == c("International Median")))
  df <- my_data %>%
    select(c(3,5,8,11,14)) %>%
    slice(6:endOfCountries-1) 
  colnames(df) <- c("Country","Advanced","High","Intermediate","Low")
  df <- df %>%
    mutate_at(c("Advanced","High","Intermediate","Low"),as.numeric)
  write.csv(df,paste("processedData/",filename,".csv",sep=""))
}


processAverageResults <- function(path,filename,fileExtension){
  my_data <- read_excel(paste(path,filename,fileExtension,sep=""))
  endOfCountries <- which(apply(my_data[1], 1, function(r) r == c("Benchmarking Participants")))
  df <- my_data %>%
    select(c(3,5)) %>%
    slice(6:endOfCountries-1) 
  colnames(df) <- c("Country","Average")
  df <- df %>%
    mutate_at(c("Average"),as.numeric) %>%
    filter(Country != "TIMSS Scale Centerpoint")%>%
    arrange(-Average) 
  
  write.csv(df,paste("processedData/",filename,".csv",sep=""))
}


processBenchmarkResults(path,"1-8_benchmarks-results-M4",fileExtension)
processBenchmarkResults(path,"2-8_benchmarks-results-S4",fileExtension)
processBenchmarkResults(path,"3-8_benchmarks-results-M8",fileExtension)
processBenchmarkResults(path,"4-8_benchmarks-results-S8",fileExtension)

processAverageResults(path,"1-1_achievement-results-M4",fileExtension)
processAverageResults(path,"2-1_achievement-results-S4",fileExtension)
processAverageResults(path,"3-1_achievement-results-M8",fileExtension)
processAverageResults(path,"4-1_achievement-results-S8",fileExtension)

