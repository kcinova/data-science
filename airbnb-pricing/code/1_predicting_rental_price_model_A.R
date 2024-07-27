# Method 1 - Find the price based on beds, baths and location

library(dplyr)
library(ggplot2)

airbnb <- read.csv("SFlistings.csv", stringsAsFactors = FALSE)

# Cleans and transforms price data from character to numeric
airbnb$price <- as.numeric(str_remove_all(airbnb$price, "[\\$,]"))

# Converts Inner Richmond to categorical variable
airbnb$inner_richmond <- ifelse(airbnb$host_neighbourhood == 'Inner Richmond', 1, 0)

# Extracts numeric value from bathrooms text
airbnb$bathrooms <- as.numeric(str_extract(airbnb$bathrooms_text, "\\d+"))

# Builds model for predicting price based on beds, baths, and location (Inner Richmond)
model1 <- lm(price ~ bedrooms + bathrooms + inner_richmond, data = airbnb)

# Predicts price for a property in Inner Richmond
new_bnb_inner <- data.frame(bedrooms = 2, bathrooms = 2, inner_richmond = 1)
InnerRichmondPrice <- predict(model1, newdata = new_bnb_inner)

# Prints the prediction result for Inner Richmond
cat("Predicted price for Inner Richmond property: $", InnerRichmondPrice, "\n")
# Result: 440.467

# Filters Inner Richmond properties
inner_richmond_properties <- subset(airbnb, host_neighbourhood == "Inner Richmond")

# Creates a scatter plot for properties in Inner Richmond
ggplot(inner_richmond_properties, aes(x = bedrooms, y = price)) +
  geom_point(color = "blue") +
  geom_point(aes(x = 2, y = InnerRichmondPrice), color = "red", size = 3) +
  ggtitle("Price of Properties in Inner Richmond") +
  xlab("Bedrooms") +
  ylab("Price") +
  theme_minimal()

# Converts Outer Richmond to categorical variable
airbnb$outer_richmond <- ifelse(airbnb$host_neighbourhood == 'Outer Richmond', 1, 0)

# Builds model for predicting price based on beds, baths, and location (Outer Richmond)
model2 <- lm(price ~ bedrooms + bathrooms + outer_richmond, data = airbnb)

# Predicts price for a property in Outer Richmond
new_bnb_outer <- data.frame(bedrooms = 2, bathrooms = 2, outer_richmond = 1)
OuterRichmondPrice <- predict(model2, newdata = new_bnb_outer)

# Prints the prediction result for Outer Richmond
cat("Predicted price for Outer Richmond property: $", OuterRichmondPrice, "\n")
# Result: 409.2746

# Calculates and prints the average estimated price for Inner and Outer Richmond
EstimatedPrice <- (OuterRichmondPrice + InnerRichmondPrice) / 2
cat("Estimated average price for Inner and Outer Richmond: $", EstimatedPrice, "\n")
# Result: 424.8708