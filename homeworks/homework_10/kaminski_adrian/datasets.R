library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggrepel)
library(ggiraph)

### ---- Reading average scores ----

M4 <- read_xlsx("files/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

M8 <- read_xlsx("files/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
S4 <- read_xlsx("files/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
S8 <- read_xlsx("files/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()


### ---- Reading and joining average home resources ----

HR_M4 <- read_xlsx("files/5-2_home-resources-M4.xlsx", skip = 5) %>%
  select(3, 25) %>%
  rename("Home" = "Average \r\nScale Score") %>%
  na.omit()

HR_M4 %>%
  filter(Home != "-") %>%
  mutate(Home = as.numeric(Home)) -> HR_M4

M4 <- inner_join(M4, HR_M4, by = "Country")

HR_M8 <- read_xlsx("files/5-5_home-resources-M8.xlsx", skip = 5) %>%
  select(3, 25) %>%
  rename("Home" = "Average \r\nScale Score") %>%
  na.omit()

HR_M8 %>%
  filter(Home != "-") %>%
  mutate(Home = as.numeric(Home))-> HR_M8

M8 <- inner_join(M8, HR_M8, by = "Country")


HR_S4 <- read_xlsx("files/5-3_home-resources-S4.xlsx", skip = 5) %>%
  select(3, 25) %>%
  rename("Home" = "Average \r\nScale Score") %>%
  na.omit()

HR_S4 %>%
  filter(Home != "-") %>%
  mutate(Home = as.numeric(Home))-> HR_S4

S4 <- inner_join(S4, HR_S4, by = "Country")

HR_S8 <- read_xlsx("files/5-6_home-resources-S8.xlsx", skip = 5) %>%
  select(3, 25) %>%
  rename("Home" = "Average \r\nScale Score") %>%
  na.omit()

HR_S8 %>%
  filter(Home != "-") %>%
  mutate(Home = as.numeric(Home))-> HR_S8

S8 <- inner_join(S8, HR_S8, by = "Country")

### ---- Reading and joining average school discipline ----

SD_M4 <- read_xlsx("files/8-2_school-discipline-M4.xlsx", skip = 4) %>%
  select(3, 24) %>%
  rename("School" = "Average \r\nScale Score") %>%
  na.omit()

SD_M4 %>%
  filter(School != "-") %>%
  mutate(School = as.numeric(School))-> SD_M4

M4 <- inner_join(M4, SD_M4, by = "Country")

SD_M8 <- read_xlsx("files/8-4_school-discipline-M8.xlsx", skip = 4) %>%
  select(3, 24) %>%
  rename("School" = "Average \r\nScale Score") %>%
  na.omit()

SD_M8 %>%
  filter(School != "-") %>%
  mutate(School = as.numeric(School))-> SD_M8

M8 <- inner_join(M8, SD_M8, by = "Country")


SD_S4 <- read_xlsx("files/8-3_school-discipline-S4.xlsx", skip = 4) %>%
  select(3, 24) %>%
  rename("School" = "Average \r\nScale Score") %>%
  na.omit()

SD_S4 %>%
  filter(School != "-") %>%
  mutate(School = as.numeric(School))-> SD_S4

S4 <- inner_join(S4, SD_S4, by = "Country")

SD_S8 <- read_xlsx("files/8-5_school-discipline-S8.xlsx", skip = 4) %>%
  select(3, 24) %>%
  rename("School" = "Average \r\nScale Score") %>%
  na.omit()

SD_S8 %>%
  filter(School != "-") %>%
  mutate(School = as.numeric(School))-> SD_S8

S8 <- inner_join(S8, SD_S8, by = "Country")

### ---- Sorting datasets ----

M4 <- M4 %>%
  arrange(-Score)
M8 <- M8 %>%
  arrange(-Score)
S4 <- S4 %>%
  arrange(-Score)
S8 <- S8 %>%
  arrange(-Score)

### ---- Adding columns ----

MS4_scale_home <- data.frame(value = c(0, 7.4, 11.8, Inf),
                       describtion = c("Few Resources", "Some Resources", "Many Resources", ""))
MS8_scale_home <- data.frame(value = c(0, 8.4, 12.2, Inf),
                             describtion = c("Few Resources", "Some Resources", "Many Resources", ""))
MS4_scale_school <- data.frame(value = c(0, 7.6, 9.7, Inf),
                               describtion = c("Moderate to Severe Problems",
                                               "Minor Problems","Hardly Any Problems", ""))
MS8_scale_school <- data.frame(value = c(0, 8, 10.8, Inf),
                               describtion = c("Moderate to Severe Problems",
                                               "Minor Problems","Hardly Any Problems", ""))
add_scale_describtion <- function(df, df_scale_home, df_scale_school) {
  df %>%
    mutate(Describtion_Home = cut(df$Home, df_scale_home$value,
                                  labels = df_scale_home$describtion[-length(df_scale_home$describtion)]),
           Describtion_School = cut(df$School, df_scale_school$value,
                                    labels = df_scale_school$describtion[-length(df_scale_school$describtion)]))
}

M4 <- add_scale_describtion(M4, MS4_scale_home, MS4_scale_school)
S4 <- add_scale_describtion(S4, MS4_scale_home, MS4_scale_school)
M8 <- add_scale_describtion(M8, MS8_scale_home, MS8_scale_school)
S8 <- add_scale_describtion(S8, MS8_scale_home, MS8_scale_school)

add_tooltips <- function(df) {
  df$tooltip_Home <- c(paste0("Country = ", df$Country,
                              "\nScore = ", df$Score,
                              "\nHome Resources = ", df$Home,
                              "\nDescribiton: ", df$Describtion_Home))
  df$tooltip_School <- c(paste0("Country = ", df$Country,
                                "\nScore = ", df$Score,
                                "\nSchool Discipline = ", df$School,
                                "\nDescribiton: ", df$Describtion_School))
  df$label_Home <- c(paste0(df$Country,
                            "\n(", df$Home, ", ", df$Score, ")"))
  df$label_School <- c(paste0(df$Country,
                            "\n(", df$School, ", ", df$Score, ")"))
  df
}

M4 <- add_tooltips(M4)
M8 <- add_tooltips(M8)
S4 <- add_tooltips(S4)
S8 <- add_tooltips(S8)


### ---- Reading additional data for 2nd plot ----

read.again_hr <- function(path) {
  x <- read_xlsx(path, skip = 5) %>%
    select(3, 7, 8, 13, 14, 19, 20) %>%
    rename("Many_error" = "...8",
           "Some_error" = "...14",
           "Few_error" = "...20") %>%
    na.omit()
  
  x %>%
    filter(Many_error != "-") %>%
    mutate_at(colnames(.)[-1], as.numeric)
}

M4_2 <- read.again_hr("files/5-2_home-resources-M4.xlsx")
M8_2 <- read.again_hr("files/5-5_home-resources-M8.xlsx")
S4_2 <- read.again_hr("files/5-3_home-resources-S4.xlsx")
S8_2 <- read.again_hr("files/5-6_home-resources-S8.xlsx")



read.again_sd <- function(path) {
  x <- read_xlsx(path, skip = 4) %>%
    select(3, 6, 7, 12, 13, 18, 19) %>%
    rename("Hardly_error" = "...7",
           "Minor_error" = "...13",
           "Moderate_error" = "...19") %>%
    na.omit()
  
  x %>%
    mutate_at(colnames(.)[-1], as.numeric)
}

M4_2 <- inner_join(M4_2, read.again_sd("files/8-2_school-discipline-M4.xlsx"),
                   by = "Country")
M8_2 <- inner_join(M8_2, read.again_sd("files/8-4_school-discipline-M8.xlsx"),
                   by = "Country")
S4_2 <- inner_join(S4_2, read.again_sd("files/8-3_school-discipline-S4.xlsx"),
                   by = "Country")
S8_2 <- inner_join(S8_2, read.again_sd("files/8-5_school-discipline-S8.xlsx"),
                   by = "Country")


my_pivot <- function(df) {
  for (i in 1:6) {
    df %>%
      select(c(1,i+i)) %>%
      pivot_longer(2, names_to = "Type",values_to = "Values") %>%
      inner_join(
        df %>%
          select(c(1,i+i+1)) %>%
          pivot_longer(2, values_to = "Error") %>%
          select(-2),
        by = "Country"
      ) %>%
      mutate(Scale = ifelse(i<4, "Home", "School"))-> x
    if (i!=1) {
      y <- rbind(y, x)
    } else {
      y <- x
    }
  }
  y
}

M4_2 <- my_pivot(M4_2)
M8_2 <- my_pivot(M8_2)
S4_2 <- my_pivot(S4_2)
S8_2 <- my_pivot(S8_2)

set_type_to_factor <- function(df) {
  df$Type = factor(df$Type, levels = c("Few Resources", "Some Resources", "Many Resources",
                                       "Moderate to Severe Problems", "Minor Problems", "Hardly Any Problems"))
  df
}
M4_2 <- set_type_to_factor(M4_2)
M8_2 <- set_type_to_factor(M8_2)
S4_2 <- set_type_to_factor(S4_2)
S8_2 <- set_type_to_factor(S8_2)



add_tooltips2 <- function(df) {
  df$tooltip <- c(paste0("Country = ", df$Country,
                         "\nPercent of Students = ", df$Values, "%",
                         "\nError = \u00B1", df$Error,
                         "\nDescribiton: ", df$Type))
  df$label <- c(paste0(df$Values,"% \u00B1 ",df$Error,"%"))
  df
}

M4_2 <- add_tooltips2(M4_2)
M8_2 <- add_tooltips2(M8_2)
S4_2 <- add_tooltips2(S4_2)
S8_2 <- add_tooltips2(S8_2)

dataset1 <- list(M4,M8,S4,S8)
dataset2 <- list(M4_2,M8_2,S4_2,S8_2)

rm(list = ls()[which(!(ls()%in%c("dataset1", "dataset2")))])
