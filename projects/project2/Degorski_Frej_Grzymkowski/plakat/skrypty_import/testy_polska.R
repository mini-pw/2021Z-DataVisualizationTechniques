read.csv("dane/raw/testy_polska_czysta.csv", stringsAsFactors = FALSE, encoding = "UTF-8", na.strings = "", colClasses = rep("character", 16))  %>%
  as.tbl() %>%
  mutate_at("data", as.character) %>%
  mutate_at("data", ~as.Date(., "%d.%m")) %>%
  mutate_at(c("procent_pozytywnych_testow_ze_wszystkich", "procent_osob_z_pozytywnym_ze_wszystkich",
              "procent_osob_z_pozytywnym_ze_wszystkich_na_dobe", "procent_nowych_osob_z_pozytywnym_ze_wszystkich_na_dobe"),
            polski_procent_do_R
            ) %>%
  mutate_at("testy_na_tys", polski_do_R) %>%
  write.csv("dane/testy_polska.csv", row.names = FALSE)
