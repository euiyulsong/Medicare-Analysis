library(dplyr)
library(plotly)

all_DRGdata <- read.csv("../../Data/Prepared/DRG_2011_2015.csv")

drg_state_avg_covered_charges <- all_DRGdata %>%  group_by(state) %>% summarise(avg_covered_charges = mean(avg_covered_charges), total_discharges = sum(discharges))

write.csv()


g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white'))

avg_covered_charges_plot <- plot_geo(drg_state_avg_covered_charges, locationmode = 'USA-states') %>%
  add_trace(
    z = ~avg_covered_charges, locations = ~state,
    color = ~avg_covered_charges, colors = 'Blues'
  ) %>%
  colorbar(title = "Average Covered Charges") %>%
  layout(
    title = 'Average Covered Charges by State',
    geo = g
  )

avg_covered_charges_plot


avg_covered_charges_plot

total_discharges_plot <- plot_geo(drg_state_avg_covered_charges, locationmode = 'USA-states') %>%
  add_trace(
    z = ~total_discharges, locations = ~state,
    color = ~total_discharges, colors = 'Blues'
  ) %>%
  colorbar(title = "Total Discharges") %>%
  layout(
    title = 'Total Discharges by State',
    geo = g
  )

total_discharges_plot
