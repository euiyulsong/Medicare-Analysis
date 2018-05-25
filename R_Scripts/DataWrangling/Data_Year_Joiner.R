
# This script joins together all the DRG data for the years 2011, 2012, 2013, 2014, 2015 together
# To Make it Into One MASSIVE DATASET

# The dplyr library will be used to mutate columns and to join the various datasets

library(dplyr)

# Creating a dataframe for each year by reading the data from the csvs 
inpatients_2011<-read.csv("../../ProjectData/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis-Related_Groups__DRG__-_FY2011.csv")
inpatients_2012<-read.csv("../../ProjectData/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis-Related_Groups__DRG__-_FY2012.csv")
inpatients_2013<-read.csv("../../ProjectData/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis-Related_Groups__DRG__-_FY2013.csv")
inpatients_2014<-read.csv("../../ProjectData/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_All_Diagnosis-Related_Groups__DRG__-_FY2014.csv")
inpatients_2015<-read.csv("../../ProjectData/Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_All_Diagnosis-Related_Groups__DRG__-_FY2015.csv")

