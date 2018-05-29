# Discharges Wrangler 

# Setup 
library(plotly)
library(ggplot2)
library(dplyr)
library(tidyr)

###############################################################################################

# All DRG Data for 2011 - 2015 

all_DRGdata <- read.csv("../../Data/Prepared/DRG_2011_2015.csv")
View(all_DRGdata)

# DRG Discharges
drg_discharges <- all_DRGdata %>% group_by(drg) %>% summarize ( total_discharges = sum(discharges)) %>% arrange(-total_discharges)
View(drg_discharges)

# Top Discharges

top_20_discharges <- head(drg_discharges,20) %>% arrange(-total_discharges)
write.csv(top_20_discharges, file = "../../Data/Prepared/top_20_discharges.csv")

top_40_discharges <- head(drg_discharges,40) %>% arrange(-total_discharges)
write.csv(top_40_discharges, file = "../../Data/Prepared/top_40_discharges.csv")

top_50_discharges <- head(drg_discharges,50) %>% arrange(-total_discharges)
write.csv(top_50_discharges, file = "../../Data/Prepared/top_50_discharges.csv")

top_100_discharges <- head(drg_discharges,100) %>% arrange(-total_discharges)
write.csv(top_100_discharges, file = "../../Data/Prepared/top_100_discharges.csv")