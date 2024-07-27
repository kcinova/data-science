# Airbnb Pricing and Property Analysis

## Overview
This project aims to analyze Airbnb property listings to predict rental prices, determine the percentage of full-time rental properties, identify the cheapest and most expensive neighborhoods, and assess the influence of crime rates on Airbnb prices in San Francisco.

## Project Structure
- **data**: Contains raw data used for analysis.
- **code**: Contains R scripts for various analyses.
  - `1_predicting_rental_price_model_A.R`: Predicts rental prices based on bedrooms, bathrooms, and location (Inner Richmond).
  - `2_predicting_rental_price_model_B.R`: Extends the price prediction model by including amenities as a variable.
  - `3_influence_crime_rate.R`: Analyzes the influence of neighborhood crime rates on Airbnb prices.
  - `4_top10_bottom10_neighborhoods.R`: Identifies the top 10 cheapest and most expensive neighborhoods for Airbnb listings in the US and Canada.
  - `5_min_30days_stay_criteria.R`: Filters Airbnb listings to identify full-time rental properties based on a minimum stay criteria of 30 days and at least 5 reviews in the past year.
  - `6_min_300days_stay_criteria.R`: Filters Airbnb listings to identify full-time rental properties based on high availability (more than 300 days) and hosts with multiple listings.
  - `7_percent_full_time_rentals.R`: Combines two methods to estimate the percentage of full-time rental properties listed on Airbnb in San Francisco.
- **results/**: Contains the project report and presentation.
  - `airbnb-report.pdf`: Detailed report of the analysis.
  - `airbnb-presentation.pdf`: Presentation summarizing the project findings.

## Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/Airbnb_Pricing_and_Property_Analysis.git

2. Navigate to the project directory::
   ```bash
   cd Airbnb_Pricing_and_Property_Analysis

3. Install necessary R packages (if any):
   ```bash
    install.packages("dplyr")
    install.packages("ggplot2")
    install.packages("stringr")
    #Add any other packages used in the scripts

## Running the Code
To run the analysis, execute the R scripts in the `code` directory in the following order:

1. `1_predicting_rental_price_model_A.R`
2. `2_predicting_rental_price_model_B.R`
3. `3_influence_crime_rate.R`
4. `4_zillow_comparison.R`
5. `5_top10_bottom10_neighborhoods.R`
6. `6_min_30days_stay_criteria.R`
7. `7_min_300days_stay_criteria.R`
8. `8_percent_full_time_rentals.R`

Each script can be run using RStudio or from the command line using:
```bash
Rscript code/1_predicting_rental_price_model_A.R
