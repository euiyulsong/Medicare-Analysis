# Data_Year_Joiner Script
# This script joins together all the DRG data for the years 2011, 2012, 2013, 2014, 2015 together
# To Make it Into One MASSIVE DATASET

# The dplyr library will be used to mutate columns and to join the various datasets

library(dplyr)
library(readr)
library(data.table)
library(stringr)

#-----------------------------------------------------------------------------------------------#
# Loading the DRG datasets for 2011,12,13,14,15                                                 #
#-----------------------------------------------------------------------------------------------#

# Creating a dataframe for each year by reading the data from the csvs 
inpatients_2011<-read.csv("../../Data/Raw/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis-Related_Groups__DRG__-_FY2011.csv")
inpatients_2012<-read.csv("../../Data/Raw/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis-Related_Groups__DRG__-_FY2012.csv")
inpatients_2013<-read.csv("../../Data/Raw/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis-Related_Groups__DRG__-_FY2013.csv")
inpatients_2014<-read.csv("../../Data/Raw/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_All_Diagnosis-Related_Groups__DRG__-_FY2014.csv")
inpatients_2015<-read.csv("../../Data/Raw/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_All_Diagnosis-Related_Groups__DRG__-_FY2015.csv")

# Adding a year column to each dataset 
inpatients_2011$Year = 2011
inpatients_2012$Year = 2012
inpatients_2013$Year = 2013
inpatients_2014$Year = 2014
inpatients_2015$Year = 2015

# Checking the colnames for all the datasets
colnames(inpatients_2011, do.NULL = TRUE, prefix = "col")
colnames(inpatients_2012, do.NULL = TRUE, prefix = "col")
colnames(inpatients_2013, do.NULL = TRUE, prefix = "col")
colnames(inpatients_2014, do.NULL = TRUE, prefix = "col")
colnames(inpatients_2015, do.NULL = TRUE, prefix = "col")

# Giving all the datasets the same column names as they have different column names

colnames(inpatients_2011) <- c("drg", "id", "provider", "address", "city", "state", "zipcode", "region", "discharges", "avg_covered_charges", "avg_total_payments", "avg_medicare_payments", "year")
colnames(inpatients_2012) <- c("drg", "id", "provider", "address", "city", "state", "zipcode", "region", "discharges", "avg_covered_charges", "avg_total_payments", "avg_medicare_payments", "year")
colnames(inpatients_2013) <- c("drg", "id", "provider", "address", "city", "state", "zipcode", "region", "discharges", "avg_covered_charges", "avg_total_payments", "avg_medicare_payments", "year")
colnames(inpatients_2014) <- c("drg", "id", "provider", "address", "city", "state", "zipcode", "region", "discharges", "avg_covered_charges", "avg_total_payments", "avg_medicare_payments", "year")
colnames(inpatients_2015) <- c("drg", "id", "provider", "address", "city", "state", "zipcode", "region", "discharges", "avg_covered_charges", "avg_total_payments", "avg_medicare_payments", "year")

# Checking for the datatypes for all the datasets 

str(inpatients_2011)
str(inpatients_2012)
str(inpatients_2013)
str(inpatients_2014)
str(inpatients_2015)

# Key Finding: There is a difference in the datatype b/w (2011,12,13) & (2014,15) - factor vs num - due to $ sign

# Removing the $ sign for 2011, 12, 13

# Removing the $ sign for 2011
inpatients_2011$avg_covered_charges<-parse_number(inpatients_2011$avg_covered_charges)
inpatients_2011$avg_total_payments<-parse_number(inpatients_2011$avg_total_payments)
inpatients_2011$avg_medicare_payments<-parse_number(inpatients_2011$avg_medicare_payments)

# Removing the $ sign for 2012
inpatients_2012$avg_covered_charges<-parse_number(inpatients_2012$avg_covered_charges)
inpatients_2012$avg_total_payments<-parse_number(inpatients_2012$avg_total_payments)
inpatients_2012$avg_medicare_payments<-parse_number(inpatients_2012$avg_medicare_payments)

# Removing the $ sign for 2013
inpatients_2013$avg_covered_charges<-parse_number(inpatients_2013$avg_covered_charges)
inpatients_2013$avg_total_payments<-parse_number(inpatients_2013$avg_total_payments)
inpatients_2013$avg_medicare_payments<-parse_number(inpatients_2013$avg_medicare_payments)

#-----------------------------------------------------------------------------------------------#
# Creating a dataset for the DRGs for 2011, 2012, 2013, 2014, 2015                              #
#-----------------------------------------------------------------------------------------------#

Drgs_2011_to_2015 <-  rbind (inpatients_2011, inpatients_2012, inpatients_2013, inpatients_2014, inpatients_2015)
View(Drgs_2011_to_2015)

#-----------------------------------------------------------------------------------------------#
# Creating a dataset for the top 100 DRGs for 2011, 2012, 2013                                  #
#-----------------------------------------------------------------------------------------------#

top_100_Drgs_2011_to_2013 <- rbind (inpatients_2011, inpatients_2012, inpatients_2013)
View(top_100_Drgs_2011_to_2013)

