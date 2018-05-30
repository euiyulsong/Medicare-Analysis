library(dplyr)
library(plotly)
library(tidyr)

# the path to the folder is wrong i think
all.data <- read.csv("Data/Prepared/DRG_2011_2015.csv")

# group data
# I can also write this into a csv into the prepared folder so I don't need to read in the entire folder
provider_avg_total <- all.data %>% group_by(year, drg, provider) %>% summarise(avg_total_payments = mean(avg_total_payments)) %>% spread(year, avg_total_payments) 

# The widget will do most of the filtering
# users will chose a DRG to filter
# - Did this manually to make it easier to create a graph
plot.data <- provider_avg_total %>% filter(drg == "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC") %>% arrange(`2015`) %>% slice(1:10) 

p <- plot_ly(plot.data, x = ~reorder(provider, `2015`), y = ~`2011`, name = "2011", type = 'bar', marker = list(color = 'slateblue')) %>% 
  add_trace(y = ~`2012`, name = "2012", marker = list(color = 'blue')) %>% 
  add_trace(y = ~`2013`, name = "2013", marker = list(color = 'cyan')) %>% 
  add_trace(y = ~`2014`, name = "2014", marker = list(color = 'purple')) %>% 
  add_trace(y = ~`2015`, name = "2015", marker = list(color = 'pink')) %>% 
  layout(title = "Top 10 Lowest Total Payments by Hospital", 
         xaxis = list(title = 'Hospital'),
         yaxis = list(title = 'Average Total Payments ($)'))
p

# this is the actual function for shiny to use
# takes in the data set and filter by the selected DRG
ProviderTotalGraph <- function(data) {
  
  # arrange data from smallest to largest and take the top 10
  plot.data <- data %>% arrange(`2015`) %>% slice(1:10)
  
  #render graph
  bar.graph <- plot_ly(plot.data, x = ~reorder(provider, `2015`), y = ~`2011`, name = "2011", type = 'bar', marker = list(color = 'slateblue')) %>% 
    add_trace(y = ~`2012`, name = "2012", marker = list(color = 'blue')) %>% 
    add_trace(y = ~`2013`, name = "2013", marker = list(color = 'cyan')) %>% 
    add_trace(y = ~`2014`, name = "2014", marker = list(color = 'purple')) %>% 
    add_trace(y = ~`2015`, name = "2015", marker = list(color = 'pink')) %>% 
    layout(title = "Top 10 Lowest Total Payments by Hospital", 
           xaxis = list(title = 'Hospital'),
           yaxis = list(title = 'Average Total Payments ($)'))
  
  return(bar.graph)
}

ProviderTotalGraph(plot.data)
