# Question 3:
# Generating A Future Opportunity By Analyzing Employment Status


# Loading The Necessary Libraries
library(dplyr) # Using 'dplyr' Package For Data Transformation 
library("ggplot2") # Using 'ggplot2' Package For Data Visualization

setwd('C:/Users/Avi/Documents/Courses/CSC8631 - Data Management & Exploratory Data Analysis/Assginment/Project Template/src')


# Importing The Data
Idea = read.csv('../data/cyber-security-7_enrolments.csv')

head(Idea) # Checking whether The Data File Is Loaded Correctly

# Cleaning The Data By Removing 'Unknown' Field From The Column 'employment_status'
Clean_Data <- Idea[Idea$employment_status != "Unknown",] 

# Counting The Frequency Of The Reasons 
(Total = as.data.frame(table(Clean_Data$employment_status)))

# Counting The Total Frequency For Both Sets
sum(Total$Freq)





# <---- Checking The Data Validity --------------------------------------------->

# Importing Two Data Sets
Idea_Data_2 = read.csv('../data/cyber-security-6_enrolments.csv')

Idea_Data_3 = read.csv('../data/cyber-security-5_enrolments.csv')

# Checking whether The Data File Is Loaded Correctly
head(Idea_Data_2) 

head(Idea_Data_3)

# Cleaning The Data By Removing 'Unknown' Field From The Column 'employment_status' In Both Data Sets
Clean_Data_2 <- Idea_Data_2[Idea_Data_2$employment_status != "Unknown",] 

Clean_Data_3 <- Idea_Data_3[Idea_Data_3$employment_status != "Unknown",]

# Counting The Frequency Of The Profession Of Both Sets 
(Total_1 = as.data.frame(table(Clean_Data_2$employment_status)))

(Total_2 = as.data.frame(table(Clean_Data_3$employment_status)))

# Counting The Total Frequency For Both Sets
sum(Total_1$Freq)

sum(Total_2$Freq)

# ******************************************************************************