#loading Libraries
library(shiny)
library(dplyr)
library(plotly)
library(stringr)

source("scripts/discharge_breakdown.r")

# Data
overview.discharges <- read.csv("Data/year_cost_breakdown.csv", stringsAsFactors = F)
drg_state_avg_covered_charges <- read.csv("Data/drg_state_avg_covered_charges.csv",stringsAsFactors = F)

drg_all <- read.csv("Data/DRG_2011_2015.csv")
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
server <- function(input, output, session) {
  
  # Discharge Breakdown Bar Chart - Zoshua
  output$discharge.breakdown.bar <- renderPlotly(Discharge_Bar_Chart(input$select.drg.discharge.brk, overview.discharges))
  
  
  # Chloropleth Map - Vanessa
  output$plot <- renderPlotly({
    
    if(input$map == 1) {
      plot_geo(drg_state_avg_covered_charges, locationmode = 'USA-states') %>%
        add_trace(
          z = ~avg_covered_charges, locations = ~state,
          color = ~avg_covered_charges, colors = 'Blues'
        ) %>%
        colorbar(title = "Average Covered Charges") %>%
        layout(
          title = 'Average Covered Charges by State',
          geo = g
        )
    } else if (input$map == 2) {
      plot_geo(drg_state_avg_covered_charges, locationmode = 'USA-states') %>%
        add_trace(
          z = ~total_discharges, locations = ~state,
          color = ~total_discharges, colors = 'Blues'
        ) %>%
        colorbar(title = "Total Discharges") %>%
        layout(
          title = 'Total Discharges by State',
          geo = g
        )
    }
  })
}