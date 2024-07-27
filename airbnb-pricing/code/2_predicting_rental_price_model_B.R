# This extends the price prediction model by including amenities as a variable.
# It builds a linear regression model to predict rental prices based on bedrooms, bathrooms, location, and amenities.

# Loads required libraries
library(dplyr)
library(stringr)

# Reads Airbnb listings data
bnb <- read.csv("SFlistings.csv", stringsAsFactors = FALSE)

# Cleans and prepares amenities data
bnb$amenities <- tolower(gsub("[^[:alnum:], ]", "", bnb$amenities))
amenities_list <- strsplit(as.character(bnb$amenities), ", ")
all_amenities <- unlist(amenities_list)
rm(amenities_list)

# Counts occurrences of each amenity
amenities_counts <- table(all_amenities)

# Creates a data frame for visualization
amenities_data <- data.frame(Amenity = names(amenities_counts), Count = as.numeric(amenities_counts))
amenities_data <- amenities_data[order(amenities_data$Count, decreasing = TRUE), ]

# Creates dummy variables for top 20 amenities and additional specific amenities
amenities <- head(amenities_data, 20)$Amenity
amenities <- c(amenities, 'washer', 'tv')

# Adds dummy variables to the data frame
for (i in amenities) {
  bnb[, i] <- ifelse(grepl(i, bnb$amenities), 1, 0)
}

# Cleans and transforms price data
bnb$price <- as.numeric(str_remove_all(bnb$price, "[\\$,]"))

# Converts Inner Richmond and Outer Richmond to categorical variables
bnb$inner_richmond <- ifelse(bnb$host_neighbourhood == 'Inner Richmond', 1, 0)
bnb$outer_richmond <- ifelse(bnb$host_neighbourhood == 'Outer Richmond', 1, 0)

# Extracts numeric value from bathrooms text
bnb$bathrooms <- as.numeric(str_extract(bnb$bathrooms_text, "\\d+"))

if (!'hot water' %in% names(bnb)) {
  bnb$hot_water <- 0
  print("Column 'hot water' does not exist in the dataframe. Default column added.")
} else {
  names(bnb)[names(bnb) == 'hot water'] <- 'hot_water'
}

# Add a default column for 'cooking_basics' if it doesn't exist
if (!'cooking basics' %in% names(bnb)) {
  bnb$cooking_basics <- 0
  print("Column 'cooking basics' does not exist in the dataframe. Default column added.")
} else {
  names(bnb)[names(bnb) == 'cooking basics'] <- 'cooking_basics'
}

# Builds model for predicting price based on beds, baths, location, and amenities (Inner Richmond)
model1 <- lm(price ~ bedrooms + bathrooms + inner_richmond + kitchen + heating + refrigerator + microwave + cooking_basics + washer + hot_water, data = bnb)
  
# Predicts price for property in Inner Richmond
new_bnb_inner <- data.frame(bedrooms = 2, bathrooms = 2, inner_richmond = 1, kitchen = 1, heating = 1, refrigerator = 1, microwave = 1, cooking_basics = 1, washer = 1, hot_water = 1)
inner_richmond_price <- predict(model1, newdata = new_bnb_inner)
  
cat("Predicted price for Inner Richmond property: $", inner_richmond_price, "\n")
# Result: 366.4059 

# Builds model for predicting price based on beds, baths, location, and amenities (Outer Richmond)
model2 <- lm(price ~ bedrooms + bathrooms + outer_richmond + kitchen + heating + refrigerator + microwave + cooking_basics + washer + hot_water, data = bnb)
  
# Predicts price for property in Outer Richmond
new_bnb_outer <- data.frame(bedrooms = 2, bathrooms = 2, outer_richmond = 1, kitchen = 1, heating = 1, refrigerator = 1, microwave = 1, cooking_basics = 1, washer = 1, hot_water = 1)
outer_richmond_price <- predict(model2, newdata = new_bnb_outer)
  
# Prints the prediction result for Outer Richmond
cat("Predicted price for Outer Richmond property: $", outer_richmond_price, "\n")
# Result: 378.3034