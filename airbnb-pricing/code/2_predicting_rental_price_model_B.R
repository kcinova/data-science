bnb <- read.csv("SFlistings.csv")

# Amenities
# Makes a list of all amenities in the data
bnb$amenities <- tolower(gsub("[^[:alnum:], ]", "", bnb$amenities))
amenities_list <- strsplit(as.character(bnb$amenities), ", ")
all_amenities <- unlist(amenities_list)
rm(amenities_list)

# Counts the occurrences of each value
amenities_counts <- table(all_amenities)
# Creates a data frame for visualization
amenities_data <- data.frame(Amenity = names(amenities_counts), Count = as.numeric(amenities_counts))
amenities_data <- amenities_data[order(amenities_data$Count, decreasing = TRUE), ]

## Creates a dummy code for each amenity in each listing
# Creates a list of amenities to loop through
amenities <- head(amenities_data, 20)$Amenity # If you want the top 20 popular ones
amenities <- c(amenities, 'washer', 'tv') # ADD MORE IF YOU WANT TO WITH "blah",...

# Loops through each amenity. Make a new column, and check for its presence
for (i in amenities) {
  bnb[,i] <- ifelse(stringr::str_detect(bnb$amenities, i) == TRUE , 1, 0)
}

# Changes price from character to number
bnb$price <- stringr::str_remove(bnb$price, "\\$")
bnb$price <- as.numeric(stringr::str_remove(bnb$price, ","))

# Changes Host Neighborhood (Inner Richmond) to categorical variable
bnb$inner_richmond <- ifelse(bnb$host_neighbourhood == 'Inner Richmond', 1, 0)

bnb$bathrooms <- as.numeric(stringr::str_extract(bnb$bathrooms_text,"\\d*"))

if('cooking basics' %in% names(bnb)) {
  names(bnb)[names(bnb) == 'cooking basics'] <- 'cooking_basics'
} else {
  print("Column 'cooking basics' does not exist in the dataframe.")
}

if('hot water' %in% names(bnb)) {
  names(bnb)[names(bnb) == 'hot water'] <- 'hot_water'
} else {
  print("Column 'hot water' does not exist in the dataframe.")
}

#Model for predicting price based on beds, baths, location, amenities
model1 <- lm( data = bnb,
              price ~ bedrooms + bathrooms + inner_richmond + kitchen + heating + refrigerator + microwave + cooking_basics + washer + hot_water)

new_bnb <- data.frame(bedrooms = 2, bathrooms = 2, inner_richmond = 1, kitchen = 1, heating = 1, refrigerator = 1, microwave = 1, cooking_basics = 1, washer = 1, hot_water = 1)

predict(
  model1,
  newdata = new_bnb)

#ANSWER - 327.8253 

----------------------------------
  
bnb <- read.csv("SFlistings.csv")

# Amenities
# Makes a list of all amenities in the data
bnb$amenities <- tolower(gsub("[^[:alnum:], ]", "", bnb$amenities))
amenities_list <- strsplit(as.character(bnb$amenities), ", ")
all_amenities <- unlist(amenities_list)
rm(amenities_list)

# Counts the occurrences of each value
amenities_counts <- table(all_amenities)
# Creates a data frame for visualization
amenities_data <- data.frame(Amenity = names(amenities_counts), Count = as.numeric(amenities_counts))
# Sorts the data by count in descending order
amenities_data <- amenities_data[order(amenities_data$Count, decreasing = TRUE), ]

## Creates a dummy code for each amenity in each listing
# Creates a list of amenities to loop through
amenities <- head(amenities_data, 20)$Amenity # If you want the top 20 popular ones
amenities <- c(amenities, 'washer', 'tv') # ADD MORE IF YOU WANT TO WITH "blah",...

# Loops through each amenity. Makes a new column, and check for its presence
for (i in amenities) {
  bnb[,i] <- ifelse(stringr::str_detect(bnb$amenities, i) == TRUE , 1, 0)
}

#Changes price from character to number
bnb$price <- stringr::str_remove(bnb$price, "\\$")
bnb$price <- as.numeric(stringr::str_remove(bnb$price, ","))

#Changes Host Neighborhood (Inner Richmond) to categorical variable
bnb$outer_richmond <- ifelse(bnb$host_neighbourhood == 'Outer Richmond', 1, 0)

#Extracts number from bathrooms text
bnb$bathrooms <- as.numeric(stringr::str_extract(bnb$bathrooms_text,"\\d*"))

if('cooking basics' %in% names(bnb)) {
  names(bnb)[names(bnb) == 'cooking basics'] <- 'cooking_basics'
} else {
  print("Column 'cooking basics' does not exist in the dataframe.")
}

if('hot water' %in% names(bnb)) {
  names(bnb)[names(bnb) == 'hot water'] <- 'hot_water'
} else {
  print("Column 'hot water' does not exist in the dataframe.")
}

#Model for predicting price based on beds, baths, location, amenities
model1 <- lm( data = bnb,
              price ~ bedrooms + bathrooms + outer_richmond + kitchen + heating + refrigerator + microwave + cooking_basics + washer + hot_water)

new_bnb <- data.frame(bedrooms = 2, bathrooms = 2, outer_richmond = 1, kitchen = 1, heating = 1, refrigerator = 1, microwave = 1, cooking_basics = 1, washer = 1, hot_water = 1)

predict(
  model1,
  newdata = new_bnb)

#ANSWER - 299.2366