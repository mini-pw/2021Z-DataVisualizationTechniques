library(shinydashboard)
library(ggiraph)  
# Sys.setlocale("LC_ALL", "Polish")


dashboardPage(
  dashboardHeader(
    title = 'TWD projekt nr 3'
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("o Wykresach", tabName = "info_o_wykresach", icon = icon("chart-bar")),
      menuItem("o Projekcie", tabName = "info", icon = icon("th")),
      radioButtons("type", "Klikając punkt chcę analizować dane:", # raczej do zmiany
                   choices = c(
                     "konkretnej osoby" = "name",
                     "z konkretnego dnia" = "update_time",
                     "z konkretnego dnia tygodnia" = "dayofweek"
                     # jeśli pojdzie dobrze to mozna dodac dzien tygodnia
                     # moze wtedy znajdzie sie jakies zaleznosci jakies
                   ))
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(
        rel="shortcut icon",
        href="https://www.nicepng.com/png/detail/112-1120886_sleep-png-icon-free-sleep-icon-png.png"
      )
    ),
    tags$head(tags$style(HTML('
        .skin-blue .main-header .navbar {
                              background-color: #222d32;
                              }
      '))),
    tags$head(tags$style(HTML('
        .skin-blue .main-header .logo {
          background-color: #222d32;
        }
        .skin-blue .main-header .logo:hover {
          background-color: #222d32;
        }
      '))),
    tags$head(tags$style(HTML('
       .skin-blue .main-header .navbar .sidebar-toggle:hover{
    background-color: #222d32;
      }
      '))),
    tags$head(tags$style(HTML('* {
        font-family: Arial,sans-serif;
      }'))),
    tags$head(tags$style(HTML('
      .content-wrapper {
        background-color: #d4d2cf;
      }
    '
    ))),
    tags$head(tags$style(HTML("hr {border-top: 1px solid #d4d2cf;}"))),
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                column(width = 2,
                       girafeOutput("dayofweek", height = "175px")
                       ),
                column(width = 4,
                       girafeOutput("plot1", height = "175px")),
                column(width = 1,
                       girafeOutput("legend", height = "175px")
                       ),
                column(width = 5,
                       girafeOutput("plot2", height = "175px")
                       )
              ),hr(),
              fluidRow(
                column(width = 7,
                  girafeOutput("plot3", height = "350px")
                ),
                column(width = 5,
                           girafeOutput("plot45", height = "350px")
                )
              ),
              fluidRow(
                column(width = 12,
                       div(style = "margin: auto; width: 90%",
                           sliderInput("date", "Wybierz zakres dni dla których dane chcesz zobaczyć*",
                                min = as.Date("2020-12-20","%Y-%m-%d"),
                                max = as.Date("2021-01-15","%Y-%m-%d"),
                                value = as.Date(c("2020-12-20", "2021-01-15"),"%Y-%m-%d"),
                                timeFormat = "%Y-%m-%d",
                                width = "100%")
                           ),
                    uiOutput("slider_middle"),
                    uiOutput("slider_from_to")
                    )
                )
              ),
      
      tabItem(tabName = "info_o_wykresach",
              p(
                "Wskaźnik kondycji psychicznej - jest to średnia ważona
                naszych subiektywnych ocen w skali od 1 do 10 odnośnie 
                samopoczucia, motywacji do nauki i motywacji do wstania rano.
                Samopoczucie jest liczone z wagą 2, motywacja do nauki 1, 
                a motywacja do wstania rano z wagą 3."
              ),
              p(
                "Jakość snu – procentowa wartość zwracana
                przez aplikację Sleep Cycle, która ma obrazować
                jak dobrze się wyspaliśmy. "
              ),
              p(
                "Okrągłe gałki na obu końcach zaznaczonego obszaru
                dotyczą tylko jednego wybranego dnia.
                Czerwony kolor oznacza dzień, w którym nie biegaliśmy,
                a niebieski dzień, w którym biegaliśmy. 
                Jeśli w zaznaczonym zakresie liczba dni z bieganiem
                jest równa liczbie dni bez biegania, kolor zmienia się na biały.
                Jeśli jest więcej dni z bieganiem, kolor zmienia się na niebieski
                według gradientu (odpowiednio dla stosunku liczby dni z bieganiem 
                a liczby dni bez biegania). "
              )
              ),
      
      tabItem(tabName = "info",
              h1("Informacje o autorach"),
              p("Projekt wykonali:"),
              p("Karol Degórski, Adrianna Grudzień oraz Adrian Kamiński"),
              
              h1("Opis projektu"),
              h4("Założenia"),
              p(
                "Stworzona przez nas aplikacja bada zależności związane z naszym
                zdrowiem. Przeprowadzilimy eksperyment polegajcy na 22-dniowym
                wyzwaniu."
              ),
              p(
              "W ciągu  pierwszych 11 dni nie zmienialiśmy w naszych codziennych
              przyzwyczajeniach niczego, zaś w pozostałe dni kaźdy z uczestników
              eksperymentu zaczął uprawniać aktywność fizyczną, tj. przebiegł
              2 km. W czasie trwania całego eksperymentu ocenialiśmy poziom 
              naszego samopoczucia, motywacji do nauki oraz motywacji do
              wstawania rano (w skali od 0 do 10). Mierzyliśmy również aspekty
              związane ze snem (m.in. liczbę przespanych godzin oraz 
              jakość snu); a także wykonywaną przez nas dzienną liczbę kroków
              i związane z nią inne parametry ruchu. Wyniki naszego eksperymentu
              przedstawiliśmy na interaktywnym dashboardzie."
              ),
              h4("Wykorzystane narzędzia"),
              p(
                '"Samsung Health" - mierzenie parametrów aktywności fizycznej'
              ),
              p(
                '"Sleep Cycle" - informacje o śnie'
              )
      )
    )
  )
)
# Sys.setlocale("LC_CTYPE", "Polish")
