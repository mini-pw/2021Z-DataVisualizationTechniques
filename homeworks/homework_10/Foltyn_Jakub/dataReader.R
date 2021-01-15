library(readxl)
library(dplyr)



math4stat <- read.csv("dat/math4stat.csv")
math8stat <- read.csv("dat/math8stat.csv")
science4stat <- read.csv("dat/science4stat.csv")
science8stat <- read.csv("dat/science8stat.csv")

math4avg <- read.csv("dat/math4avg.csv")
math8avg <- read.csv("dat/math8avg.csv")
science4avg <- read.csv("dat/science4avg.csv")
science8avg <- read.csv("dat/science8avg.csv")

math4avg$Country <- factor(math4avg$Country, levels = math4avg$Country)
math8avg$Country <- factor(math8avg$Country, levels = math8avg$Country)
science4avg$Country <- factor(science4avg$Country, levels = science4avg$Country)
science8avg$Country <- factor(science8avg$Country, levels = science8avg$Country)






