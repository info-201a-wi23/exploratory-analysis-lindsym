library("tidyverse")
library("readxl")


countries_df <- read.csv("https://raw.githubusercontent.com/dbouquin/IS_608/master/NanosatDB_munging/Countries-Continents.csv", stringsAsFactors = F)


world_health_df <- read_excel("world_health_stats.xlsx", sheet = "Annex 2-1", range = "A5:V199")
member_states <- world_health_df$`Member State...1`
both_sexes_life_expectancy <- as.numeric(world_health_df$`...7`)
both_healthy_sexes_life_expectancy <- as.numeric(world_health_df$`...10`)


life_expectancy_df <- data.frame(member_states, both_sexes_life_expectancy, both_healthy_sexes_life_expectancy)

life_expectancy_df <- left_join(life_expectancy_df, countries_df, by=join_by(member_states == Country))

total_avg_life_expectancy <- life_expectancy_df %>% filter(both_sexes_life_expectancy != "-") %>% group_by(Continent) %>% summarise(avg_life_expetancy = mean(both_sexes_life_expectancy))

total_avg_healthy_life_expectancy <- life_expectancy_df %>% filter(both_sexes_life_expectancy != "-") %>% group_by(Continent) %>% summarise(avg_healthy_life_expetancy = mean(both_healthy_sexes_life_expectancy))


total_avg_life_expectancy <- left_join(total_avg_life_expectancy, total_avg_healthy_life_expectancy)

total_avg_life_expectancy <- gather(total_avg_life_expectancy, key = "type", value="avg", 2:3) %>% filter(!is.na(Continent))


ggplot(total_avg_life_expectancy, aes(x = Continent, y = avg, fill = type)) + geom_bar(stat = "identity", position = "dodge") + labs(y = "Years", fill = "Average type") + scale_fill_discrete(labels = c("Average Healthy Life Expetancy", "Average life expetancy"))


library("tidyr")
