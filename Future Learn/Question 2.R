# Question 2
# Why Users Are Leaving The Course Early


# Loading The Necessary Libraries
library(dplyr) # Using 'dplyr' Package For Data Transformation 

library("ggplot2")

# Setting The Path Of Current Directory To Import Data Sets
setwd('C:/Users/Avi/Documents/Courses/CSC8631 - Data Management & Exploratory Data Analysis/Assginment/Project Template/src')


# Importing The Data Set
Reason = read.csv('../data/cyber-security-7_leaving-survey-responses.csv')

head(Reason) # Checking Whether The Data File Is loaded Correctly

# Counting The Frequency Of The Reasons 
(Total = as.data.frame(table(Reason$leaving_reason)))

# Counting The Total Frequency For Both Sets
sum(Total$Freq)


# <---- Checking The Data Validity --------------------------------------------->

# Importing Another Data Set For Validation
Data = read.csv('../data/cyber-security-6_leaving-survey-responses.csv')

# Checking Whether The Data File Is loaded Correctly
head(Data)

# Counting The Frequency Of Each Arch Type For Both Data Sets 
(Total_1 = as.data.frame(table(Data$leaving_reason)))

# Counting The Total Frequency For Both Sets
sum(Total_1$Freq)


# ******************************************************************************