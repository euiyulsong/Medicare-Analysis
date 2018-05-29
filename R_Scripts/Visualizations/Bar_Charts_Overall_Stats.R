# DRG_Most Cases
# This script has been created to make a visualization on the top DRGs in terms of discharges

# Setup
library(plotly)
library(ggplot2)
library(dplyr)
library(tidyr)

##############################################################################################
# Discharges                                                                                 #
##############################################################################################

top_10_discharges <- read.csv("../../Data/Prepared/top_10_discharges.csv") 
top_10_discharges <- top_10_discharges %>% arrange(total_discharges)
colnames(top_10_discharges) <- c("drg","2011", "2012", "2013", "2014", "2015", "total")

f <- list( family = "Open Sans, Sans Serif, monospace", size = 18, color = "#7f7f7f")

# Vertical Bar Chart
x <- list( title = "DRG", titlefont = f)
y <- list( title = "Number of Discharges", titlefont = f)

discharges_bar <- plot_ly(top_10_discharges,
                            x = ~reorder(drg, -total),
                            y = ~`2011` , 
                            type = 'bar', 
                            name = '2011', marker = list(color = '#25CCF7')) %>% 
                  add_trace(y = ~`2012`, name = "2012", marker = list(color = '#1B9CFC')) %>%
                  add_trace(y = ~`2013`, name = "2013", marker = list(color = '#B33771')) %>% 
                  add_trace(y = ~`2014`, name = "2014", marker = list(color = '#3B3B98')) %>% 
                  add_trace(y = ~`2015`, name = "2015", marker = list(color = '#182C61')) %>%
                  layout(title = 'Top 10 DRGs with Highest Number of Discharges',
                          xaxis = x, 
                          yaxis = y,
                          barmode = 'stack',
                          margin = list(b = 250, pad = 4), 
                          xaxis = list(tickangle = 45)) %>%
                          add_annotations(xref = 'x1', yref = 'y',
                          y = ~total + 120000,
                          text = ~paste(total, '<br>discharges'),
                          font = list(family = 'Arial', size = 12, color = 'rgb(150, 171, 234)'),
                          showarrow = FALSE)                  

discharges_bar

# Horizontal Bar Chart

y <- list( title = "", titlefont = f)
x <- list( title = "Number of Discharges", titlefont = f)

discharges_h_bar <- plot_ly(top_10_discharges,
                            x = ~`2011`,
                            y = ~reorder(drg,total), 
                            type = 'bar', 
                            orientation = 'h',
                            name = '2011', marker = list(color = '#25CCF7')) %>% 
  add_trace(x = ~`2012`, name = "2012", marker = list(color = '#1B9CFC')) %>%
  add_trace(x = ~`2013`, name = "2013", marker = list(color = '#B33771')) %>% 
  add_trace(x = ~`2014`, name = "2014", marker = list(color = '#3B3B98')) %>% 
  add_trace(x = ~`2015`, name = "2015", marker = list(color = '#182C61')) %>%
  layout(title = 'Top 10 DRGs with Highest Number of Discharges',
         xaxis = x, 
         yaxis = y,
         barmode = 'stack',
         margin = list(l = 550, b = 100, pad = 4), 
         yaxis = list(tickangle = 90)) %>%
  add_annotations(xref = 'x1', yref = 'y',
                  x = ~total + 120000,
                  text =  ~paste(total, '<br>discharges'),
                  font = list(family = 'Arial', size = 12, color = 'rgb(150, 171, 234)'),
                  showarrow = FALSE)                  

discharges_h_bar

##############################################################################################
# Average Covered Charges                                                                    #
##############################################################################################
f <- list( family = "Open Sans, Sans Serif, monospace", size = 18, color = "#7f7f7f")
top_10_covered <- read.csv("../../Data/Prepared/top_10_avg_covered_charges.csv")
top_10_covered <- top_10_covered%>% arrange(avg_covered_charges)
colnames(top_10_covered) <- c("drg","2011", "2012", "2013", "2014", "2015", "avg")
View(top_10_covered)
# Vertical Bar Chart
x <- list( title = "DRG", titlefont = f)
y <- list( title = "Average Covered Charges($)", titlefont = f)

covered_charges_bar <- plot_ly(top_10_covered,
                          x = ~reorder(drg, -avg),
                          y = ~`avg` , 
                          type = 'bar', 
                          name = 'Average Covered Charges', marker = list(color = '#079992')) %>% 
                  layout(title = 'Top 10 DRGs with Highest Average Covered Charges',
                         xaxis = x, 
                         yaxis = y,
                         margin = list(b = 250, pad = 4), 
                         xaxis = list(tickangle = 45)) %>%
                  add_annotations(xref = 'x1', yref = 'y',
                                  y = ~avg + 4500,
                                  text = ~paste("$",round(avg,2)),
                                  font = list(family = 'Arial', size = 12, color = 'rgb(150, 171, 234)'),
                                  showarrow = FALSE)                  

covered_charges_bar

