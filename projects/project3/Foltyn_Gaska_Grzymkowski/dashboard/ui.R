library(DT)
library(plotly)

navbarPage(
  "Nasze dane pomocy studenta",
  tabPanel(
    "Porównanie ogólne",
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "domain_select",
          label = "Wybierz domenę lub kliknij na słupek poniżej:",
          choices = c("stackoverflow.com",
                      "wikipedia.org",
                      "github.com",
                      "pw.edu.pl",
                      "youtube.com",
                      "google.com",
                      "facebook.com",
                      "instagram.com"),
          selected = "stackoverflow.com"),
        plotOutput("plot_comp", click = "plot_comp_click", height = "300px"),
        h2("Cześć!"),
        p("Skoro już do nas zajrzałeś, to zechcemy opowiedzieć Ci o naszym projekcie, który przedwsięwzieliśmy z zajęć TWD.
          Trzech śmiałków: Kacper, Jakub oraz Janek dobrodusznie udostępnili swoje dane przeglądarkowe by móc poddać je analizie.
          Sprawdzone zostało w jakim stopniu korzystali ze ston znanych każdemu szanującemu się studentowi IT, porkoju stackoverflow czy github.\n
          Nasze przestawiliśmy na trzech stonach, na każdej z nich ukazana została inna idea naszej analizy. Zapraszamy do użytkowania !!!
          "),
        # p("Oto link do repozytorium zawierające cały projekt:", tags$a(href="https://github.com/niegrzybkowski/studia_twd_p3","github.com/niegrzybkowski/studia_twd_p3")),
        hr(),
        print("Projekt przygotowany przez Kacpra Grzymkowskiego, Jakuba Fołtyna, Jana Gąske")


      ),
      mainPanel(plotOutput("plot_1", height = "500px"),
                p("Powyższy wykres przedstawia powównanie dynamiki zmian ilości średniej liczby wejść, zestawionej dla każdego z nas,
                  dla wybranej przez Ciebie stony. Dynamika zestawiona została dla całego okresu pobioru danych, tudzież od stycznia 2020 do
                  początku stycznia 2021 roku.")
      )
    )
  ),
  tabPanel("Średnia aktywność w tygodniu",
           sidebarPanel(
             selectInput("user_select1",
                         label = "Wybierz użytkownika:",
                         choices = c("Kacper" = "kacper",
                                     "Jakub" = "jakub",
                                     "Janek" = "jan"),
                         multiple = FALSE,
                         selected = "Kacper"),
             selectInput("day_select1",
                         label = "Wybierz dzień tygodnia:",
                         choices = c("poniedziałek" = "pon",
                                     "wtorek" = "wt",
                                     "środa" = "sr",
                                     "czwartek" = "czw",
                                     "piątek" = "pia",
                                     "sobota" = "sob",
                                     "niedziela" = "niedz"),

                         multiple = FALSE,
                         selected = "Poniedziałek"),
             selectInput("domain_select1",
                         label = "Wybierz domenę:",
                         choices = c("stackoverflow.com",
                                     "wikipedia.org",
                                     "github.com",
                                     "pw.edu.pl",
                                     "youtube.com",
                                     "google.com",
                                     "facebook.com",
                                     "instagram.com"),
                         selected = "stackoverflow.com"),
             h3("Kiedy i jak często odwiedzamy dane domeny?"),
             p("Jakie są nasze nawyki, kiedy najbardziej lubimy odwiedzać daną stronę, kiedy potrzebujemy jej pomocy, w jaki dzień tygodnia
               , w jaką godzinę i kto jest najbardziej skłonny do ich odwiedzania?"),
             p("Przedstawione po prawej wykresy informują Cię właśnie a propos powyższych pytań, zebrane średnie odzwierciedlają nasze dane średniej ilości
               wejść na dany dzień tygodnia, oraz na poszczególne godziny w wybranym dniu tygodnia. Dociekając w danych możesz łatwo dopatrzeć się ciekawych wyników,
               na przykład, zmniejszonej ilości wejść na strony programistyczne w weekendy, oraz dowiedzieć się kto jest nocnym markiem, a kto rannym ptaszkiem")
           ),
           mainPanel(
             plotOutput("plot_weekdays", click = "plot_click"),
             plotOutput("plot_weekhours")
           )),
  tabPanel(
    "Balans rozrywka/edukacja",
    br(),
    br(),
    sidebarPanel(
      h4("Nie samą pracą człowiek żyje."),
      p("Ciężka praca się opłaca, jednakże rozrywka i relaks również są ważne, w tej części przygotowaliśmy animację porównującą wejścia
        dwóch użytkowników na strony o charakterze edukacyjnym i na strony o charakterze rozrywkowym, w całym okresie analizy danych."),
      p("Położenie na osi X informuje o ilości wejść na stony rozrywkowe, a oś Y ilość wejść na strony edukacyjne.")
      ),
    mainPanel(
      plotlyOutput("plotly_scatter")
    )
  ))
