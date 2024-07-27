# This script identifies the top 10 cheapest and most expensive neighborhoods for Airbnb listings in the US and Canada.
# It calculates the mean price for each neighborhood and ranks them.

library(readr)
library(dplyr)

airbnb_data <- read_csv('Airbnb_Listings.csv')

# Filters data for listings in the United States and Canada
filtered_data <- airbnb_data %>%
  filter(country %in% c("United States of America", "Canada"))

# Groups data by country, city, and neighborhood and calculates average price
neighborhood_prices <- filtered_data %>%
  group_by(country, city, neighborhood) %>%
  summarize(avg_price = mean(price, na.rm = TRUE))

# Finds the top 10 cheapest neighborhoods
cheapest_neighborhoods <- neighborhood_prices %>%
  arrange(avg_price) %>%
  head(10)

# Finds the top 10 most expensive neighborhoods
most_expensive_neighborhoods <- neighborhood_prices %>%
  arrange(desc(avg_price)) %>%
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