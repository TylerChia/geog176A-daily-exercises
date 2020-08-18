library(tidyverse)
library(USAboundaries)
library(USAboundariesData)
library(sf)
states <- us_states()
newstates <- states %>%
  filter(name != "Alaska" & name != "Puerto Rico" & name != "Hawaii")

newstates_ls <- newstates %>%
  st_combine() %>%
  st_cast("MULTILINESTRING")
plot(newstates_ls)

newstates_ls2 <- newstates %>%
  st_union() %>%
  st_cast("MULTILINESTRING")
plot(newstates_ls2)

