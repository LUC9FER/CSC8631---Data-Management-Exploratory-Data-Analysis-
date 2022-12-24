# Question 1:
# Purpose of the users at future learn


# Loading The Necessary Libraries
library(dplyr) # Using 'dplyr' Package For Data Transformation 

library(ggplot2)# Using 'ggplot2' Package For Data Visualization


# Setting The Path Of Current Directory To Import Data Sets
setwd('C:/Users/Avi/Documents/Courses/CSC8631 - Data Management & Exploratory Data Analysis/Assginment/Project Template/src')

# Importing The Data
Purpose = read.csv('../data/cyber-security-7_archetype-survey-responses.csv')

head(Purpose) # Checking Whether The Data File Is loaded Correctly

# Counting The Frequency Of Each Arch Type  
(Total = as.data.frame(table(Purpose$archetype)))

# Counting The Total Frequency F
sum(Purpose$Freq)


# <---- Checking The Data Validity --------------------------------------------->

# Importing Two Data Sets
Data_Set_1 = read.csv('../data/cyber-security-5_archetype-survey-responses.csv')

Data_Set_2 = read.csv('../data/cyber-security-6_archetype-survey-responses.csv')

# Checking Whether The Data File Is loaded Correctly
head(Data_Set_1)

head(Data_Set_2)

# Counting The Frequency Of Each Arch Type For Both Data Sets 
(Total_1 = as.data.frame(table(Data_Set_1$archetype)))

(Total_2 = as.data.frame(table(Data_Set_2$archetype)))

# Counting The Total Frequency For Both Sets
sum(Total_1$Freq)

sum(Total_2$Freq)

# Counting The Frequency Of Each Arch Type 
(Total = as.data.frame(table(Purpose$archetype)))

# Counting The Total Frequency
sum(Total$Freq)

# ******************************************************************************`