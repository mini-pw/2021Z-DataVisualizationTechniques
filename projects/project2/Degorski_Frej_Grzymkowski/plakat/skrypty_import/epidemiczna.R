read.csv("dane/raw/epidemiczna_czysta.csv", encoding = "UTF-8", stringsAsFactors = FALSE, 
         colClasses = rep("character", 11), na.strings = "") %>%
  as.tbl()  %>%
  mutate_at("data", ~as.Date(., "%d.%m")) %>%
  mutate_at(c("procent_hospitalizowanych_z_aktywnych", "procent_zajetych_lozek",
              "procent_hospitalizowanych_pod_respiratorem", "procent_zajetych_respiratorow"
              ),
            polski_procent_do_R) %>%
 write.csv("dane/epidemiczna.csv", row.names = FALSE)
