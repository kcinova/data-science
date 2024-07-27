# This filters Airbnb listings to identify full-time rental properties based on high availability (more than 300 days) and hosts with multiple listings.
# It calculates the percentage of such full-time rental properties in the dataset.

library(dplyr)

listings <- read.csv('SFlistings.csv', stringsAsFactors = FALSE)

# Filters for entire home/apt listings
entire_home_listings <- filter(listings, room_type == 'Entire home/apt')

# Defines high availability threshold (more than 300 days a year)
high_availability_threshold <- 300
high_availability_listings <- filter(entire_home_listings, availability_365 > high_availability_threshold)

# Filters for hosts with multiple listings (more than 1)
multiple_listings_threshold <- 1
hosts_with_multiple_listings <- filter(listings, calculated_host_listings_count > multiple_listings_threshold)

# Combines the criteria
full_time_rental_properties <- filter(high_availability_listings, host_id %in% hosts_with_multiple_listings$host_id)

# Calculates the percentage of full-time rental properties
total_listings <- nrow(listings)
full_time_rental_properties_count <- nrow(full_time_rental_properties)
percentage_full_time_rentals <- (full_time_rental_properties_count / total_listings) * 100

cat(percentage_full_time_rentals, "%\n")
# 9.423025 %
cat(full_time_rental_properties_count, "\n")
# 699
cat(total_listings, "\n")
# 7418