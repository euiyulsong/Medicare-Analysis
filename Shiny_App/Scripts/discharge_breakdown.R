# Discharge Breakdown Bar Chart 
# Function to create a bar chart for the discharges

library(plotly)
library(dplyr)
library(tidyr)

# overview.discharges <- read.csv("../Data/year_cost_breakdown.csv", stringsAsFactors = F)

Discharge_Bar_Chart <- function (drg.name, data) {

  data <-filter (data, drg == drg.name)
  
  data$year <- as.character(as.numeric(data$year))
  
  
  title.discharge <- paste0 ("Discharge Annual Statistics for <br>", drg.name," (",data$medical_department, ")")
  
  f <- list( family = "Helvetica", size = 10, color = "1c1c1c")
  
  discharges_bar <- plot_ly(data, 
                            x = ~year,
                            y = ~discharges, 
                            type = 'bar', 
                            name = 'Discharge Breakdown',
                            text = ~paste(discharges), 
                            textposition = 'auto', 
                            marker = list(color = '#25CCF7')) %>% 
                    layout(title = title.discharge, 
                           xaxis = list( title = "Year"),
                           yaxis = list( title = "Number of Discharges"))
  return (discharges_bar)
}

# drg.test <- "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"
# test <- overview.discharges
# test_chart <- Discharge_Bar_Chart(drg.test, test)
# test_chart

