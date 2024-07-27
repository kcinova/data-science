# Analyzes the influence of neighborhood crime rates on Airbnb prices.
# It integrates crime data with Airbnb listings and uses linear regression to explore the relationship between crime rates and rental prices.

library(dplyr)
library(stringr)
library(ggplot2)

bnb <- read.csv("SFlistings.csv")

#Changes price from character to number
bnb$price <- stringr::str_remove(bnb$price, "\\$")
bnb$price <- as.numeric(stringr::str_remove(bnb$price, ","))

# Calculates average prices by neighborhood
average_prices <- bnb %>%
  group_by(host_neighbourhood) %>%
  summarize(average_price = mean(price, na.rm = TRUE))

crimedata <- read.csv("revisedcrimedata.csv", stringsAsFactors = FALSE)

# Merges crime data with average prices
bnb_crime <- left_join(crimedata, average_prices, by = "host_neighbourhood")

# Builds linear regression model to analyze the relationship between crime rates and average Airbnb prices
model <- lm(average_price ~ CRIMES, data = bnb_crime)
summary(model)

# Calculates Pearson correlation between crime rates and average Airbnb prices
correlation <- cor(bnb_crime$average_price, bnb_crime$CRIMES, method = "pearson", use = "complete.obs")
print(correlation)

# Plots the relationship between crime rates and average Airbnb prices
ggplot(data = bnb_crime, aes(x = CRIMES, y = average_price)) +
  geom_point() +
  geom_smooth(method = "lm") +
  ggtitle("Relationship between Crime Rates and Average Airbnb Prices") +
  xlab("Number of Crimes") +
  ylab("Average Airbnb Price") +
  theme_minimal()