# Horizontal Bar Chart

y <- list( title = "", titlefont = f)
x <- list( title = "Number of Discharges", titlefont = f)


covered_charges_h_bar <- plot_ly(top_10_covered,
                               y = ~reorder(drg, avg),
                               x = ~`avg` , 
                               type = 'bar', 
                               name = 'Average Covered Charges',
                               orientation = "h",
                               marker = list(color = '#079992')) %>% 
                        layout(title = 'Top 10 DRGs with Highest Average Covered Charges',
                               xaxis = x, 
                               yaxis = y,
                               margin = list(l = 500, pad = 4), 
                               xaxis = list(tickangle = 45)) %>%
                        add_annotations(xref = 'x1', yref = 'y',
                                        x = ~avg + 11800,
                                        text = ~paste("$",round(avg,2)),
                                        font = list(family = 'Arial', size = 12, color = 'rgb(150, 171, 234)'),
                                        showarrow = FALSE)   

covered_charges_h_bar 

##############################################################################################
# Average Total Payments                                                                     #
##############################################################################################
f <- list( family = "Open Sans, Sans Serif, monospace", size = 18, color = "#7f7f7f")
top_10_payments <- read.csv("../../Data/Prepared/top_10_avg_total_payments.csv")
top_10_payments <- top_10_payments%>% arrange(avg_total_payments)
colnames(top_10_payments) <- c("drg","2011", "2012", "2013", "2014", "2015", "avg")

# Vertical Bar Chart
x <- list( title = "DRG", titlefont = f)
y <- list( title = "Average Total Payments($)", titlefont = f)

total_payments_bar <- plot_ly(top_10_payments,
                               x = ~reorder(drg, -avg),
                               y = ~`avg` , 
                               type = 'bar', 
                               name = 'Average Total Payments', marker = list(color = '#079992')) %>% 
  layout(title = 'Top 10 DRGs with Highest Average Total Payments',
         xaxis = x, 
         yaxis = y,
         margin = list(b = 250, pad = 4), 
         xaxis = list(tickangle = 45)) %>%
  add_annotations(xref = 'x1', yref = 'y',
                  y = ~avg + 4500,
                  text = ~paste("$",round(avg,2)),
                  font = list(family = 'Arial', size = 12, color = 'rgb(150, 171, 234)'),
                  showarrow = FALSE)                  

total_payments_bar

# Horizontal Bar Chart
y <- list( title = "", titlefont = f)
x <- list( title = "Number of Discharges", titlefont = f)
total_payments_h_bar <- plot_ly(top_10_payments,
                                 y = ~reorder(drg, avg),
                                 x = ~`avg` , 
                                 type = 'bar', 
                                 name = 'Average Total Payments',
                                 orientation = "h",
                                 marker = list(color = '#079992')) %>% 
  layout(title = 'Top 10 DRGs with Highest Average Total Payments',
         xaxis = x, 
         yaxis = y,
         margin = list(l = 500, pad = 4), 
         xaxis = list(tickangle = 45)) %>%
  add_annotations(xref = 'x1', yref = 'y',
                  x = ~avg + 3000,
                  text = ~paste("$",round(avg,2)),
                  font = list(family = 'Arial', size = 12, color = 'rgb(150, 171, 234)'),
                  showarrow = FALSE) 

total_payments_h_bar

##############################################################################################
# Average Medicare Payments                                                                  #
##############################################################################################

f <- list( family = "Open Sans, Sans Serif, monospace", size = 18, color = "#7f7f7f")
top_10_medicare <- read.csv("../../Data/Prepared/top_10_avg_medicare_payments.csv")
top_10_medicare <- top_10_medicare%>% arrange(avg_medicare_payments)
colnames(top_10_medicare) <- c("drg","2011", "2012", "2013", "2014", "2015", "avg")

# Vertical Bar Chart
x <- list( title = "DRG", titlefont = f)
y <- list( title = "Average Medicare Payments($)", titlefont = f)

medicare_payments_bar <- plot_ly(top_10_medicare,
                              x = ~reorder(drg, -avg),
                              y = ~`avg` , 
                              type = 'bar', 
                              name = 'Average Medicare Payments', marker = list(color = '#079992')) %>% 
  layout(title = 'Top 10 DRGs with Highest Average Medicare Payments',
         xaxis = x, 
         yaxis = y,
         margin = list(b = 250, pad = 4), 
         xaxis = list(tickangle = 45)) %>%
  add_annotations(xref = 'x1', yref = 'y',
                  y = ~avg + 1500,
                  text = ~paste("$",round(avg,2)),
                  font = list(family = 'Arial', size = 12, color = 'rgb(150, 171, 234)'),
                  showarrow = FALSE)                  

medicare_payments_bar

##############################################################################################
# Cost Breakdown for the top 10 DRGs with Highest Number of Discharges                       #
##############################################################################################

cost_breakdown <- read.csv("../../Data/Prepared/top_10_discharge_costs.csv")
View(cost_breakdown)
