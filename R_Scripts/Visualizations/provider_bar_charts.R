library(dplyr)
library(plotly)
library(tidyr)

all.data <- read.csv("../../Data/Prepared/DRG_2011_2015.csv")
data.2015 <- read.csv("../../Data/Raw/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_All_Diagnosis-Related_Groups__DRG__-_FY2015.csv")

provider.medicare.2015 <- data.2015 %>% group_by(Provider.Name) %>% summarise(avg_medicare_payments = mean(Average.Medicare.Payments))
provider.total.2015 <- data.2015 %>% group_by(Provider.Name) %>% summarise(avg_total_payments = mean(Average.Total.Payments))
provider.2015 <- provider.total.2015 %>% left_join(provider.medicare.2015, by='Provider.Name')
write.csv(provider.2015, file = "../../Data/Prepared/provider_2015.csv")

provider.2015.plot.lowest <- provider.2015 %>% arrange(avg_total_payments) %>% slice(1:10)
write.csv(provider.2015.plot.data.highest,"../../Data/Prepared/provider_2015_plot_data_highest.csv")

plot.2015.lowest <- plot_ly(provider.2015.plot.lowest, x = ~reorder(Provider.Name, avg_total_payments), y= ~avg_total_payments, type="bar", marker = list(color = 'skyblue'), name = "Average Total Payments") %>% 
        add_trace(y = ~avg_medicare_payments, name = "Average Medicare Payments", marker = list(color = 'blue')) %>% 
        layout(title = "Top 10 Providers with Lowest Average Total Payments in 2015", 
          xaxis = list(title = 'Provider'),
          yaxis = list(title = 'Average Total Payments ($)'),
          barmode = "Group", margin = list(b = 160, t = 50))
plot.2015.lowest

provider.2015.plot.data.highest <- provider.2015 %>% arrange(-avg_total_payments) %>% slice(1:10)
write.csv(provider.2015.plot.data.highest,"../../Data/Prepared/provider_2015_plot_data_highest.csv")

plot.2015.highest <- plot_ly(provider.2015.plot.data.highest, x = ~reorder(Provider.Name, -avg_total_payments), y= ~avg_total_payments, type="bar", marker = list(color = 'dodgerblue'), name = "Average Total Payments") %>% 
  add_trace(y = ~avg_medicare_payments, name = "Average Medicare Payments", marker = list(color = 'lightgreen')) %>% 
  layout(title = "Top 10 Providers with Highest Average Total Payments in 2015", 
         xaxis = list(title = 'Provider'),
         yaxis = list(title = 'Average Total Payments ($)'),
         barmode = "Group", margin = list(b = 160, t = 50))
plot.2015.highest

# data wrangling
provider_avg_total <- all.data %>% group_by(year, provider) %>% summarise(avg_total_payments = mean(avg_total_payments)) %>% spread(year, avg_total_payments) 
write.csv(provider_avg_total, file = "../../Data/Prepared/provider_avg_total.csv")

plot.data <- provider_avg_total %>% arrange(`2015`) %>% slice(1:20)

p <- plot_ly(plot.data, x = ~reorder(provider, `2015`), y = ~`2011`, name = "2011", type = 'bar', marker = list(color = '#25CCF7')) %>% 
  add_trace(y = ~`2012`, name = "2012", marker = list(color = '#1B9CFC')) %>% 
  add_trace(y = ~`2013`, name = "2013", marker = list(color = '#3B3B98')) %>% 
  add_trace(y = ~`2014`, name = "2014", marker = list(color = '#B33771')) %>% 
  add_trace(y = ~`2015`, name = "2015", marker = list(color = '#182C61')) %>% 
  layout(title = "Top 10 Providers with Lowest Average Total Payments in 2015", 
         xaxis = list(title = 'Hospital'),
         yaxis = list(title = 'Average Total Payments ($)'),
         barmode = "Group", margin = list(b = 200, t = 50))
p

# this is the actual function for shiny to use
# takes in the data set and filter by the selected DRG
ProviderTotalGraph <- function(data) {
  
  # arrange data from smallest to largest and take the top 10
  plot.data <- data %>% arrange(`2015`) %>% slice(1:10)
  
  #render graph
  bar.graph <- plot_ly(plot.data, x = ~reorder(provider, `2015`), y = ~`2011`, name = "2011", type = 'bar', marker = list(color = 'slateblue')) %>% 
    add_trace(y = ~`2012`, name = "2012", marker = list(color = 'cyan')) %>% 
    add_trace(y = ~`2013`, name = "2013", marker = list(color = 'blue')) %>% 
    add_trace(y = ~`2014`, name = "2014", marker = list(color = 'purple')) %>% 
    add_trace(y = ~`2015`, name = "2015", marker = list(color = 'pink')) %>% 
    layout(title = "Top 10 Lowest Total Payments by Hospital", 
           xaxis = list(title = 'Hospital'),
           yaxis = list(title = 'Average Total Payments ($)'))
  
  return(bar.graph)
}

ProviderTotalGraph(plot.data)