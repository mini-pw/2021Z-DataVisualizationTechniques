library(SmarterPoland)
head(countries)
qnt <- quantile(countries$birth.rate, na.rm = TRUE)
countries$birth.rate.quant <- cut(countries$birth.rate, qnt, include.lowest = TRUE)

########
library(rpivotTable)

rpivotTable(countries)

rpivotTable(countries,
            cols = "continent",
            aggregatorName = "Average", vals = "birth.rate",
            rendererName = "Heatmap")
# wiersze mozna definiowac przez rows
# Mozna uzywac w Shiny przez funkcje `renderRpivotTable()` oraz `rpivotTableOutput()`.


#########
library(visNetwork)

nodes <- data.frame(id = 1:4,
                    label = c("Białystok", "Warszawa", "Radom", "Sosnowiec"))

edges <- data.frame(from = c(2, 3, 4),
                    to = c(3, 4, 2),
                    color = "red")

net <- visNetwork(nodes, edges, height = 600, width = 1000)
net

visNetwork(nodes, edges, height = 600, width = 1000) %>%
  visEdges(arrows = "to") %>%
  visLayout(randomSeed = 123)

# Zapisywanie do html funkcją visSave()

#########
library(DiagrammeR)

diagram <- "
graph TB
A[START]==>B{Text <br/> B?}
B== BL != 0 ==>C[Text C]
B== BL ==0 ==> Cbis[Text Cbis]
C==>D[END]
Cbis ==> A
"

DiagrammeR(diagram)


















