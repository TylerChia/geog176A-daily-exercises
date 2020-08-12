# Name: Tyler Chia
# Date: 08/11/2020
# Purpose:

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

head(covid, 5)

covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state)

filtered_data <- covid %>%
  filter(state %in% c('California','Florida','Texas','New York','Georgia','Illinois'))

install.packages("ggthemes")
library(ggthemes)

gg1 = ggplot(data = filtered_data, aes(x = date, y = cases)) +
  geom_line(aes(color = state)) +
  labs(title = "Cummulative Case Counts: COVID-19 Pandemic",
       x = 'Date',
       y = "Number of Cases",
       caption = "Based on NY Times Covid-19 Data",
       subtitle = "Daily Exercise 6",
       color = "") +
  facet_wrap(~state) +
  theme_minimal()

ggsave(gg1, file = "~/github/geog176A-daily-exercises/img/states_most_cases.png")

total_cases = covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases))

gg2 = ggplot(total_cases, aes(x = date, y = cases)) +
  geom_col(color = 'maroon') +
  labs(title = "National Cummulative Case Counts: COVID-19 Pandemic",
       x = "Date",
       y = "Cases",
       caption = "Based on NY Times Covid-19 Data",
       subtitle = "Daily Exercise 6") +
  theme_minimal()

ggsave(gg2, file = "~/github/geog176A-daily-exercises/img/total_cases.png")
