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

covered_charges <- read.csv("../../Data/Prepared/overall_drg_avg_covered_charges.csv")
colnames(covered_charges) <- c("drg","2011", "2012", "2013", "2014", "2015", "avg")

total_payments <- read.csv("../../Data/Prepared/overall_drg_avg_total_payments.csv")
colnames(total_payments) <- c("drg","2011", "2012", "2013", "2014", "2015", "avg")

medicare_payments <- read.csv("../../Data/Prepared/overall_drg_avg_medicare_payments.csv")
colnames(medicare_payments ) <- c("drg","2011", "2012", "2013", "2014", "2015", "avg")

###################################################################################################
# Discharges
###################################################################################################
discharges <- discharges %>% merge(drg_category, by = "drg") 

body_system_discharges <- discharges %>% group_by(body_system) %>% summarise( discharges_2011 = sum(`2011`),
                                                                              discharges_2012 = sum(`2012`),
                                                                              discharges_2013 = sum(`2013`),
                                                                              discharges_2014 = sum(`2014`),
                                                                              discharges_2015 = sum(`2015`),
                                                                              total_discharges = sum(total)) %>% arrange(-total_discharges)

write.csv(body_system_discharges, file = "../../Data/Prepared/body_system_discharges.csv", row.names=FALSE)


View(body_system_discharges)

medical_dept_discharges <- discharges %>% group_by(medical_department) %>% summarise( discharges_2011 = sum(`2011`),
                                                                                      discharges_2012 = sum(`2012`),
                                                                                      discharges_2013 = sum(`2013`),
                                                                                      discharges_2014 = sum(`2014`),
                                                                                      discharges_2015 = sum(`2015`),
                                                                                      total_discharges = sum(total)) %>% arrange(-total_discharges) %>%  arrange(-total_discharges)

write.csv(medical_dept_discharges, file = "../../Data/Prepared/medical_dept_discharges.csv", row.names=FALSE)


View(medical_dept_discharges)
###################################################################################################
# Average Covered Charges + DRG Category 
###################################################################################################

covered_charges <- covered_charges %>% merge(drg_category, by = "drg") 

body_system_covered_charges <- covered_charges %>% group_by(body_system) %>% summarise( covered_charges_2011 = mean(`2011`),
                                                                                        covered_charges_2012 = mean(`2012`),
                                                                                        covered_charges_2013 = mean(`2013`),
                                                                                        covered_charges_2014 = mean(`2014`),
                                                                                        covered_charges_2015 = mean(`2015`),
                                                                                        avg_covered_charges = mean(avg)) %>% arrange(-avg_covered_charges)

write.csv(body_system_covered_charges, file = "../../Data/Prepared/body_system_covered_charges.csv", row.names=FALSE)

medical_dept_covered_charges <- covered_charges %>% group_by(medical_department) %>% summarise( covered_charges_2011 = mean(`2011`),
                                                                                        covered_charges_2012 = mean(`2012`),
                                                                                        covered_charges_2013 = mean(`2013`),
                                                                                        covered_charges_2014 = mean(`2014`),
                                                                                        covered_charges_2015 = mean(`2015`),
                                                                                        avg_covered_charges = mean(avg)) %>% arrange(-avg_covered_charges)
write.csv(medical_dept_covered_charges, file = "../../Data/Prepared/medical_dept_covered_charges.csv", row.names=FALSE)

###################################################################################################
# Average Total Paymments + DRG Category
###################################################################################################

total_payments <- total_payments %>% merge(drg_category, by = "drg") 

body_system_total_payments <- total_payments %>% group_by(body_system) %>% summarise( total_payments_2011 = mean(`2011`),
                                                                                      total_payments_2012 = mean(`2012`),
                                                                                      total_payments_2013 = mean(`2013`),
                                                                                      total_payments_2014 = mean(`2014`),
                                                                                      total_payments_2015 = mean(`2015`),
                                                                                      avg_total_payments = mean(avg)) %>% arrange(-avg_total_payments)

write.csv(body_system_total_payments, file = "../../Data/Prepared/body_system_total_payments.csv", row.names=FALSE)

medical_dept_total_payments <- total_payments %>% group_by(medical_department) %>% summarise( total_payments_2011 = mean(`2011`),
                                                                                              total_payments_2012 = mean(`2012`),
                                                                                              total_payments_2013 = mean(`2013`),
                                                                                              total_payments_2014 = mean(`2014`),
                                                                                              total_payments_2015 = mean(`2015`),
                                                                                              avg_total_payments = mean(avg)) %>% arrange(-avg_total_payments)
write.csv(medical_dept_total_payments, file = "../../Data/Prepared/medical_dept_total_payments.csv", row.names=FALSE)
###################################################################################################
# Average Medicare Payments + DRG Category
###################################################################################################
medicare_payments <- medicare_payments %>% merge(drg_category, by = "drg") 

body_system_medicare_payments <- medicare_payments %>% group_by(body_system) %>% summarise( medicare_payments_2011 = mean(`2011`),
                                                                                            medicare_payments_2012 = mean(`2012`),
                                                                                            medicare_payments_2013 = mean(`2013`),
                                                                                            medicare_payments_2014 = mean(`2014`),
                                                                                            medicare_payments_2015 = mean(`2015`),
                                                                                            avg_medicare_payments = mean(avg)) %>% arrange(-avg_medicare_payments)

write.csv(body_system_medicare_payments, file = "../../Data/Prepared/body_system_medicare_payments.csv", row.names=FALSE)

medical_dept_medicare_payments <- medicare_payments %>% group_by(medical_department) %>% summarise( medicare_payments_2011 = mean(`2011`),
                                                                                                    medicare_payments_2012 = mean(`2012`),
                                                                                                    medicare_payments_2013 = mean(`2013`),
                                                                                                    medicare_payments_2014 = mean(`2014`),
                                                                                                    medicare_payments_2015 = mean(`2015`),
                                                                                                    avg_medicare_payments = mean(avg)) %>% arrange(-avg_medicare_payments)
write.csv(medical_dept_medicare_payments, file = "../../Data/Prepared/medical_dept_medicare_payments.csv", row.names=FALSE)