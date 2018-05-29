i# Overall DRG Stats Wrangler
# This Script has been created to showcase the overall stats for each of the measures

# Setup 
library(plotly)
library(ggplot2)
library(dplyr)
library(tidyr)

###############################################################################################

# All DRG Data for 2011 - 2015 
all_DRGdata <- read.csv("../../Data/Prepared/DRG_2011_2015.csv")
View(all_DRGdata)

###############################################################################################

# Overall Discharges

# Spreading the data so that each year is a column
DRG_overall_discharges <- all_DRGdata %>% group_by(year, drg) %>% summarise (discharges = sum(discharges)) %>% spread( year, discharges)

# Making all NA Values 0
DRG_overall_discharges[is.na(DRG_overall_discharges)] <- 0

# Creating a column called total for the total amount of discharges
DRG_overall_discharges <- DRG_overall_discharges %>% mutate(total_discharges = DRG_overall_discharges$`2011` + 
                                                              DRG_overall_discharges$`2012` + 
                                                              DRG_overall_discharges$`2013`+ 
                                                              DRG_overall_discharges$`2014`+
                                                              DRG_overall_discharges$`2015`) %>% arrange (-total_discharges)
colnames()
write.csv(DRG_overall_discharges, file = "../../Data/Prepared/overall_drg_discharges.csv", row.names=FALSE)

top_5_discharges <- head(DRG_overall_discharges, 5)
write.csv(top_5_discharges, file = "../../Data/Prepared/top_5_discharges.csv", row.names=FALSE)

top_10_discharges <- head(DRG_overall_discharges, 10)
write.csv(top_10_discharges, file = "../../Data/Prepared/top_10_discharges.csv", row.names=FALSE)

top_20_discharges <- head(DRG_overall_discharges, 20)
write.csv(top_20_discharges, file = "../../Data/Prepared/top_20_discharges.csv", row.names=FALSE)
View(top_20_discharges)

top_50_discharges <- head(DRG_overall_discharges, 50)
write.csv(top_50_discharges, file = "../../Data/Prepared/top_50_discharges.csv", row.names=FALSE)

top_100_discharges <- head(DRG_overall_discharges, 100)
write.csv(top_100_discharges, file = "../../Data/Prepared/top_100_discharges.csv", row.names=FALSE)

###############################################################################################

# Overall Average Total Payments
DRG_overall_avg_total_payments <- all_DRGdata %>% group_by(year, drg) %>% summarise (avg_total_payments = mean(avg_total_payments)) %>% spread( year, avg_total_payments)
DRG_overall_avg_total_payments[is.na(DRG_overall_avg_total_payments)] <- 0

DRG_overall_avg_total_payments <- DRG_overall_avg_total_payments %>% mutate(avg_total_payments = ((DRG_overall_avg_total_payments$`2011` + 
                                                                                                        DRG_overall_avg_total_payments$`2012` + 
                                                                                                        DRG_overall_avg_total_payments$`2013`+ 
                                                                                                        DRG_overall_avg_total_payments$`2014`+
                                                                                                        DRG_overall_avg_total_payments$`2015`)/5)) %>% arrange(-avg_total_payments)

write.csv(DRG_overall_avg_total_payments, file = "../../Data/Prepared/overall_drg_avg_total_payments.csv", row.names=FALSE)

top_5_avg_total_payments <- head(DRG_overall_avg_total_payments, 5)
write.csv(top_5_avg_total_payments, file = "../../Data/Prepared/top_5_avg_total_payments.csv", row.names=FALSE)

top_10_avg_total_payments <- head(DRG_overall_avg_total_payments, 10)
write.csv(top_10_avg_total_payments, file = "../../Data/Prepared/top_10_avg_total_payments.csv", row.names=FALSE)

top_20_avg_total_payments <- head(DRG_overall_avg_total_payments, 20)
write.csv(top_20_avg_total_payments, file = "../../Data/Prepared/top_20_avg_total_payments.csv", row.names=FALSE)

top_50_avg_total_payments <- head(DRG_overall_avg_total_payments, 50)
write.csv(top_50_avg_total_payments , file = "../../Data/Prepared/top_50_avg_total_payments.csv", row.names=FALSE)

top_100_avg_total_payments <- head(DRG_overall_avg_total_payments, 100)
write.csv(top_100_avg_total_payments, file = "../../Data/Prepared/top_100_avg_total_payments.csv", row.names=FALSE)

###############################################################################################

# Overall Average Medicare Payments
DRG_overall_avg_medicare_payments <- all_DRGdata %>% group_by(year, drg) %>% summarise (avg_medicare_payments = mean(avg_medicare_payments)) %>% spread( year, avg_medicare_payments) 
DRG_overall_avg_medicare_payments[is.na(DRG_overall_avg_medicare_payments)] <- 0
DRG_overall_avg_medicare_payments <- DRG_overall_avg_medicare_payments %>% mutate(avg_medicare_payments = ((DRG_overall_avg_medicare_payments$`2011` + 
                                                                                                                       DRG_overall_avg_medicare_payments$`2012` + 
                                                                                                                       DRG_overall_avg_medicare_payments$`2013`+
                                                                                                                       DRG_overall_avg_medicare_payments$`2014`+
                                                                                                                       DRG_overall_avg_medicare_payments$`2015`)/5)) %>% arrange(-avg_medicare_payments)

