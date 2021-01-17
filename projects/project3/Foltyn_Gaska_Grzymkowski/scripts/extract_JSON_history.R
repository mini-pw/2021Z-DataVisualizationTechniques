# skrypt wyciąga dane z google takeout i zamienia je w format bardziej przyjazny R

extract_timestamp_date <- function(val) {
  as.POSIXct(val/1000000, origin = "1970-01-01")
}
extract_domain2 <- function(val, name = "domain") {
  urltools::domain(val) %>%
    urltools::suffix_extract() %>%
    mutate(domsuf = if_else(is.na(domain), "", paste(domain, suffix, sep ="."))) %>%
    select(domsuf) %>%
    pull()

}

# tidyjson jest powolny i długo to ładuje, ale RJSONIO nie chciał współpracować
tidyjson::read_json("raw_data/BrowserHistory.json") %>%
  tidyjson::gather_object() %>%
  tidyjson::gather_array() %>%
  tidyjson::spread_all() %>%
  as_tibble() %>%
  select(time_usec, url) ->
  raw_data

raw_data %>%
  mutate_at("time_usec", extract_timestamp_date) %>%
  mutate(across("url", extract_domain2)) %>%
  rename(domain = "url") -> ooo

domain_vec <- c("stackoverflow.com", "wikipedia.org", "github.com", "pw.edu.pl",
                "youtube.com", "google.com", "facebook.com", "instagram.com")

ooo %>%
  filter(domain %in% domain_vec) ->
  datetime_formatted

datetime_formatted %>% write.csv(file="user.csv")
