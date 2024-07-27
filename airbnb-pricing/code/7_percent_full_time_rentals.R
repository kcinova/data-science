# This script combines two methods to estimate the percentage of full-time rental properties listed on Airbnb in San Francisco.
# It uses both high availability and minimum stay criteria to provide a comprehensive analysis.

library(dplyr)
library(readr)
library(ggplot2)

airbnb_data <-read_csv('Airbnb_Listings.csv')
  
filtered_data <- airbnb_data %>%
  filter(country %in% c("United States of America", "Canada"))

# Groups data by country, city, and neighborhood and calculate average price
neighborhood_prices <- filtered_data %>%
  group_by(country, city, neighborhood) %>%
  summarize(mean_price = mean(price, na.rm = TRUE))

# Finds the top 10 cheapest neighborhoods
cheapest_neighborhoods <- neighborhood_prices %>%
  arrange(mean_price) %>%
  head(10)

# Finds the top 10 most expensive neighborhoods
most_expensive_neighborhoods <- neighborhood_prices %>%
  arrange(desc(mean_price)) %>%
  head(10)

print(cheapest_neighborhoods)
# A tibble: 10 × 4
# Groups:   country, city [7]
# country                  city         neighborhood                        avg_price
# <chr>                    <chr>        <chr>                                   <dbl>
#   1 Canada                   Portland     Pleasant Valley/Powellhurst-Gilbert      40  
# 2 United States of America NYC          New Dorp                                 40  
# 3 United States of America LosAngeles   Desert View Highlands                    40.3
# 4 United States of America LosAngeles   Watts                                    44.1
# 5 Canada                   NewBrunswick Blissville                               45  
# 6 United States of America SanMateo     Colma                                    49.2
# 7 United States of America Oakland      Hegenberger                              51  
# 8 United States of America LosAngeles   Historic South-Central                   51.9
# 9 United States of America Chicago      West Englewood                           53.5
# 10 Canada                   Portland     Centennial/Pleasant Valley               54 

print(most_expensive_neighborhoods)
# A tibble: 10 × 4
# Groups:   country, city [7]
# country                  city        neighborhood                  avg_price
# <chr>                    <chr>       <chr>                             <dbl>
#   1 United States of America SanDiego    Eastlake Woods                     661 
# 2 United States of America NYC         Fort Wadsworth                     650 
# 3 United States of America RhodeIsland New Shoreham                       529.
# 4 United States of America Oakland     Hiller Highlands                   524 
# 5 United States of America LosAngeles  Aliso and Wood Regional Park       513 
# 6 United States of America LosAngeles  Hidden Hills                       506.
# 7 United States of America Austin      78712                              500 
# 8 Canada                   Portland    Healy Heights/Southwest Hills      499 
# 9 United States of America NYC         Hollis Hills                       497 
# 10 United States of America SanDiego    Horton Plaza                       485 


# Filters data for listings in the United States and Canada and calculate average price and ratings
filtered_data <- airbnb_data %>%
  filter(country %in% c("United States of America", "Canada")) %>%
  group_by(country, city, neighborhood) %>%
  summarize(mean_price = mean(price, na.rm = TRUE), 
            mean_ratings = mean(review_scores_rating, na.rm = TRUE))
filtered_data <- airbnb_data %>%
  filter(country %in% c("United States of America", "Canada"))%>%
  group_by(country, city, neighborhood) %>%
  summarize(mean.price = mean(price, na.rm = TRUE), 
            mean.ratings = mean(review_scores_rating, na.rm = TRUE))

ggplot(data=filtered_data,
       aes(x=mean.ratings, y=mean.price))+
  geom_smooth(method='lm')+
  geom_point()+
  geom_point(color = "black", size = 0.2,shape = 1)+
  theme_minimal()

summary(lm(data=filtered_data, mean.price~mean.ratings))

#Call:
# lm(formula = mean.price ~ mean.ratings, data = filtered_data)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -140.31  -43.79  -12.10   27.69  478.97 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)    -7.285     41.334  -0.176     0.86    
# mean.ratings   37.862      8.701   4.351 1.42e-05 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 66.54 on 1914 degrees of freedom
# (10 observations deleted due to missingness)
# Multiple R-squared:  0.009795,	Adjusted R-squared:  0.009278 
# statistic: 18.93 on 1 and 1914 DF,  p-value: 1.425e-05
