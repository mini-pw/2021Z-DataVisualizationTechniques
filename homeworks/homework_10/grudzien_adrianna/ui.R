library(DT)
library(plotly)
source("timss-get-data.R")


pageWithSidebar(
  
  headerPanel("Wyniki TIMSS 2019"),
  sidebarPanel(
    
    selectInput('przedmiot',
                label = "Wybierz przedmiot:",
                choices = c("matematyka", "przyroda"),
                selected = "matematyka"),
    selectInput('klasa',
                label = "Wybierz klasę:",
                choices = c("IV", "VIII"),
                selected = "IV"),
    selectInput('kraj',
                label = "Wybierz kraj:",
                choices = sort(unique(c(M4$Country, M8$Country, S4$Country, S8$Country))),
                selected = "Poland"),
    helpText("TIMSS bada poziom wiedzy i rozumowania uczniów w zakresie matematyki 
             i nauk przyrodniczych. Badanie przeprowadzane jest na poziomie klas 
             czwartych i ósmych.W badaniu ankiety wypełniane są przez uczniów, 
             rodziców, nauczycieli matematyki i przedmiotów przyrodniczych oraz 
             dyrektorów szkół.")
  ),
    
  
  mainPanel(
    tabsetPanel(
      tabPanel("Średni wynik",icon=icon("award"),
               selectInput('top', label = "Wybierz przedział:",
                           choices = c("najlepsze 30", "najgorsze 30",
                                       "najlepsze 50", "najgorsze 50",
                                       "wszystkie"),
                           selected = "najlepsze 30"),
               plotlyOutput("wykres1")),
      tabPanel("Szkolna dyscyplina",icon=icon("bullhorn"),
               selectInput('problem', label = "Wybierz poziom problemu z dyscypliną:", choices = 
                             c("prawie żadnych problemów","drobne problemy"),
                           selected = "prawie żadnych problemów"),
               plotlyOutput("wykres2")),
      tabPanel("Dodatkowe informacje",icon=icon("child"),
               helpText("Uzupełnienie do wykresu dt dyscypliny w szkole: Pytania
               zawarte w ankietach dotyczyły m.in.: spóźniania się na lekcje, nieobecności,
                        przeszkadzania podczas lekcji, ściągania, profanacji, wandalizmu itp."),
               helpText(),
               helpText("Data publikacji: 29.12.2020r."),
               helpText("Źródło danych: ",
                        tags$a(href="https://timss2019.org/reports/download-center/", "https://timss2019.org/reports/download-center/"))
      )
    )
  )
)
