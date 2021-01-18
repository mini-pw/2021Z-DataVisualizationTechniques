library(readxl)
library(dplyr)

Country = c(rep("Armenia",3),
               rep("Australia",4),
               rep("Austria",3),
               rep("Azerbaijan",2),
               rep("Bahrain",3),
               rep("Belgium (Flemish)",3),
               rep("Bulgaria",2),
               rep("Canada",2),
               rep("Chinese Taipei",4),
               rep("Croatia",3),
               rep("Cyprus",2),
               rep("Czech Republic",4),
               rep("Denmark",4),
               rep("England",4),
               rep("Finland",3),
               rep("France",2),
               rep("Georgia",4),
               rep("Germany",4),
               rep("Hong Kong SAR",4),
               rep("Hungary",4),
               rep("Iran, Islamic Rep. of",4),
               rep("Ireland",3),
               rep("Italy",4),
               rep("Japan",4),
               rep("Kazakhstan",2),
               rep("Korea, Rep. of",3),
               rep("Lithuania",4),
               rep("Malta",2),
               rep("Morocco",3),
               rep("Netherlands",4),
               rep("New Zealand",4),
               rep("Northern Ireland",3),
               rep("Norway (5)",2),
               rep("Oman",3),
               rep("Poland",2),
               rep("Portugal",3),
               rep("Qatar",3),
               rep("Russian Federation", 4),
               rep("Serbia",3),
               rep("Singapore",4),
               rep("Slovak Republic",4),
               rep("South Africa (5)",2),
               rep("Spain",3),
               rep("Sweden",4),
               rep("United Arab Emirates",3),
               rep("United States",4))


#tabelki do barplotów
#content M4
M4_content_trends <- read_xlsx("./chosendata/1-15_content-domains-trends-M4.xlsx", skip = 7) %>%
  select(3, 5, 15, 25) %>%
  na.omit() %>%
  rename("Year" = "Country") %>%
  as.data.frame() %>%
  filter(row_number() <= n()-15)

M4_content_trends = mutate(M4_content_trends,Country)

M4_content_trends[["Number"]] <- as.numeric(M4_content_trends[["Number"]])
M4_content_trends[["Data"]] <- as.numeric(M4_content_trends[["Data"]])
M4_content_trends[["Measurement and Geometry"]] <- as.numeric(M4_content_trends[["Measurement and Geometry"]])

#cognitive M4

Country1 = c(rep("Armenia",3),
            rep("Australia",4),
            rep("Austria",3),
            rep("Azerbaijan",2),
            rep("Bahrain",3),
            rep("Belgium (Flemish)",3),
            rep("Bulgaria",2),
            rep("Canada",2),
            rep("Chile",3),
            rep("Chinese Taipei",4),
            rep("Croatia",3),
            rep("Cyprus",2),
            rep("Czech Republic",4),
            rep("Denmark",4),
            rep("England",4),
            rep("Finland",3),
            rep("France",2),
            rep("Georgia",4),
            rep("Germany",4),
            rep("Hong Kong SAR",4),
            rep("Hungary",4),
            rep("Iran, Islamic Rep. of",4),
            rep("Ireland",3),
            rep("Italy",4),
            rep("Japan",4),
            rep("Kazakhstan",2),
            rep("Korea, Rep. of",3),
            rep("Lithuania",4),
            rep("Malta",2),
            rep("Morocco",3),
            rep("Netherlands",4),
            rep("New Zealand",4),
            rep("Northern Ireland",3),
            rep("Norway (5)",2),
            rep("Oman",3),
            rep("Poland",2),
            rep("Portugal",3),
            rep("Qatar",3),
            rep("Russian Federation", 4),
            rep("Serbia",3),
            rep("Singapore",4),
            rep("Slovak Republic",4),
            rep("South Africa (5)",2),
            rep("Spain",3),
            rep("Sweden",4),
            rep("United Arab Emirates",3),
            rep("United States",4))

M4_cognitive_trends <- read_xlsx("./chosendata/1-18_cognitive-domains-trends-M4.xlsx", skip = 7) %>%
  select(3, 5, 15, 25) %>%
  na.omit() %>%
  rename("Year" = "Country") %>%
  as.data.frame() %>%
  filter(row_number() <= n()-15)


M4_cognitive_trends <- M4_cognitive_trends %>% 
  mutate(M4_cognitive_trends,Country1) %>%
  rename("Country" = "Country1")

