# Co zrobić żeby to działało

1. Sklonować sobie to repozytorium, żeby mieć lokalnie
2. Paczkę danych z facebooka wypakować do tego samego folderu (to znaczy te skrypty pythonowe powinny być na tym samym poziomie co folder messages)
3. Zainstalować sobie biblioteki pythonowe: na razie korzystam z `dash`, `pandas`, `wordcloud`, `dash_bootstrap_components`. Tu zależy jak macie zainstalowanego, jak normalnie to wystarczy w konsoli `pip install <<nazwa paczki>>`, a jak przez anacondę, to jakoś inaczej.
4. Uruchomić `generate.py`, a pózniej `plots.py`. Stworzy się lokalny serwer z tymi wykresami.
5. W przeglądarce wejść na stronę `http://127.0.0.1:8050/`, przynajmniej u mnie, i powinno działać
6. Można dodatkowo usunąć foldery inne niż wiadomości tekstowe korzystając z "clear_messages_dir" (trzeba odkomentować ostatnią linijke, zalecam najpierw sprawdzić czy poprawnie wypisuje ścieżki)