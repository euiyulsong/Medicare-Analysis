# DRG_Most Cases
# This script has been created to make a visualization on the top DRGs in terms of discharges

# Setup 
library(plotly)
library(ggplot2)
library(dplyr)
library(tidyr)

###############################################################################################

# Discharge Data for the years 2011 - 2015

discharges <- read.csv("../../Data/Prepared/overall_drg_discharges.csv")
discharges <- discharges %>% arrange(-total) 
colnames(discharges) <- c("drg","2011", "2012", "2013", "2014", "2015", "total")

top_5 <- head(discharges, 5)

#data$Animals <- factor(data$Animals, levels = unique(data$Animals)[order(data$Count, decreasing = TRUE)])

p <- plot_ly(top_5, x = ~drg, y = ~`2011`, type = 'bar', name = "2011") %>% 
            add_trace(y = ~`2012`, name = '2012') %>%
            layout(yaxis = list(title = 'discharges'), barmode = 'group')
p
