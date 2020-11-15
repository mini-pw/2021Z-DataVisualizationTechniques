# Projekt 2

## Temat

Celem drugiego projektu jest przygotowanie plakatu w formacie pdf, który przedstawi graficznie najciekawsze wyniki eksploracji danych dotyczacych COVID-19.

## Opis

Plakat powinien składać się ze zbioru przynajmniej 3 wykresów oraz komentarzy/opisów do wykresów. Projekt ten realizowany jest w zespołach 3 osobowych (grupy różne od tych z Projektu 1). Kody zródłowe wykresów, plakat i prezentację należy umiescic na GitHubie. Ostateczny wynik projektu prezentowany jest na wykładzie (2 min).

Wykresy mogą być wykonane w dowolnym narzędziu i złożone w plakat z uzyciem dowolnej techniki.

Przykładowe plakaty z poprzedniego roku można znaleźć pod adresem https://github.com/mini-pw/2020Z-TechnikiWizualizacjiDanych/tree/master/Projekt1, a sprzed dwóch lat http://smarterpoland.pl/index.php/2018/12/data-movies-and-ggplot2/.

Na plakacie powinna znajdować sie informacja identyfikujaca autorów. Można umieszczać imiona i nazwiska.

Nie warto na plakacie umieszczać wszystkich możliwych statystyk, to jest zresztą niemożliwe. Plakat powinien objaśniać jedną rzecz, ale objaśniać ją dobrze.

## Dane

[COVID-19 w Polsce](https://docs.google.com/spreadsheets/d/1ierEhD6gcq51HAm433knjnVwey4ZE5DCnu1bW7PRG3E/htmlview) lub/i [COVID-19 na świecie](https://ourworldindata.org/coronavirus)

Bonusowe punkty można dostać za wykorzystanie dodatkowego ciekawego zbioru danych (np. jeden z powyższych + https://trends.google.com/trends/?geo=PL).

## Ocena

Za ten projekt można otrzymać od 0 do 15 punktów, z czego:

- **24/11**: do 2 punktów uzyskuje się za update (ok. 6 min): Opis wybranego zbioru danych i przedstawienie pytań/tez do sprawdzenia (bonus za dwuwymiarowe wykresy zależności, które będą wyjściem do kolejnego etapu).
- **01/12**: do 2 punktów uzyskuje się za update (ok. 6 min): Prezentacja przygotowanego raportu z eksploracji danych, na których będzie oparty plakat. Raport powinien zawierać 4-6 wielowymiarowych zależności (razem z kodem wrzucany jest wcześniej na repozytorium).
- **08/12**: do 2 punktów uzyskuje sie za zaprezentowanie **prototypu plakatu** (tytuł, wybrane wizualizacje, zarys opisu, kolorystyka plakatu, theme wykresów, rozmieszczenie elementów)
- **14/12**: do 9 punktów uzyskuje się za plakat i prezentację na wykładzie

Ocena końcowa dotyczy trzech aspektów:

* do 3 punktów uzyskuje się, jeżeli wizualizacje mają wszystkie niezbędne elementy (tytuły, adnotacje na osiach, legendy, poprawne jednostki, opis jak czytać wykres)
* do 3 punktów uzyskuje się za estetykę, czytelność i jakość plakatu (spójność osi, kodowanie zmiennych, czytelność wykresów i poszczególnych elementów: tła, lini etc.)
* do 3 punktów uzyskuje się za wybór interesujących cech tworzących spójną historię, a co za tym idzie, ciekawą prezentację

**Warunkiem koniecznym uzyskania punktów za plakat jest dostarczenie działających kodów odtwarzających wykresy.**

## Deadline

Proszę o umieszczanie plików projektu w folderze o nazwie `nazwisko1_nazwisko2_nazwisko3` w folderze [`./projects/project2`](https://github.com/mini-pw/2021Z-DataVisualizationTechniques/tree/master/projects/project2).

- do **29/12** (niedziela) powinien pojawić się **PR** z raportem - raport i kody w folderze `raport`
- do **12/12** (sobota) powinien pojawić się **PR** z plakatem - plakat i kody w folderze `plakat`
- [opcjonalnie] do **13/12** (niedziela) powinien pojawić się **PR** z nagraniem `nazwisko1_nazwisko2_nazwisko3.**` w formacie, który łatwo otworzyć (można wysłać mailem)

Tytuł **PR**: odpowiednio `[projekt2] nazwisko1 raport/plakat/nagranie` (**Pull Request** robi jedna osoba z zespołu)

<details>
<summary><strong><em>Spoiler alert: przykładowe tematy do zbadania</em></strong></summary>

- sytuacja w szpitalach Polska vs Europa/Świat
- one-pager ze wszystkimi statystyczymi wykresami o sytuacji w Polsce
- śmiertelność/zgodny w Polsce vs Europa/Świat
- zmiany w sprzedaży w komunikacji w 2020 vs poprzednie lata
- zmiany na giełdach w 2020 vs poprzednie lata
- zmiany w świadcezniach społecznych w 2020 vs poprzednie lata
- rozwój epidemii w powiatach/województwach
- jaka jest szansa że spotkam osobę zakażoną w zależności od powiatu/województwa

</details>
