# This filters Airbnb listings to identify full-time rental properties based on a minimum stay criteria of 30 days and at least 5 reviews in the past year.
# It calculates the percentage of such full-time rental properties in the dataset.

library(dplyr)

listings <- read.csv('SFlistings.csv', stringsAsFactors = FALSE)

# Filters for listings with 5 or more reviews in the last 12 months
reviews_threshold <- 5
listings_with_reviews <- filter(listings, number_of_reviews_ltm >= reviews_threshold)

# Filters for listings with a minimum stay of 30 days or more
minimum_stay_threshold <- 30
listings_with_long_stay <- filter(listings_with_reviews, minimum_nights >= minimum_stay_threshold)

# Calculates the percentage of such listings
full_time_rental_properties_count <- nrow(listings_with_long_stay)
total_listings <- nrow(listings)
percentage_full_time_rentals <- (full_time_rental_properties_count / total_listings) * 100

cat(percentage_full_time_rentals, "%\n")
# 3.181451 %
cat(full_time_rental_properties_count, "\n")
# 236
cat(total_listings, "\n")
# 7418