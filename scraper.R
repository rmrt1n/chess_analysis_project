# load libraries
library(rvest)
library(dplyr)
library(tidyr)
library(stringr)


scrape <- function(url) {
  df <- html_session(url) %>%
    html_node("table") %>%
    html_table() %>%
    select(-5) %>%
    filter(str_count(Players, "\\(.*?\\)") == 2) %>%
    mutate(Players = str_replace_all(Players, "\n", "")) %>%
    mutate(Opening = str_extract(Players, "(?=1\\.).*")) %>%
    separate(Players,
             into = c("Player 1", "Player 2"),
             sep = "(?<=\\)).*?(?=[A-Z])")

  if (file.exists("data/scraped_data.csv") == FALSE) {
    write.table(df, "data/scraped_data.csv",
      sep = ",",
      row.names = FALSE,
      col.names = TRUE
    )
  } else {
    write.table(df, "data/scraped_data.csv",
      sep = ",",
      row.names = FALSE,
      col.names = FALSE,
      append = TRUE
    )
  }
}


url <- "https://www.chess.com/games/search?p1=Hikaru%20Nakamura&page=1"

repeat {
  is_link <- html_session(url) %>%
    html_node(
      "a.form-button-component.pagination-button-component.pagination-next"
    ) %>%
    is.na()

  if (is_link == FALSE) {
    scrape(url)
    new_ses <- html_session(url) %>%
      follow_link(
        css = paste(
                ".form-button-component.",
                "pagination-button-component.pagination-next",
                sep = ""
              )
      )
    url <- new_ses$url
    Sys.sleep(2)
  } else {
    scrape(url)
    break
  }
}
