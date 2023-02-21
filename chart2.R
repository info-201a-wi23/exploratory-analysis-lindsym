install.packages("tidyverse")

library("ggplot2")
library("readxl")
library("dplyr")


#getting data for population in each country in 2020
world_health_df <- read_excel("xploratory-analysis-lindsym
world_health_stats.xlsx", sheet = "Annex 2-1", range = "A5:V199")

member_states <- world_health_df$`Member State...1`
male_population <- as.numeric(world_health_df$`2020...2`)
female_population <- as.numeric(world_health_df$`...3`)
total_population <- as.numeric(world_health_df$`...4`)
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


df <- df %>%
  mutate(male_per = male_population / total_population) %>%
  mutate(female_per = female_population / total_population) 

ggplot(df) +
  geom_point(mapping = aes(x = male_per, y = female_per)) +
  labs(
    title = "2020 Country's Male to Female Population Ratio Percentage",
    x = "Percentage of Females in Country",
    y = "Percentage of Males in Country"
  )