write.csv(DRG_overall_avg_medicare_payments, file = "../../Data/Prepared/overall_drg_avg_medicare_payments.csv", row.names=FALSE)

top_5_avg_medicare_payments <- head(DRG_overall_avg_medicare_payments, 5)
write.csv(top_5_avg_medicare_payments, file = "../../Data/Prepared/top_5_avg_medicare_payments.csv", row.names=FALSE)

top_10_avg_medicare_payments <- head(DRG_overall_avg_medicare_payments, 10)
write.csv(top_10_avg_medicare_payments, file = "../../Data/Prepared/top_10_avg_medicare_payments.csv", row.names=FALSE)

top_20_avg_medicare_payments <- head(DRG_overall_avg_medicare_payments, 20)
write.csv(top_20_avg_medicare_payments, file = "../../Data/Prepared/top_20_avg_medicare_payments.csv", row.names=FALSE)

top_50_avg_medicare_payments <- head(DRG_overall_avg_medicare_payments, 50)
write.csv(top_50_avg_medicare_payments, file = "../../Data/Prepared/top_50_avg_medicare_payments.csv", row.names=FALSE)

top_100_avg_medicare_payments <- head(DRG_overall_avg_medicare_payments, 100)
write.csv(top_100_avg_medicare_payments, file = "../../Data/Prepared/top_100_avg_medicare_payments.csv", row.names=FALSE)

###############################################################################################

# Overall Average Covered Charges
DRG_overall_avg_covered_charges <- all_DRGdata %>% group_by(year, drg) %>% summarise (avg_covered_charges = mean(avg_covered_charges)) %>% spread( year, avg_covered_charges) 
DRG_overall_avg_covered_charges[is.na(DRG_overall_avg_covered_charges)] <- 0
DRG_overall_avg_covered_charges <- DRG_overall_avg_covered_charges %>% mutate(avg_covered_charges = ((DRG_overall_avg_covered_charges$`2011` + 
                                                                                                                 DRG_overall_avg_covered_charges$`2012` + 
                                                                                                                 DRG_overall_avg_covered_charges$`2013`+ 
                                                                                                                 DRG_overall_avg_covered_charges$`2014`+
                                                                                                                 DRG_overall_avg_covered_charges$`2015`)/5)) %>% arrange(-avg_covered_charges)
View(DRG_overall_avg_covered_charges)

write.csv(DRG_overall_avg_covered_charges, file = "../../Data/Prepared/overall_drg_avg_covered_charges.csv", row.names=FALSE)

top_5_avg_covered_charges <- head(DRG_overall_avg_covered_charges, 5)
write.csv(top_5_avg_covered_charges, file = "../../Data/Prepared/top_5_avg_covered_charges.csv", row.names=FALSE)

top_10_avg_covered_charges <- head(DRG_overall_avg_covered_charges, 10)
write.csv(top_10_avg_covered_charges, file = "../../Data/Prepared/top_10_avg_covered_charges.csv", row.names=FALSE)

top_20_avg_covered_charges <- head(DRG_overall_avg_covered_charges, 20)
write.csv(top_20_avg_covered_charges, file = "../../Data/Prepared/top_20_avg_covered_charges.csv", row.names=FALSE)

top_50_avg_covered_charges <- head(DRG_overall_avg_covered_charges, 50)
write.csv(top_50_avg_covered_charges, file = "../../Data/Prepared/top_50_avg_covered_charges.csv", row.names=FALSE)

top_100_avg_covered_charges <- head(DRG_overall_avg_covered_charges, 100)
write.csv(top_100_avg_covered_charges, file = "../../Data/Prepared/top_100_avg_covered_charges.csv", row.names=FALSE)

###############################################################################################

# List of all the DRGs we have
all_drgs<-DRG_overall_discharges %>% select(drg)
View(all_drgs)
write.csv(all_drgs, file = "../../Data/Prepared/all_drgs.csv", row.names=FALSE)

###############################################################################################

# Cost Breakdown 
cost_breakdown<- all_DRGdata %>% group_by(drg) %>% summarise (discharges = sum(discharges),
                                                              avg_medicare_payment = mean(avg_medicare_payments), 
                                                              avg_covered_charge = mean(avg_covered_charges), 
                                                              avg_total_payment = mean(avg_total_payments)) %>% arrange (-discharges)


write.csv(cost_breakdown, file = "../../Data/Prepared/cost_breakdown.csv", row.names=FALSE)

top_10_discharge_costs <- head(cost_breakdown, 10)
write.csv(top_10_discharge_costs, file = "../../Data/Prepared/top_10_discharge_costs.csv", row.names=FALSE)

top_20_discharge_costs <- head(cost_breakdown, 20)
write.csv(top_20_discharge_costs, file = "../../Data/Prepared/top_20_discharge_costs.csv", row.names=FALSE)

top_50_discharge_costs <- head(cost_breakdown, 50)
write.csv(top_50_discharge_costs, file = "../../Data/Prepared/top_50_discharge_costs.csv", row.names=FALSE)

top_100_discharge_costs <-head(cost_breakdown, 100)
write.csv(top_100_discharge_costs, file = "../../Data/Prepared/top_100_discharge_costs.csv", row.names=FALSE)