# Exploratory Data Analysis on the Games of Hikaru Nakamura

This repo contains my analysis of Hikaru Nakamura's games with R. The data used is scraped 
from [Chess.com](https://chess.com) using [rvest](https://github.com/tidyverse/rvest). The code for
the scraper can be seen [here](https://github.com/rmrt1n/chess_analysis_project/blob/master/scraper.R).

## Resources Used
**R Packages:**  
- core tidyverse packages(dplyr, ggplot2, readr, tidyr, stringr)  
- gridExtra 
- rvest  

**Data Source**: https://www.chess.com/games/hikaru-nakamura  

## Dataset Descriptions  
  
**scraped_data.csv**  
columns:  
- Player 1 (Name and rating of white player)  
- Player 2 (Name and rating of black player)  
- Result (Game results):
    * `1-0` if white wins  
    * `0-1` if black wins  
    * `1/2-1/2` if game is drawn  
- Moves (Number of moves in the game)  
- Year (The year the game is played)  
- Opening (The full name of openings with move notation)  

**cleaned_data.csv**  
columns:  
- Color (The color of Hikaru's piece)  
- Rating (His rating)    
- Oppponent (The name of his opponent)  
- Opponent_rating (His opponent's rating)  
- Result (Game results):    
    * `Win` if Hikaru won  
    * `Loss` if Hikaru lost  
    * `Draw` if game is drawn  
- Opening (Generalized name of the opening, without variations and notation)  
- Moves  
- Year  
  
## Findings  

Here are some of my findings after performing the analysis. The rest of the analyses and visualizations are in [eda.Rmd](https://github.com/rmrt1n/chess_analysis_project/blob/master/eda.Rmd).  

![alt text](https://github.com/rmrt1n/chess_analysis_project/blob/master/vs_high.png "Results against higher-rate opponents")
![alt text](https://github.com/rmrt1n/chess_analysis_project/blob/master/top10_opp.png "Top 10 most-faced opponents")
![alt text](https://github.com/rmrt1n/chess_analysis_project/blob/master/opp_res.png "Results against them")