#-----------------------------------------------------------------------------------------------#
# Creating a dataset for the DRGs for 2014, 2015                                                #
#-----------------------------------------------------------------------------------------------#

All_Drgs_2014_to_2015 <- rbind (inpatients_2014, inpatients_2015)

#################################################################################################
#################################################################################################
#################################################################################################
#-----------------------------------------------------------------------------------------------#
# Creating a dataset for the DRGs for 2011, 2012, 2013, 2014, 2015                              #
# Data Invesitgation into updated drg names 
# Some DRGs have got updated names but have the same DRG number in the past 5 years for the same disease
# I am invesitgating this, by finding the DRG numbers which have been duplicated
#-----------------------------------------------------------------------------------------------#

drgs <- Drgs_2011_to_2015 %>% select(drg) %>% arrange(drg)
uniqdrg <- unique(drgs, incomparables = FALSE )
uniqdrg$drg <- substr(uniqdrg$drg, 0, 3)
uniqdrg <- uniqdrg %>% arrange(drg)
uniqdrg<- uniqdrg[uniqdrg$drg %in% uniqdrg$drg[duplicated(uniqdrg$drg)],]

# The following DRG numbers have got an updated number:

# 003 - ECMO OR TRACH W MV 96+ HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.
# 003 - ECMO OR TRACH W MV >96 HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.

# 065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC
# 065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC OR TPA IN 24 HRS

# 457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR 9+ FUS W CC
# 457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR EXT FUS W CC

# 870 - SEPTICEMIA OR SEVERE SEPSIS W MV 96+ HOURS
# 870 - SEPTICEMIA OR SEVERE SEPSIS W MV >96 HOURS

# 872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV 96+ HOURS W/O MCC
# 872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV >96 HOURS W/O MCC

# 927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV 96+ HRS W SKIN GRAFT
# 927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV >96 HRS W SKIN GRAFT

uniqdrg$drg <- replace(as.character(uniqdrg$drg), 
                      uniqdrg$drg == "003 - ECMO OR TRACH W MV 96+ HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.", 
                      "003 - ECMO OR TRACH W MV >96 HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.")

uniqdrg$drg <- replace(as.character(uniqdrg$drg), 
                       uniqdrg$drg == "065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC", 
                       "065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC OR TPA IN 24 HRS")

uniqdrg$drg <- replace(as.character(uniqdrg$drg), 
                       uniqdrg$drg == "457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR 9+ FUS W CC", 
                       "457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR EXT FUS W CC")

uniqdrg$drg <- replace(as.character(uniqdrg$drg), 
                       uniqdrg$drg == "870 - SEPTICEMIA OR SEVERE SEPSIS W MV 96+ HOURS", 
                       "870 - SEPTICEMIA OR SEVERE SEPSIS W MV >96 HOURS")

uniqdrg$drg <- replace(as.character(uniqdrg$drg), 
                       uniqdrg$drg == "872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV 96+ HOURS W/O MCC", 
                       "872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV >96 HOURS W/O MCC")

uniqdrg$drg <- replace(as.character(uniqdrg$drg), 
                       uniqdrg$drg == "927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV 96+ HRS W SKIN GRAFT", 
                       "927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV >96 HRS W SKIN GRAFT")


#################################################################################################
#################################################################################################
#################################################################################################
#-----------------------------------------------------------------------------------------------#
# Making the replacements for dataset for the DRGs for 2011, 2012, 2013, 2014, 2015             #
#-----------------------------------------------------------------------------------------------#

Drgs_2011_to_2015$drg <- replace(as.character(Drgs_2011_to_2015$drg), 
                                 Drgs_2011_to_2015$drg == "003 - ECMO OR TRACH W MV 96+ HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.", 
                                 "003 - ECMO OR TRACH W MV >96 HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.")

Drgs_2011_to_2015$drg <- replace(as.character(Drgs_2011_to_2015$drg), 
                                 Drgs_2011_to_2015$drg == "065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC", 
                                 "065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC OR TPA IN 24 HRS")

Drgs_2011_to_2015$drg <- replace(as.character(Drgs_2011_to_2015$drg), 
                                 Drgs_2011_to_2015$drg == "457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR 9+ FUS W CC", 
                                 "457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR EXT FUS W CC")

Drgs_2011_to_2015$drg <- replace(as.character(Drgs_2011_to_2015$drg), 
                                 Drgs_2011_to_2015$drg == "870 - SEPTICEMIA OR SEVERE SEPSIS W MV 96+ HOURS", 
                                 "870 - SEPTICEMIA OR SEVERE SEPSIS W MV >96 HOURS")

Drgs_2011_to_2015$drg <- replace(as.character(Drgs_2011_to_2015$drg), 
                                 Drgs_2011_to_2015$drg == "872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV 96+ HOURS W/O MCC", 
                                 "872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV >96 HOURS W/O MCC")

