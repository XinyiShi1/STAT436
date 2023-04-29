library(dplyr)

# Download and read the dataset
url <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-12-22/big-mac.csv"
big_mac_data <- read.csv(url)

# Calculate the percentage of under or overvaluation
big_mac_data <- big_mac_data %>%
  mutate(valuation_percentage = (dollar_price / dollar_ex - 1) * 100)
