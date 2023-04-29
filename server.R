#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(DT)
library(shinythemes)

# Define server logic
server <- function(input, output) {
  
  # Render the line plot
  output$lineplot <- renderPlot({
    selected_country_data <- big_mac_data %>% filter(name == input$country)
    
    ggplot() +
      geom_line(data = selected_country_data, aes(x = date, y = valuation_percentage, group = 1), color = "blue") +
      geom_point(data = big_mac_data, aes(x = date, y = valuation_percentage, color = valuation_percentage > 0, alpha = 0.6)) +
      scale_color_manual(values = c("red", "green")) +
      scale_alpha(range = c(0.6, 0.6), guide = "none") +
      labs(x = "Year",
           y = "Valuation Percentage",
           title = paste0("Big Mac Index: ", input$country, " vs Other Countries")) +
      ylim(-100, 300) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5),
            axis.title = element_text(face = "bold"),
            axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
  })
  
  # Filter data by selected dates
  filtered_data_by_date <- reactive({
    big_mac_data %>% filter(date %in% input$date)
  })
  
  # Render the data table
  output$datatable <- renderDT({
    datatable(filtered_data_by_date() %>%
                select(name, currency_code, valuation_percentage, date),
              options = list(pageLength = 25))
  })
}