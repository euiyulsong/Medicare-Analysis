# Data Critique
# Investigating to see the total number of DRGs we are analyzing and seeing the number of DRGs we have for 5 years

# setup
library(dplyr)

###############################################################################################

# All DRG Data for 2011 - 2015 

all_DRGdata <- read.csv("../../Data/Prepared/DRG_2011_2015.csv")
View(all_DRGdata)

# Finding all the unique rows in the DRG List to see the data we have 
rawDRG <- select(all_DRGdata, year, drg)

# removing duplicates
Unique_DRGs <- rawDRG[!duplicated(rawDRG), ]

# getting number of occurances of a DRG
DRG_For_Years <- Unique_DRGs %>% group_by(drg) %>% summarise(n =n())

# checking to see the DRGs which have occurred for all 5 years
DRG_For_Years_5 <- DRG_For_Years %>% filter( n == 5)
rownames(DRG_For_Years_5) <- 1:nrow(DRG_For_Years_5)
View(DRG_For_Years_5)

# Number of DRGs for 2011 - 100
DRG_2011 <- Unique_DRGs %>% filter(year == 2011)
n_DRG_2011 <-nrow(DRG_2011) 
n_DRG_2011

# Number of DRGs for 2012 - 100
DRG_2012 <- Unique_DRGs %>% filter(year == 2012)
n_DRG_2012 <-nrow(DRG_2012) 
n_DRG_2012

# Number of DRGs for 2013 - 100
DRG_2013 <- Unique_DRGs %>% filter(year == 2013)
n_DRG_2013 <-nrow(DRG_2013) 
n_DRG_2013

# Number of DRGs for 2014 - 564
DRG_2014 <- Unique_DRGs %>% filter(year == 2014)
n_DRG_2014 <-nrow(DRG_2014) 
n_DRG_2014

# Number of DRGs for 2015 - 563
DRG_2015 <- Unique_DRGs %>% filter(year == 2015)
n_DRG_2015 <-nrow(DRG_2015) 
n_DRG_2015

# No.of.DRGs.by.year - 2011, 2012, 2013 - 100, 2014 - 564, 2015 - 563 

###############################################################################################

# I am interested in investigating the DRG difference for 2011, 2012, 2013
DRG_11_13 <- Unique_DRGs %>% filter(year == 2011 | year == 2012 | year == 2013) %>% group_by(drg) %>% summarise(n =n())
View(DRG_11_13)

# I am interested in investigating the DRG difference for 2014, 2015
DRG_14_15 <- Unique_DRGs %>% filter(year == 2014 | year == 2015) %>% group_by(drg) %>% summarise(n =n())
View(DRG_14_15)

DRG_14_15_unique <- DRG_14_15 %>% filter(n==1)
View(DRG_14_15_unique)