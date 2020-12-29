library(ggplot2)
library(sf)
library(cartography)
library(tmap)
library(dplyr)

### Set working directory ###
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


### Import to an sf object ###
regions <- st_read("Powiaty.shp", 
                   quiet = TRUE, 
                   options = "ENCODING=UTF8")

# get Mazowieckie Voivodeship
regions <- regions[regions$JPT_JOR_ID == "13409", ] 


### Import covid data ##
covid <- read.table("covid_cases.txt", 
                    header = TRUE, 
                    sep = "\t", 
                    encoding = 'UTF-8')

# change date column name
colnames(covid)[1] <- "date" 
colnames(covid)[3] <- "JPT_NAZWA_"

# set lower cases letters in the names of municipalities 
covid$JPT_NAZWA_ <- tolower(covid$JPT_NAZWA_)
regions$JPT_NAZWA_ <- tolower(regions$JPT_NAZWA_)


### Import mobility data ###
mobility <- read.table("commuting_to_work_2016.txt",
                       header = TRUE, 
                       sep = "\t", 
                       encoding= 'UTF-8')

# get only Mazowieckie Voivodeship
mobility <- mobility[mobility$living_voivodeship == "Mazowieckie" & 
                       mobility$working_voivodeship == "Mazowieckie", ]

# extract only municipality id
mobility$id_living_municipality <- sub("^(\\d{4}).*$", "\\1", 
                                       mobility$id_living_municipality)
mobility$id_working_municipality <- sub("^(\\d{4}).*$", "\\1", 
                                        mobility$id_working_municipality)

# remove people that only moves within municipality borders
mobility <- mobility[mobility$id_living_municipality 
                     != mobility $id_working_municipality, ]

# aggregate people who live in the same municipality
# and work in the same municipality
mobility <- aggregate(mobility$number_of_people, 
                      by = list(id_working_municipality = mobility$id_working_municipality, 
                              id_living_municipality = mobility$id_living_municipality), 
                      FUN = sum)

# sum all migrations, non directional
mobility$temp <- as.numeric(mobility$id_living_municipality) * 
  as.numeric(mobility$id_working_municipality)
mobilityTemp <- aggregate(mobility$x,
                       by = list(temp = mobility$temp),
                       FUN = sum)
mobility <- left_join(mobilityTemp, mobility[, -3], by = "temp")
mobility <- mobility[!duplicated(mobility$temp), ]


### Get neighborhood data to filter ###
neighborhood <- read.table("neighborhood.txt",
                           header = TRUE, 
                           sep = "\t", 
                           encoding= 'UTF-8')
mobility$temp <- as.numeric(mobility[, 3]) * as.numeric(mobility[, 4])
neighborhood$temp <- neighborhood$id1 * neighborhood$id2
mobility$neighboors <- sapply(mobility$temp, function(x) {
  sum(sapply(neighborhood$temp, function(y) {
    x == y
    }))
  })

# delete cities inside of municipalities except Warsaw
mobility[(as.numeric(mobility[, 3]) > 1460 | 
            as.numeric(mobility[, 4]) > 1460) & 
           (as.numeric(mobility[, 3]) != 1465 & 
              as.numeric(mobility[, 4]) != 1465), 5] <- 0

# some dumb datata, because package requires two variables
mobility$temp <- rep("Mazowieckie", nrow(mobility))

### Create link layer to the map ###
mobility_map <- getLinkLayer(
  x = regions, 
  xid = "JPT_KOD_JE", 
  df = mobility[mobility$neighboors == 1 & mobility$x > 100, ], 
  dfid = c("id_living_municipality", "id_working_municipality")
)

# plot municipalities
plot(st_geometry(regions), 
     bg = "white")

date <- "01.11.2020"

# color regions
choroLayer(
  x = left_join(regions, covid[covid$date == date, ], by = "JPT_NAZWA_"),
  var = "infected_total",
  method = "quantile",
  nclass = 10,
  col = carto.pal(pal1 = "red.pal", n1 = 10),
  border = "grey90",
  legend.pos = "topright",
  legend.title.txt = "Infected total",
  legend.title.cex = 1,
  legend.values.cex = 1,
)

gradLinkTypoLayer(
  x = mobility_map, 
  xid = c("id_living_municipality", "id_working_municipality"),
  df = mobility,
  breaks =  c(100, 200, 400, 1500, 25000),
  dfid = c("id_living_municipality", "id_working_municipality"),
  var = "x",
  var2 = "temp",
  col = "black",
  legend.var.title.txt = "Commuting people",
  legend.var2.pos = "n",
  legend.title.cex = 1,
  legend.values.cex = 1
  
)
