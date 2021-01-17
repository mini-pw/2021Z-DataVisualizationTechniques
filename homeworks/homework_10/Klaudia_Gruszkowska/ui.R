library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(readxl)

S8_gender <- read_xlsx("./TIMSS-2019/4-6_achievement-gender-trends-S8.xlsx",skip = 6)%>%
  select(2,4,6,8,10,12,14)%>%
  na.omit()
colnames(S8_gender)<- c("Country","Score_2019_G","Score_2019_M","Score_2015_G","Score_2015_M","Score_2011_G","Score_2011_M")
kraje <- S8_gender$Country

fluidPage(
  titlePanel("TIMSS 2019"),
  p("TIMSS (Trends in Mathematics and Science Achievement) to międzynarodowe badanie
     oceniające wiedzę uczniów z matematyki i przyrody.",style = "color:grey"),
  br(),
  br(),
  
  sidebarPanel(
    selectInput("przedmiot",
                label = "Wybierz przedmiot",
                choices = c("Matematyka","Przyroda"),
                selected = "Matematyka"),
    selectInput("klasa",
                label = "Wybierz klasę",
                choices = c("4","8"),
                selected = "4"),
    selectInput("country_1",
                label = "Wybierz państwo 1",
                choices = kraje,
                selected = "Australia"),
    helpText("Państwa muszą sie różnic!"),
    selectInput("country_2",
                label = "Wybierz państwo 2",
                choices = kraje,
                selected = "Chile"),
    helpText("Musi być zaznaczony choć jeden rok!"),
    checkboxGroupInput("years",
                       "Lata :",
                       c("2019" ,
                         "2015" ,
                         "2011" ),
                       selected = c("2019","2015","2011"),
                       inline = TRUE
                       )
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Państwo 1", plotlyOutput("boxplot")),
      tabPanel("Państwo 2",plotlyOutput("boxplot_2")),
      tabPanel("Porównanie",plotlyOutput("boxplot_3")),
      tabPanel("Wyniki z podziałem na płeć",plotlyOutput("gender_plot")),
      tabPanel("Więcej o TIMSS",br(),br(),h5("TIMSS (Trends in Mathematics and Science Achievement) to międzynarodowe badanie
     oceniające wiedzę uczniów z matematyki i przyrody."),br(), "Realizowane jest w klasach IV
     i VIII, ale Polska przystępuje jedynie do badania czwartoklasistów. TIMSS przeprowadzany jest od 1995 roku. W badaniu z 2019 roku wzięły udział łącznie 64 kraje (58
     krajów w czwartej klasie oraz 39 krajów w ósmej klasie). Dane dla Polski dostępne są co prawda od 2011 roku, ale w pierwszej edycji TIMSS w Polsce uczestniczyli uczniowie
     trzecich klas, przez co dane nie są porównywalne w czasie. Od 2015 roku w badaniu uczestniczą polscy czwartoklasiści, więc zmiany wyników można analizować tylko
     w okresie ostatnich czterech lat."),
      tabPanel("Autor",br(),br(),"Klaudia Gruszkowska "),
      tabPanel("Dane",br(),br(),p("DANE: "),
               a("https://timss2019.org/reports/download-center/"))
    )
  ),
  
  
  
  
  
)