install.packages("ProjectTemplate") # Installing Project Template Library

library(ProjectTemplate) # Loading The Library       

# Location To Store The Project Template    
setwd("C:/Users/Avi/Documents/Courses/CSC8631 - Data Management & Exploratory Data Analysis/Assginment")

# Creating The Project Directory
create.project("Project Template")

setwd("Project Template/Reports") # Location For The Report

tinytex::install_tinytex() # To Open PDF Document Using R-Mark Down
