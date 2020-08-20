library(tidyverse)
library(sf)

cities = readr::read_csv("uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326)

my_cities <- cities %>%
  filter(city %in% c("Santa Barbara", "San Francisco"))

equal <- st_transform(my_cities, 5070)
equidistant <- st_transform(my_cities, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs')

st_distance(my_cities)
st_distance(equal) %>%
  units::set_units("km") %>%
  units::drop_units()
st_distance(equidistant)
