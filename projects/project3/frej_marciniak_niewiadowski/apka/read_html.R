library(rvest)
library(stringr)
library(dplyr)
library(stringr)

read_file <- function(name_str, date_str) {
  day_html = read_html(paste('data/', name_str, '/', date_str, sep = ""))
  day_html %>%
    html_nodes('tr') %>%
    html_nodes('td') %>%
    html_text() -> day_table
  
  day_data <- data.frame(name = character(), date = character(), time = character(), 
                         title = character(), parent = character(), semiidle = character(),
                         keys = character(), lmb = character(), rmb = character(),
                         scrollwheel = character())
  
  i <- 1
  while (i+1 <= length(day_table)) {
    loc <- str_locate_all(day_table[i+1], "scrollwheel")[[1]]
    if (nrow(loc) == 0) {
      loc <- str_locate_all(day_table[i+1], "rmb")[[1]]
    }
    if (nrow(loc) == 0) {
      loc <- str_locate_all(day_table[i+1], "lmb")[[1]]
    }
    if (nrow(loc)>=1) {
      title_str <- substr(day_table[i+1], 1, loc[1, 2])
      find_title <- str_locate(title_str, " - [0-9]{1,2}%")
      find_parent <- str_locate(title_str, "% of parent")
      find_semiidle <- str_locate(title_str, "[0-9]{1,2}% semiidle")
      find_keys <- str_locate(title_str, "[0-9]{1,10} keys")
      find_lmb <- str_locate(title_str, "[0-9]{1,10} lmb")
      find_rmb <- str_locate(title_str, "[0-9]{1,10} rmb")
      find_scrollwheel <- str_locate(title_str, "[0-9]{1,10} scrollwheel")
      day_data <- add_row(day_data, name = name_str, date = substring(inner_file, 1, str_length(inner_file)-5), 
                          time = day_table[i], 
                          title = substr(title_str, 1, find_title[1, 1]-1),
                          parent = substr(title_str, find_title[1, 1]+3, find_parent[1, 1]),
                          semiidle = substr(title_str, find_semiidle[1, 1], find_semiidle[1, 2]-9),
                          keys = substr(title_str, find_keys[1, 1], find_keys[1, 2]-5),
                          lmb = substr(title_str, find_lmb[1, 1], find_lmb[1, 2]-4),
                          rmb = substr(title_str, find_rmb[1, 1], find_rmb[1, 2]-4),
                          scrollwheel = substr(title_str, find_scrollwheel[1, 1], find_scrollwheel[1, 2]-12))
    }
    loc_skip <- str_locate_all(day_table[i+1], "parent")[[1]]
    i = i + ifelse(nrow(loc_skip)*2 > 0, nrow(loc_skip)*2, 2)
  }
  
  return(day_data)
}