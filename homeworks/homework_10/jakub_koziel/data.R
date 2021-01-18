library(dplyr)
library("readxl")
library(plotly)

M4_results <- read_xlsx("TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 11, 12, 13, 14) %>%
  na.omit()


colnames(M4_results) <- c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
                          "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")


S4_results <- read_xlsx("TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 11, 12, 13, 14) %>%
  na.omit()


colnames(S4_results) <- c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
                          "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")


M8_results <- read_xlsx("TIMSS-2019/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 11, 12, 13, 14) %>%
  na.omit()


colnames(M8_results) <- c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
                          "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")



S8_results <- read_xlsx("TIMSS-2019/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5, 9, 10, 11, 12, 13, 14) %>%
  na.omit()


colnames(S8_results) <- c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
                          "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")






M4_trends <- read_xlsx("TIMSS-2019/1-3_achievement-trends-M4.xlsx", skip = 4) %>%
  select(3, 5, 7, 9, 11, 13, 15)


colnames(M4_trends) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")
M4_trends <- M4_trends %>% filter(!is.na(Country))



M8_trends <- read_xlsx("TIMSS-2019/3-3_achievement-trends-M8.xlsx", skip = 4) %>%
  select(2, 5, 7, 9, 11, 13, 15) 


colnames(M8_trends) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")
M8_trends <- M8_trends %>% filter(!is.na(Country))


S4_trends <- read_xlsx("TIMSS-2019/2-3_achievement-trends-S4.xlsx", skip = 4) %>%
  select(3, 5, 7, 9, 11, 13, 15) 


colnames(S4_trends) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")
S4_trends <- S4_trends %>% filter(!is.na(Country))


S8_trends <- read_xlsx("TIMSS-2019/4-3_achievement-trends-S8.xlsx", skip = 4) %>%
  select(2, 5, 7, 9, 11, 13, 15)


colnames(S8_trends) <- c("Country", "2019", "2015", "2011", "2007", "2003", "1995")
S8_trends <- S8_trends %>% filter(!is.na(Country))



########## tab2

# data <- M4_trends %>% filter(Country == "Australia")
# v <- as.numeric(data[1,2:7])
# 
# 
# 
# 
# df2 <- data.frame("year" = c(2019, 2015, 2011, 2007, 2003, 1995),
#                   "score" = v)
# 
# 
# fig <- plot_ly(df2, type = 'scatter', mode = 'lines')
# fig <- fig %>% add_trace(x=~year, y=~score, mode = "lines+markers", showlegend = FALSE)
# 
# 
# fig<- fig %>% layout(xaxis = list(range = c(1990, 2024)), yaxis = list(range = c(280, 620)))
# 
# fig

############################ 1 tab
#M4_results %>% select(2:8)

# 
# cols.num <- c("Average_Scale_Score","5th_Percentile", "25th_Percentile",
#               "95_Confidence_Interval_1", "95_Confidence_Interval_2", "75th_Percentile", "95th_Percentile")
# 
# 
# M4_results[cols.num] <- sapply(M4_results[cols.num],as.numeric)
# 
# 
# M4_results<-M4_results %>% 
#   tidyr::pivot_longer(
#     cols = c("5th_Percentile", "25th_Percentile",
#              "95_Confidence_Interval_1", "95_Confidence_Interval_2", "75th_Percentile", "95th_Percentile"), 
#     names_to = "type", 
#     values_to = "result")
# ?pivot_longer
# lapply(M4_results, class)
# 
# library(ggplot2)
# library(tidyverse) 
# fig <- ggplot(M4_results, aes(x=result, y=Country))  + geom_point(aes(colour = type))
# fig
# 
# library(plotly)
# ggplotly(fig)
# 
# M4_results
# plot_ly(M4_results, x = ~result, y = ~Country, marker = list(size = 10,
#                                                              color = 'rgba(255, 182, 193, .9)',
#                                                              line = list(color = 'rgba(152, 0, 0, .8)',
#                                                                          width = 2)))
# 
# 
# c("Country", "Average_Scale_Score","th5_Percentile", "th25_Percentile",
#   "a_95Confidence_Interval_1", "a_95Confidence_Interval_2", "th75_Percentile", "th95_Percentile")
# 
# 
# 
# fig <- plot_ly(M4_results)
# 
# fig <- fig %>% add_segments(x = ~th5_Percentile, xend = ~th95_Percentile, y = ~Country, yend = ~Country, line = list(color = '#7f7f7f'))
# 
# 
# fig <- fig %>% add_markers(x = ~th5_Percentile, y = ~Country, name = "5th percentile",  marker = list(color = '#1f77b4') )
# fig <- fig %>% add_markers(x = ~th25_Percentile, y = ~Country, name = "25th percentile", marker = list(color = '#ff7f0e'))
# fig <- fig %>% add_markers(x = ~th75_Percentile, y = ~Country, name = "75th percentile", marker = list(color = '#ff7f0e') )
# fig <- fig %>% add_markers(x = ~th95_Percentile, y = ~Country, name = "95th percentile", marker = list(color = '#1f77b4'))
# 
# 
# fig <- fig %>% add_segments(x = ~a_95Confidence_Interval_1, xend = ~a_95Confidence_Interval_2, y = ~Country, yend = ~Country, line = list(color = '#17becf'))
# 
# fig <- fig %>% layout(height = 650,
#                       xaxis = list(title = "Score"))
# 
# 
# fig
# 
# data_score <- M4_results %>% filter(Country == "Sweden")
# data_score
# 
# 
# fig <- fig %>% add_segments(data = data_score, x = ~th5_Percentile, xend = ~th95_Percentile, y = ~Country, yend = ~Country, line = list(color = 'red'))
# fig

# 
# 
# fig <- fig %>% add_segments(x = ~x25th_p, xend = ~x75th_p, y = ~Country, yend = ~Country)
# fig <- fig %>% add_markers(x = ~x25th_p, y = ~Country, name = "25th percentile")
# fig <- fig %>% add_markers(x = ~x75th_p, y = ~Country, name = "75th percentile")
# fig <- fig %>% add_segments(x = ~x95_conf_1, xend = ~x95_conf_2, y = ~Country, yend = ~Country)
# fig <- fig %>% add_markers(x = ~x95_conf_1, y = ~Country, name = "95% confidence", color = I("black"))
# fig <- fig %>% add_markers(x = ~x95_conf_2, y = ~Country, name = "95% confidence", color = I("black"))
# fig <- fig %>% layout(height = 650, font=list(family="Montserrat"), yaxis=list(title = ""),
#                       xaxis = list(title = "Score"))


