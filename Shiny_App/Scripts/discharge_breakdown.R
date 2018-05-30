# Discharge Breakdown Bar Chart 
# Function to create a bar chart for the discharges

library(plotly)
library(dplyr)
library(tidyr)

# overview.discharges <- read.csv("../Data/year_cost_breakdown.csv", stringsAsFactors = F)

Discharge_Bar_Chart <- function (drg.name, data) {

  data <-filter (data, drg == drg.name)
  
  title.discharge <- paste0 ('<b style="color:CF000F">', "Discharge Annual Statistics for ", drg.name," (",data$medical_department, ")", "</b><br>")
  
  f <- list( family = "Helvetica", size = 18, color = "1c1c1c")
  
  discharges_bar <- plot_ly(data, 
                            x = ~year,
                            y = ~discharges, 
                            type = 'bar', 
                            name = 'Discharge Breakdown',
                            text = ~paste(discharges), 
                            textposition = 'auto') %>% 
                    layout(title = title.discharge)
                         
  return (discharges_bar)
}

# drg.test <- "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"
# test <- overview.discharges
# test_chart <- Discharge_Bar_Chart(drg.test, test)
# test_chart

