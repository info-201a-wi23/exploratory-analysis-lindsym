install.packages("tidyverse")

library("readxl")

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


# df has all data clean with columns of population, life expentancy, and healthy life expetancy
df <- data.frame(member_states, male_population, female_population, total_population, population_year, male_life_expectancy, female_life_expectancy, both_sexes_life_expectancy, life_expectancy_year, male_healthy_life_expectancy, female_healthy_life_expectancy, both_healthy_sexes_life_expectancy, healthy_life_expectancy_year)




