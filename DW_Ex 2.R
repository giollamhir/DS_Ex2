#load libraries
library(tidyr)
library(dplyr)


#Step 0 Load 
dat <- read.csv("titanic_original.csv", na.strings = "")


# Step 1: Port of embarkation
# Embarked column missing values are known to correspond to passengers who actually embarked at Southampton. 
# Find the missing values and replace them with S.
dat$embarked[which(is.na(dat$embarked))] <- "S"


# Step 2: Age
# values in the Age column are missing. 
# While there are many ways to fill these missing values, using the mean or median of the rest of the values is quite common in such cases.
# Calculate the mean of the Age column and use that value to populate the missing values
avgAge <- round(mean(dat$age, na.rm = TRUE), digits = 1)
dat$age[which(is.na(dat$age))]<- avgAge

# 2a. Think about other ways you could have populated the missing values in the age column. Why would you pick any of those over the mean (or not)?



# Step 3: Lifeboat
# You’re interested in looking at the distribution of passengers in different lifeboats, but as we know, many passengers did not make it to a boat 
# This means that there are a lot of missing values in the boat column. 
# Fill these empty slots with a dummy value e.g. the string 'None' or 'NA'
# DONE - This was done in the CSV file reading setting. 


#Step 4: Cabin
# Many passengers don’t have a cabin number associated with them.
# Does it make sense to fill missing cabin numbers with a value? What does a missing value here mean?
# You have a hunch that the fact that the cabin number is missing might be a useful indicator of survival. 
# Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.

#(dat$has_cabin_number <- ifelse(dat$cabin == "", 1, 0))
#played with testing for NUll but couldn't get it to work so changed the way teh CSV reads in. 

dat$has_cabin_number <- ifelse(is.na(dat$cabin), 0, 1)
# took a while to figure out NA can't be handled as a string but you have to call the function



#NOTE There is no step 5. in the instructions 


#Step 6: Submit the project on Github. Include:
# your code, the original data as a CSV file titanic_original.csv, & the cleaned up data as a CSV file called titanic_clean.csv.
write.csv(dat, file = "titanic_clean.csv")
