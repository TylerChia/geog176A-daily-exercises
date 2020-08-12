# Name: Tyler Chia
# Date: 8/12/2020
# Purpose: Purpose is to become comfortable with joining data frames on a common variable and switching between long and wide

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

View(covid)

region = data.frame(state_abbr = state.abb, region = state.region, state = state.name)

covid_region = inner_join(covid, region, by = 'state')
View(covid_region)

covid_region_graph <- covid_region %>%
  group_by(date, region) %>%
  summarize(cases = sum(cases), deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths'),
               names_to = 'type',
               values_to = 'number') %>%
  ggplot(aes(x = date, y = number)) +
  geom_line(aes(color = region)) +
  facet_grid(type~region, scales = 'free_y') +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = "Date",
       y = "Daily Cummulative Count",
       title = "Cummulative Cases and Deaths: Region",
       subtitle = "COVID-19 Data: NY-Times",
       caption = "Daily Exercise 07")

ggsave(covid_region_graph, file = "~/github/geog176A-daily-exercises/img/cummulative_cases_region.png")



