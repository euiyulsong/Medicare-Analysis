# DRG Cost Breakdown Movement
# This visualization explores how the various statistics for DRGs have changed with time

library(plotly)

drg_year_breakdown_top100 <- read.csv("../../Data/Prepared/year_cost_breakdown_100.csv")

discharge_top100_medicare <- drg_year_breakdown_top100 %>% plot_ly(x = ~discharges, 
                                                                  y = ~avg_medicare_payment, 
                                                                  color = ~medical_department, 
                                                                  frame = ~year, 
                                                                  text = ~drg, 
                                                                  hoverinfo = "text",
                                                                  type = 'scatter',
                                                                  mode = 'markers') %>% 
                                                           layout(title = 'Average Medicare Payments Changing with Time and Discharges'
                                                                  xaxis = list(type = "log", title="Number of Discharges"), 
                                                                  yaxis =list(title="Average Medicare Payments")) %>% 
                                                           animation_opts(1000, easing = "elastic", redraw = FALSE)

layout(title = 'DRGs with Most Discharges for 2011-15 (Top 10)',
       font = t,
       xaxis = x, 
       yaxis = y,
       barmode = 'stack',
       margin = list(l = 420, b = 100, pad = 4), 
       yaxis = list(tickangle = 90),
       legend = list(orientation = 'h', 
                     title = 'Legend',
                     font = list( family = "sans-serif",
                                  size = 8,
                                  color = "#000"),
                     bgcolor = "FFFFFF",
                     bordercolor = "#0a3d62",
                     borderwidth = 0.5))