Drgs_2011_to_2015$drg <- replace(as.character(Drgs_2011_to_2015$drg), 
                                 Drgs_2011_to_2015$drg == "927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV 96+ HRS W SKIN GRAFT", 
                                 "927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV >96 HRS W SKIN GRAFT")


#-----------------------------------------------------------------------------------------------#
# Making the replacements for dataset for the DRGs for 2011, 2012, 2013                         #
#-----------------------------------------------------------------------------------------------#

top_100_Drgs_2011_to_2013$drg <- replace(as.character(top_100_Drgs_2011_to_2013$drg), 
                                         top_100_Drgs_2011_to_2013$drg == "003 - ECMO OR TRACH W MV 96+ HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.", 
                                         "003 - ECMO OR TRACH W MV >96 HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.")

top_100_Drgs_2011_to_2013$drg <- replace(as.character(top_100_Drgs_2011_to_2013$drg), 
                                         top_100_Drgs_2011_to_2013$drg == "065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC", 
                                         "065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC OR TPA IN 24 HRS")

top_100_Drgs_2011_to_2013$drg <- replace(as.character(top_100_Drgs_2011_to_2013$drg), 
                                         top_100_Drgs_2011_to_2013$drg == "457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR 9+ FUS W CC", 
                                         "457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR EXT FUS W CC")

top_100_Drgs_2011_to_2013$drg <- replace(as.character(top_100_Drgs_2011_to_2013$drg), 
                                         top_100_Drgs_2011_to_2013$drg == "870 - SEPTICEMIA OR SEVERE SEPSIS W MV 96+ HOURS", 
                                         "870 - SEPTICEMIA OR SEVERE SEPSIS W MV >96 HOURS")

top_100_Drgs_2011_to_2013$drg <- replace(as.character(top_100_Drgs_2011_to_2013$drg), 
                                         top_100_Drgs_2011_to_2013$drg == "872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV 96+ HOURS W/O MCC", 
                                         "872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV >96 HOURS W/O MCC")

top_100_Drgs_2011_to_2013$drg <- replace(as.character(top_100_Drgs_2011_to_2013$drg), 
                                         top_100_Drgs_2011_to_2013$drg == "927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV 96+ HRS W SKIN GRAFT", 
                                         "927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV >96 HRS W SKIN GRAFT")

#-----------------------------------------------------------------------------------------------#
# Making the replacements for dataset for the DRGs for 2014 - 2015                              #
#-----------------------------------------------------------------------------------------------#

All_Drgs_2014_to_2015$drg <- replace(as.character(All_Drgs_2014_to_2015$drg), 
                                     All_Drgs_2014_to_2015$drg == "003 - ECMO OR TRACH W MV 96+ HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.", 
                                     "003 - ECMO OR TRACH W MV >96 HRS OR PDX EXC FACE, MOUTH & NECK W MAJ O.R.")

All_Drgs_2014_to_2015$drg <- replace(as.character(All_Drgs_2014_to_2015$drg), 
                                     All_Drgs_2014_to_2015$drg == "065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC", 
                                     "065 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W CC OR TPA IN 24 HRS")

All_Drgs_2014_to_2015$drg <- replace(as.character(All_Drgs_2014_to_2015$drg), 
                                     All_Drgs_2014_to_2015$drg == "457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR 9+ FUS W CC", 
                                     "457 - SPINAL FUS EXC CERV W SPINAL CURV/MALIG/INFEC OR EXT FUS W CC")

All_Drgs_2014_to_2015$drg <- replace(as.character(All_Drgs_2014_to_2015$drg), 
                                     All_Drgs_2014_to_2015$drg == "870 - SEPTICEMIA OR SEVERE SEPSIS W MV 96+ HOURS", 
                                     "870 - SEPTICEMIA OR SEVERE SEPSIS W MV >96 HOURS")

All_Drgs_2014_to_2015$drg <- replace(as.character(All_Drgs_2014_to_2015$drg), 
                                     All_Drgs_2014_to_2015$drg == "872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV 96+ HOURS W/O MCC", 
                                     "872 - SEPTICEMIA OR SEVERE SEPSIS W/O MV >96 HOURS W/O MCC")

All_Drgs_2014_to_2015$drg <- replace(as.character(All_Drgs_2014_to_2015$drg), 
                                     All_Drgs_2014_to_2015$drg == "927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV 96+ HRS W SKIN GRAFT", 
                                     "927 - EXTENSIVE BURNS OR FULL THICKNESS BURNS W MV >96 HRS W SKIN GRAFT")

#################################################################################################
#################################################################################################
#################################################################################################
#-----------------------------------------------------------------------------------------------#
# Saving the dataset for the DRGs for 2014, 2015                                                #
#-----------------------------------------------------------------------------------------------#
write.csv(top_100_Drgs_2011_to_2013, file = "../../Data/Prepared/top100DRG_2011_2013.csv", row.names=FALSE)
write.csv(Drgs_2011_to_2015, file = "../../Data/Prepared/DRG_2011_2015.csv", row.names=FALSE)
write.csv(All_Drgs_2014_to_2015, file = "../../Data/Prepared/AllDRG_2014_2015.csv", row.names=FALSE)