M4_cognitive_trends[["Knowing"]] <- as.numeric(M4_cognitive_trends[["Knowing"]])
M4_cognitive_trends[["Applying"]] <- as.numeric(M4_cognitive_trends[["Applying"]])
M4_cognitive_trends[["Reasoning"]] <- as.numeric(M4_cognitive_trends[["Reasoning"]])

  
#scatter
#M4 content
M4_content_2019 <- read_xlsx("./chosendata/1-14_content-domains-results-M4.xlsx", skip = 4) %>%
  select(3, 5, 8, 15, 22) %>%
  na.omit() %>%
  as.data.frame() %>%
  filter(row_number() <= n()-6) %>%
  rename("Overall Average" = "Overall Mathematics Average \r\nScale Score") %>%
  rename("Number" = "Number\r\n(83 Items)") %>%
  rename("Measurement and Geometry" = "Measurement and Geometry\r\n(52 Items)") %>%
  rename("Data" = "Data\r\n(36 Items)")


M4_content_2019[["Number"]] <- as.numeric(M4_content_2019[["Number"]])
M4_content_2019[["Data"]] <- as.numeric(M4_content_2019[["Data"]])
M4_content_2019[["Measurement and Geometry"]] <- as.numeric(M4_content_2019[["Measurement and Geometry"]])

#M4 cognitive
M4_cognitive_2019 <- read_xlsx("./chosendata/1-17_cognitive-domains-results-M4.xlsx", skip = 4) %>%
  select(3, 5, 8, 15, 22) %>%
  na.omit() %>%
  as.data.frame() %>%
  filter(row_number() <= n()-6) %>%
  rename("Overall Average" = "Overall Mathematics Average \r\nScale Score") %>%
  rename("Knowing" = "Knowing\r\n(59 Items)") %>%
  rename("Applying" = "Applying\r\n(74 Items)") %>%
  rename("Reasoning" = "Reasoning\r\n(38 Items)")


M4_cognitive_2019[["Knowing"]] <- as.numeric(M4_cognitive_2019[["Knowing"]])
M4_cognitive_2019[["Applying"]] <- as.numeric(M4_cognitive_2019[["Applying"]])
M4_cognitive_2019[["Reasoning"]] <- as.numeric(M4_cognitive_2019[["Reasoning"]])


#######wczytywanie M8 #####################


#M8 content bar

Country3 = c(rep("Australia",4),
            rep("Bahrain",4),
            rep("Chile",3),
            rep("Chinese Taipei",4),
            rep("Cyprus",2),
            rep("Egypt",3),
            rep("England",4),
            rep("Finland",2),
            rep("Georgia",4),
            rep("Hong Kong SAR",4),
            rep("Hungary",4),
            rep("Iran, Islamic Rep. of",4),
            rep("Ireland",2),
            rep("Israel",3),
            rep("Italy",4),
            rep("Japan",4),
            rep("Jordan",4),
            rep("Kazakhstan",2),
            rep("Korea, Rep. of",4),
            rep("Lebanon",4),
            rep("Lithuania",4),
            rep("Malaysia",4),
            rep("Morocco",3),
            rep("New Zealand",3),
            rep("Norway (9)",2),
            rep("Oman",4),
            rep("Qatar",3),
            rep("Romania",3),
            rep("Russian Federation", 4),
            rep("Singapore",4),
            rep("Sweden",4),
            rep("Turkey",3),
            rep("United Arab Emirates",3),
            rep("United States",4))


M8_content_trends <- read_xlsx("./chosendata/3-15_content-domains-trends-M8.xlsx", skip = 7) %>%
  select(3, 5, 15, 25, 35) %>%
  na.omit() %>%
  rename("Year" = "Country") %>%
  as.data.frame() %>%
  filter(row_number() <= n()-15)

M8_content_trends = mutate(M8_content_trends,Country3) %>%
  rename("Country" = "Country3")

M8_content_trends[["Number"]] <- as.numeric(M8_content_trends[["Number"]])
M8_content_trends[["Algebra"]] <- as.numeric(M8_content_trends[["Algebra"]])
M8_content_trends[["Geometry"]] <- as.numeric(M8_content_trends[["Geometry"]])
M8_content_trends[["Data and Probability"]] <- as.numeric(M8_content_trends[["Data and Probability"]])


###M8 cognitive 

