# Name: Tyler Chia
# Date: 8/13/2020
# Purpose:

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

covid %>%
