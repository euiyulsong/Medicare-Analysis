# DRG Cost Breakdown Movement
# This visualization explores how the various statistics for DRGs have changed with time

library(plotly)

drg_year_breakdown_top100 <- read.csv("../../Data/Prepared/year_cost_breakdown_100.csv")


View(drg_year_breakdown_top100)

discharge_top100_medicare <- drg_year_breakdown_top100 %>% plot_ly(x = ~discharges, 
                                                                  y = ~avg_medicare_payment, 
                                                                  color = ~medical_department, 
                                                                  frame = ~year, 
                                                                  text = ~drg, 
                                                                  hoverinfo = "text",
                                                                  type = 'scatter',
                                                                  mode = 'markers') %>% 
                                                           layout(title = 'Average Medicare Payments Changing with Time for DRGS with Highest Discharges (top 100)',
                                                                  xaxis = list(type = "log", title="Number of Discharges"), 
                                                                  yaxis =list(title="Average Medicare Payments")) %>% 
                                                           animation_opts(1000, easing = "elastic", redraw = FALSE)