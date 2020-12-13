covid <- read.csv("data/owid-covid-data.csv")
library(ggplot2)

fourCountries <- dplyr::filter(covid, location == "United Kingdom" | location == "Germany" | location == "Norway" | location == "Netherlands")

fourCountries <- dplyr::select(fourCountries, "location", "date", "total_cases_per_million")

ggplot(fourCountries, aes(x = date, y = total_cases_per_million, group = location, color = location)) +
  theme_classic() +
  geom_line(size = 1.25) +
  theme(axis.text.x=element_blank()) +
  ggplot2::labs(title = "Zachorownia na milion w krajach",x = "", y = "")