Country2 = c(rep("Australia",4),
             rep("Bahrain",4),
             rep("Chile",3),
             rep("Chinese Taipei",4),
             rep("Cyprus",2),
             rep("Egypt",3),
             rep("England",4),
             rep("Finland",2),
             rep("Hong Kong SAR",4),
             rep("Hungary",4),
             rep("Iran, Islamic Rep. of",4),
             rep("Ireland",2),
             rep("Israel",3),
             rep("Italy",4),
             rep("Japan",4),
             rep("Jordan",4),
             rep("Kazakhstan",2),
             rep("Korea, Rep. of",4),
             rep("Lebanon",4),
             rep("Lithuania",4),
             rep("Malaysia",4),
             rep("Morocco",3),
             rep("New Zealand",3),
             rep("Norway (9)",2),
             rep("Oman",4),
             rep("Qatar",3),
             rep("Romania",3),
             rep("Russian Federation", 4),
             rep("Singapore",4),
             rep("Sweden",4),
             rep("Turkey",3),
             rep("United Arab Emirates",3),
             rep("United States",4))

M8_cognitive_trends <- read_xlsx("./chosendata/3-18_cognitive-domains-trends-M8.xlsx", skip = 7) %>%
  select(3, 5, 15, 25) %>%
  na.omit() %>%
  rename("Year" = "Country") %>%
  as.data.frame() %>%
  filter(row_number() <= n()-15)


M8_cognitive_trends <- M8_cognitive_trends %>% 
  mutate(M8_cognitive_trends, Country2) %>%
  rename("Country" = "Country2")

M8_cognitive_trends[["Knowing"]] <- as.numeric(M8_cognitive_trends[["Knowing"]])
M8_cognitive_trends[["Applying"]] <- as.numeric(M8_cognitive_trends[["Applying"]])
M8_cognitive_trends[["Reasoning"]] <- as.numeric(M8_cognitive_trends[["Reasoning"]])


#M8 cognitive

M8_cognitive_2019 <- read_xlsx("./chosendata/3-17_cognitive-domains-results-M8.xlsx", skip = 4) %>%
  select(3, 5, 8, 15, 22) %>%
  na.omit() %>%
  as.data.frame() %>%
  filter(row_number() <= n()-6) %>%
  rename("Overall Average" = "Overall Mathematics Average \r\nScale Score") %>%
  rename("Knowing" = "Knowing\r\n(64 Items)") %>%
  rename("Applying" = "Applying\r\n(96 Items)") %>%
  rename("Reasoning" = "Reasoning\r\n(46 Items)")


M8_cognitive_2019[["Knowing"]] <- as.numeric(M8_cognitive_2019[["Knowing"]])
M8_cognitive_2019[["Applying"]] <- as.numeric(M8_cognitive_2019[["Applying"]])
M8_cognitive_2019[["Reasoning"]] <- as.numeric(M8_cognitive_2019[["Reasoning"]])




####s M8 content

M8_content_2019 <- read_xlsx("./chosendata/3-14_content-domains-results-M8.xlsx", skip = 4) %>%
  select(3, 5, 8, 15, 22, 29) %>%
  na.omit() %>%
  as.data.frame() %>%
  filter(row_number() <= n()-6) %>%
  rename("Overall Average" = "Overall Mathematics Average \r\nScale Score") %>%
  rename("Number" = "Number\r\n(63 Items)") %>%
  rename("Algebra" = "Algebra\r\n(61 Items)") %>%
  rename("Geometry" = "Geometry\r\n(43 Items)") %>%
  rename("Data and Probability" = "Data and Probability\r\n(39 Items)") 
  


M8_content_2019[["Number"]] <- as.numeric(M8_content_2019[["Number"]])
M8_content_2019[["Algebra"]] <- as.numeric(M8_content_2019[["Algebra"]])
M8_content_2019[["Geometry"]] <- as.numeric(M8_content_2019[["Geometry"]])
M8_content_2019[["Data and Probability"]] <- as.numeric(M8_content_2019[["Data and Probability"]])

Countries <- c(Country, Country1, Country2, Country3) %>%
  unique() %>%
  sort()

write.csv(M4_content_trends,"./processeddata/M4_content_trends.csv", row.names = FALSE)
write.csv(M4_content_2019,"./processeddata/M4_content_2019.csv", row.names = FALSE)
write.csv(M4_cognitive_trends,"./processeddata/M4_cognitive_trends.csv", row.names = FALSE)
write.csv(M4_cognitive_2019,"./processeddata/M4_cognitive_2019.csv", row.names = FALSE)


write.csv(M8_content_trends,"./processeddata/M8_content_trends.csv", row.names = FALSE)
write.csv(M8_content_2019,"./processeddata/M8_content_2019.csv", row.names = FALSE)
write.csv(M8_cognitive_trends,"./processeddata/M8_cognitive_trends.csv", row.names = FALSE)
write.csv(M8_cognitive_2019,"./processeddata/M8_cognitive_2019.csv", row.names = FALSE)


write.csv(Countries,"./processeddata/Countries.csv", row.names = FALSE)

