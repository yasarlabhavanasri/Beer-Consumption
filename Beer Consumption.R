# Set the working directory to where your dataset is located
setwd("C:/Users/SourceCode/Downloads")

# Load the necessary libraries
library(ggplot2)
library(dplyr)

# Load the data
beer_data <- read.csv("Consumo_cerveja.csv", stringsAsFactors = FALSE, dec = ",", header = TRUE)

# Rename columns for easier reference
names(beer_data) <- c("Date", "AverageTemperature", "MinTemperature", "MaxTemperature", "Precipitation", "Weekend", "BeerConsumption")

# Convert data types, ensuring that numeric columns are correctly formatted
beer_data$AverageTemperature <- as.numeric(gsub(",", ".", beer_data$AverageTemperature))
beer_data$BeerConsumption <- as.numeric(gsub(",", ".", beer_data$BeerConsumption))

# Remove rows with any NA values to ensure clean data for analysis
beer_data <- na.omit(beer_data)

# Creating the Histogram for Average Temperature
ggplot(beer_data, aes(x = AverageTemperature)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Average Temperature",
       x = "Average Temperature (°C)", 
       y = "Frequency") +
  theme_minimal()

# Creating the Scatter Plot for Beer Consumption vs. Average Temperature
ggplot(beer_data, aes(x = AverageTemperature, y = BeerConsumption)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Beer Consumption vs. Average Temperature",
       x = "Average Temperature (°C)",
       y = "Beer Consumption (liters)") +
  theme_minimal()

# Calculate Pearson's correlation coefficient
correlation_test <- cor.test(beer_data$AverageTemperature, beer_data$BeerConsumption, method = "pearson")

# Print the results of the correlation test
print(correlation_test)
