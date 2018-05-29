# DRG Category Wrangler
# This script has been made to make datasets to investigate into the trends for the DRG Categories 
# The DRG Categories have been provided by Dr.Hsu in a dataset 

# Setup
library(dplyr)
library(tidyr)
library(plotly)
library(ggplot2)

###################################################################################################
# Loading Datasets
###################################################################################################
drg_category <- read.csv("../../Data/Prepared/DRGs_with_categories.csv")
colnames(drg_category)<- c("drg","body_system", "medical_department", "body_part") 
discharges <- read.csv("../../Data/Prepared/overall_drg_discharges.csv")
colnames(discharges) <- c("drg","2011", "2012", "2013", "2014", "2015", "total") 

discharges <- discharges %>% merge(drg_category, by = "drg") 

body_system_discharges <- discharges %>% group_by(body_system) %>% summarise( total_2011 = sum(`2011`),
                                         total_2012 = sum(`2012`),
                                         total_2013 = sum(`2013`),
                                         total_2014 = sum(`2014`),
                                         total_2015 = sum(`2015`),
                                         total_discharges = sum(total)) %>% arrange(-total_discharges)

medical_dept_discharges <- discharges %>% group_by(medical_department) %>% summarise( total_2011 = sum(`2011`),
                                                                                          total_2012 = sum(`2012`),
                                                                                          total_2013 = sum(`2013`),
                                                                                          total_2014 = sum(`2014`),
                                                                                          total_2015 = sum(`2015`),
                                                                                          total_discharges = sum(total)) %>% arrange(-total_discharges)

View(body_system_discharges)
