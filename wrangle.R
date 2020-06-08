# load libraries
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# import & view data
df <- read_csv("scraped_data.csv")
head(df)

# Tidy data
df <- df %>%
  rename(White = "Player 1", Black = "Player 2") %>%
  separate(White, into = c("White", "White_rating"), sep = "  .*?(?=\\()") %>%
  separate(Black, into = c("Black", "Black_rating"), sep = "  .*?(?=\\()") %>%
  mutate(
    Color = if_else(str_detect(White, "Hikaru") == TRUE, "White", "Black")
  ) %>%
  mutate(
    Rating = if_else(Color == "White", White_rating, Black_rating)
  ) %>%
  mutate(
    Opponent = if_else(str_detect(White, "Hikaru") == TRUE, Black, White)
  ) %>%
  mutate(
    Opponent_rating = if_else(Color == "White", Black_rating, White_rating)
  ) %>%
  mutate(
    Result = if_else(Color == "White" & Result == "1-0", "Win",
               if_else(Color == "White" & Result == "0-1", "Loss",
                 if_else(Color == "Black" & Result == "1-0", "Loss",
                   if_else(Color == "Black" & Result == "0-1", "Win", "Draw")
                 )
               )
             )
  ) %>%
  mutate(Opening = str_replace_all(Opening, "(?<=[0-9+]\\.) ", "")) %>%
  mutate(Opening = str_replace_all(Opening, "(?<=[0-9+]) ", "")) %>%
  mutate(Opening = if_else(
                     str_detect(Opening, ":") == TRUE,
                     str_extract(Opening, "(?<=[0-9+] ).*?(?=\\:)"),
                     if_else(
                       str_detect(Opening, "with") == TRUE,
                       str_extract(Opening, "(?<=[0-9+] ).*?(?=with)"),
                       str_extract(Opening, "(?<=[0-9+] ).*?$")
                     )
                   )
  ) %>%
  mutate(Opening = if_else(
                     str_detect(Opening, "with") == TRUE,
                     str_extract(Opening, ".*(?=with)"),
                     Opening
                   )
  ) %>%
  select(
    Color, Rating, Opponent, Opponent_rating,
    Result, Opening, Moves, Year
  ) %>%
  mutate(Rating = str_extract(Rating, "(?<=\\().*?(?=\\))")) %>%
  mutate(
    Opponent_rating = str_extract(Opponent_rating, "(?<=\\().*?(?=\\))")
  ) %>%
  mutate_at(c("Color", "Result", "Opening"), as.factor) %>%
  mutate_at(c("Rating", "Opponent_rating"), as.numeric)

head(df, 10)

# write to csv
write_csv(df, "cleaned_data.csv")

