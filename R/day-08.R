# Name: Tyler Chia
# Date: 8/13/2020
# Purpose:

library(tidyverse)
library(zoo)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

chart3 <- covid %>%
  filter(state == 'California') %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  mutate(newCases = cases - lag(cases)) %>%
  mutate(roll7 = rollmean(newCases, 7, fill = NA, align="right")) %>%
  ggplot(aes(x = date)) +
  geom_col(aes(y = newCases), col = NA, fill = "pink") +
  geom_line(aes(y = roll7), col = "darkred", size = 1) +
  theme_bw() +
  labs(x = "Date",
       y = "Number of Cases",
       title = "Daily, New COVID Cases in California",
       subtitle = "COVID-19 Data: NY-Times",
       caption = "Daily Exercise 08")
ggsave(chart3, file = "~/github/geog176A-daily-exercises/img/new_daily_covidcases_cali.png")
