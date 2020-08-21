library(tidyverse)
library(USAboundaries)
library(USAboundariesData)
library(sf)
states <- us_states() %>%
  filter(name != "Alaska" & name != "Puerto Rico" & name != "Hawaii")
alabama <- states %>%
  filter(name == "Alabama")
touchAlabama = st_filter(states, alabama, .predicate = st_touches)

map <- ggplot() +
  geom_sf(data = states) +
  geom_sf(data = touchAlabama, fill = "red", alpha = 0.5) +
  labs(title = "States That Border Alabama",
       x = "Longitude",
       y = "Latitude") +
  ggthemes::theme_map() +
  theme(legend.position = 'none')

ggsave(map, file = "~/github/geog176A-daily-exercises/img/border_alabama.png")
