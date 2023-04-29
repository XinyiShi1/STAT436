#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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


# Define UI
ui <- fluidPage(
  
  theme = shinytheme("cerulean"),
  titlePanel("Big Mac Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("country", "Select a country:", unique(big_mac_data$name)),
      selectInput("date", "Select date(s):", unique(big_mac_data$date), multiple = TRUE)
    ),
    
    mainPanel(
      plotOutput("lineplot"),
      DTOutput("datatable")
    )
  )
)
