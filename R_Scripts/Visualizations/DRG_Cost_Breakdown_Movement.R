# DRG Cost Breakdown Movement
# This visualization explores how the various statistics for DRGs have changed with time

library(plotly)
library(gapminder)

drg_year_breakdown <- read.csv("../../Data/Prepared/year_cost_breakdown.csv")
drg_year_breakdown_top100 <- read.csv("../../Data/Prepared/year_cost_breakdown_100.csv")
View(drg_year_breakdown)

drg_year_breakdown <- drg_year_breakdown %>% arrange(-discharges)
discharge_medicare <- drg_year_breakdown %>% plot_ly(x = ~discharges, 
                                                    y = ~avg_medicare_payment, 
                                                    color = ~medical_department, 
                                                    frame = ~year, 
                                                    text = ~drg, 
                                                    hoverinfo = "text",
                                                    type = 'scatter',
                                                    mode = 'markers') %>% 
                                             layout(xaxis = list(type = "log", title="Number of Discharges"), 
                                                    yaxis =list(title="Average Medicare Payments")) 



discharge_top100_medicare <- drg_year_breakdown_top100 %>% plot_ly(x = ~discharges, 
                                                                  y = ~avg_medicare_payment, 
                                                                  color = ~medical_department, 
                                                                  frame = ~year, 
                                                                  text = ~drg, 
                                                                  hoverinfo = "text",
                                                                  type = 'scatter',
                                                                  mode = 'markers') %>% 
                                                                  layout(xaxis = list(type = "log", title="Number of Discharges"), 
                                                                  yaxis =list(title="Average Medicare Payments")) 
discharge_top100_medicare
