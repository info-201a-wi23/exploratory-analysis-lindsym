install.packages("tidyverse")

library("ggplot2")
library("readxl")
library("dplyr")

#getting data for population in each country in 2020
world_health_df <- read_excel("world_health_stats.xlsx", sheet = "Annex 2-1", range = "A5:V199")
member_states <- world_health_df$`Member State...1`
male_population <- world_health_df$`2020...2`
female_population <- world_health_df$`...3`
total_population <- world_health_df$`...4`
population_year <- rep(2020, length(member_states))

#getting data for life expetancy in each country in 2019
male_life_expectancy <- world_health_df$`2019...5`
female_life_expectancy <- world_health_df$`...6`
both_sexes_life_expectancy <- world_health_df$`...7`
life_expectancy_year <- rep(2019, length(member_states))


#getting data for healthy life expectancy in each in country in 2019
male_healthy_life_expectancy <- world_health_df$`2019...8`
female_healthy_life_expectancy <- world_health_df$`...9`
both_healthy_sexes_life_expectancy <- world_health_df$`...10`
healthy_life_expectancy_year <- rep(2019, length(member_states))

#getting data for under-five mortality rates in 2020
mortality_rate <- world_health_df$'2020...14'

# df has all data clean with columns of population, life expentancy, and healthy life expetancy
df <- data.frame(member_states, male_population, female_population, total_population, population_year, male_life_expectancy, female_life_expectancy, both_sexes_life_expectancy, life_expectancy_year, male_healthy_life_expectancy, female_healthy_life_expectancy, both_healthy_sexes_life_expectancy, healthy_life_expectancy_year, mortality_rate)


world <- map_data("world")


df <- df %>% mutate (member_states = replace(member_states, member_states == "United States of America", "USA"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Bolivia (Plurinational State of)", "Bolivia"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Venezuela (Bolivarian Republic of)", "Venezuela"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Russian Federation", "Russia"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Democratic People's Republic of Korea", "North Korea"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "United Republic of Tanzania", "Tanzania"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Czechia", "Czech Republic"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Côte d'Ivoire", "Ivory Coast"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Republic of Korea", "South Korea"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Eswatini", "Swaziland"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Iran (Islamic Republic of)", "Iran"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Syrian Arab Republic", "Syria"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Viet Nam", "Vietnam"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Trinidad and Tobago", "Trinidad"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Viet Nam", "Vietnam"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Micronesia (Federated States of)", "Micronesia"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Lao People's Democratic Republic", "Laos"))
df <- df %>% mutate (member_states = replace(member_states, member_states == "Congo", "Republic of Congo"))





df <- df %>% mutate(region = member_states)

df_world_shape <- left_join(df, world, by = "region")


ggplot(df_world_shape) +
  geom_polygon(mapping = aes(x = long, 
                             y = lat, 
                             group = group, 
                             fill = mortality_rate)) +
  labs(title = '2020 Under-Five Mortality Rate By Country', fill = 'Rate Per 1000 Live Births') +
  xlab("Longitude") +
  ylab("Latitude")

  




