

findAllCountries <- function(){
  df <- data.frame(Country = c(0))

for(file in dir("./data", pattern = "*.csv")){
  df1 <- read.csv(paste("./data/", file, sep = ""), stringsAsFactors = FALSE)
  df1 <- as.data.frame(df1[, "Country"])
  colnames(df1) <- c("Country")
  df <- rbind(df, df1)
}

df <- df[-1, ]
df <- unique(df)

df

write.csv(df, "countries.csv", row.names = FALSE)
}

findAllCountries()

