#Method 1 - Find the price based on beds, baths and location

# Load the necessary libraries
library(dplyr)

# Read the CSV files
file1 <- read.csv("sf_bnb_listing 1.csv")
file2 <- read.csv("sf_bnb_listing 2.csv")
file3 <- read.csv("sf_bnb_listing 3.csv")
file4 <- read.csv("sf_bnb_listing 4.csv")

# Combine the data frames
combined_data <- rbind(file1, file2, file3, file4)

# Write the combined data to a new CSV file
write.csv(combined_data, "combined_file.csv", row.names = FALSE)

#CODE: 
airbnb <- read.csv("sf_bnb_listing.csv")

#Change price from character to number
airbnb$price <- stringr::str_remove(airbnb$price, "\\$")
airbnb$price <- as.numeric(stringr::str_remove(airbnb$price, ","))

#Change Host Neighborhood (Inner Richmond) to categorical variable 
airbnb$inner_richmond <- ifelse(airbnb$host_neighbourhood == 'Inner Richmond', 1, 0)

#Extract number from bathrooms text
airbnb$bathrooms <- as.numeric(stringr::str_extract(airbnb$bathrooms_text,"\\d*"))

#Model for predicting price based on beds, baths and location
model1 <- lm( data = airbnb,
             price ~ bedrooms + bathrooms + inner_richmond)

#Prediction for property based on Inner Richmond 

new_bnb <- data.frame(bedrooms = 2, bathrooms = 2, inner_richmond = 1)
InnerRichmondPrice <- predict(
  model1,
  newdata = new_bnb)
#ANSWER: 375.6605

library(ggplot2)

# Assuming your data is in a data frame named 'airbnb'
# and your predicted price is stored in a variable 'InnerRichmondPrice'

# Filter Inner Richmond properties
inner_richmond_properties <- subset(airbnb, host_neighbourhood == "Inner Richmond")

# Create a scatter plot for properties in Inner Richmond
ggplot(inner_richmond_properties, aes(x = bedrooms, y = price)) +
  geom_point(color = "blue") +
  geom_point(aes(x = 2, y = InnerRichmondPrice), color = "red", size = 3) +
  ggtitle("Price of Properties in Inner Richmond") +
  xlab("Bedrooms") +
  ylab("Price") +
  theme_minimal()


#Change Host Neighborhood (Outer Richmond) to categorical variable 
airbnb$outer_richmond <- ifelse(airbnb$host_neighbourhood == 'Outer Richmond', 1, 0)

#Model for predicting price based on beds, baths and location
model2 <- lm( data = airbnb,
             price ~ bedrooms + bathrooms + outer_richmond)

#Prediction for property based on Outer Richmond 
new_bnb <- data.frame(bedrooms = 2, bathrooms = 2, outer_richmond = 1)

OuterRichmondPrice <- predict(
  model2,
  newdata = new_bnb)
#ANSWER: 315.4365

#AVERAGE of Inner and Outer Richmond
EstimatedPrice <- (OuterRichmondPrice + InnerRichmondPrice)/2
print(EstimatedPrice)
#ANSWER: 345.5485 



