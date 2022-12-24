# Importing Libraries

library("ggplot2") # Importing "ggplot2" Library
library("dplyr") # Importing "dplyr" Library
library("stringr") # Importing "stringr" Library
library("ggpubr") # Importing "ggpubr" Library

# ***********************************************************************************************************************************************************************************************#

# Changing Directories

print(getwd()) # Printing Current Working Directory
setwd('C:/Users/Avi/Documents/Courses/CSC8633 - Group Project/Datasets') # Changing Directory
print(getwd()) # Printing Changed Directory

# ***********************************************************************************************************************************************************************************************#

# Importing Datasets

id <- read.csv("studentRegistration.csv") # Importing 'studentRegistration' Dataset
print(id) # Printing Data

asses <- read.csv("assessments.csv") # Importing 'courses' Dataset
print(courses) # Printing Data

courses <- read.csv("courses.csv") # Importing 'studentInfo' Dataset
print(courses) # Printing Data

clicks <- read.csv("studentVle.csv") # Importing 'studentVle' Dataset
print(clicks) # Printing Data

student <- read.csv("studentInfo.csv") # Importing 'vle' Dataset
print(student) # Printing Data

vle <- read.csv("vle.csv") # Importing 'vle' Dataset
print(vle) # Printing Data

# ***********************************************************************************************************************************************************************************************#

# Data Pre-Processing

grouped_clicks <- clicks %>%
  group_by(code_module, code_presentation, id_student, id_site) %>%
  summarise_each(funs(sum(sum_click))) # Grouping 'clicks' to Summarize Total Clicks Per Student

course_id <- merge(asses, id, by = c("code_module", "code_presentation")) # Merging 'asses' & 'id'

course_info <- merge(courses, course_id, by = c("code_module", "code_presentation"))# Merging 'courses' & 'course_id'

course_info["course"] <- data.frame(str_c(course_info$code_module, "_", course_info$code_presentation)) # Adding a New Column

clicks_info <- merge(course_info, grouped_clicks, by = c("code_module", "code_presentation", "date", "id_student")) # Merging 'course_info' & 'grouped_clicks' 

student_info <- merge(clicks_info, student, by = c("code_module", "code_presentation", "id_student")) # Merging 'clicks_info' & 'student' 

#----------------------- Number of Attempts ------------------------------------#

filtered_attemp <- student_info  %>% filter(final_result == "Pass" | final_result == "Fail") # Extracting Passed & Failed Student Data
filtered_attemp_z <- filtered_attemp  %>% filter(num_of_prev_attempts == 0) # Extracting Data where Attempt = 0
filtered_attemp_z <- data.frame(filtered_attemp_z[, c(13,19,22)])# Extracting 'sum_click', 'num_of_attempts' & 'final_result'

pass <- filtered_attemp  %>% filter(final_result == "Pass") # Extracting "pass" Students Data
fail <- filtered_attemp  %>% filter(final_result == "Fail") # Extracting "fail" Students Data

filtered_pf <- filtered_attemp %>% filter(num_of_prev_attempts > 0) # Extracting Data of Students who has Attempts
filtered_pf <- data.frame(filtered_pf[, c(13,19,22)]) # Extracting 'sum_click', 'num_of_attempts' & 'final_result'

grouped_att_no <- filtered_attemp_z %>%
  group_by(final_result, num_of_prev_attempts) %>%
  summarise_each(funs(sum(sum_click))) # Grouping According to the Result (0 Attempts)

grouped_att <- filtered_pf %>%
  group_by(final_result) %>%
  summarise_all(funs(sum)) # Grouping According to the Result (More than 0 Attempts)

att_no <- data.frame(grouped_att_no$sum_click) # Extracting "sum_click" Values (Disabled Students)
grouped_att_no["percent"] <- (att_no / sum(att_no))* 100 # Calculating Percentage

att <- data.frame(grouped_att$sum_click) # Extracting "sum_click" Values (Non Disabled Students)
grouped_att["percent"] <- (att / sum(att))* 100 # Calculating Percentage

#----------------------- Disability --------------------------------------------#

filtered_non_dis <- student_info %>% filter(disability == "N") # Non-Disabled Students
filtered_dis <- student_info %>% filter(disability == "Y") # Disabled Students

grouped_percent <- filtered_dis %>%
  group_by(final_result) %>%
  summarise_each(funs(sum(sum_click))) # Grouping According to the Result (Disabled Students)

grouped_percent_non <- filtered_non_dis %>%
  group_by(final_result) %>%
  summarise_each(funs(sum(sum_click))) # Grouping According to the Result (Non Disabled Students)

click_dis <- data.frame(grouped_percent$sum_click) # Extracting "sum_click" Values (Disabled Students)
grouped_percent["percent"] <- (click_dis / sum(click_dis))* 100 # Calculating Percentage

click_non_dis <- data.frame(grouped_percent_non$sum_click) # Extracting "sum_click" Values (Non Disabled Students)
grouped_percent_non["percent"] <- (click_non_dis / sum(click_non_dis))* 100 # Calculating Percentage

# ***********************************************************************************************************************************************************************************************#

# Exploratory Data Analysis

#----------------------- Number of Attempts ------------------------------------# 
 
                     # ---- Bar Plots ---- #
  
ggplot(data = filtered_attemp, aes(x =  num_of_prev_attempts, fill = final_result)) + 
  geom_bar() + labs(title = "Number of Attempts", x = "Attempts", y = "Number of Students") +
  theme(axis.text.x = element_text(angle = 90)) # Plot to Display the Number of Attempts

table(pass$num_of_prev_attempts) # Displaying the Number of Students who Passed and their Number of Attempts

table(fail$num_of_prev_attempts) # Displaying the Number of Students who Failed and their Number of Attempts

                    # ---- Pie Chart ---- #

# No Attempts

slices <- grouped_att_no$percent # Slice Percentage
lbls <- grouped_att_no$final_result # Slice Labels
lbls <- paste(round(slices, 2)) # Rounding Off the Percentage Values
lbls <- paste(lbls,"%",sep="") # Displaying Percentage Number


# Attempts

slices_att <- grouped_att$percent # Slice Percentage
lbls_att <- grouped_att$final_result # Slice Labels
lbls_att <- paste(round(slices_att, 2)) # Rounding Off the Percentage Values
lbls_att <- paste(lbls_att,"%",sep="") # Displaying Percentage Number

par(mfrow = c(1, 2))  # Setting the Plotting Area

pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="No Attempts", radius = 1) # Pie Chart for Clicks Per-Centage for No Attempts

pie(slices_att,labels = lbls_att, col=rainbow(length(lbls_att)),
    main="Attempts", radius = 1) # Pie Chart for Clicks Per-Centage for Attempts 

legend("bottomright", c("Fail", "Pass"), fill = rainbow(length(lbls_att)), cex = 0.8) # Pie Chart Legend

#----------------------- Disability --------------------------------------------#

                  # ---- Bar Plots ---- #

ggplot(data = student_info,aes(x =  course, fill = disability)) + 
  geom_bar() + labs(title = "Student in Each Course", x = "Course", y = "Number of Students") +
   theme(axis.text.x = element_text(angle = 90))  # Plot to Display the Number of Disabled Students in Each Course

table(student_info$disability) # Displaying the Number of Disabled & Non-Disabled

ggplot(data = student_info,aes(x =  final_result, fill = disability)) + 
  geom_bar() + labs(title = "Results", x = "Course", y = "Number of Students") +
   theme(axis.text.x = element_text(angle = 90)) # Plot to Display the Results of Students


ggplot(data = student_info, mapping = aes(x =  course, y = sum_click, fill = disability)) + 
  geom_bar(stat = "identity") + labs(title = "Interaction of Disabled & Non Disabled Students in Each Course", 
  x = "Course", y = "Total Click Per Student")+ theme(axis.text.x = element_text(angle = 90)) # Interaction of Students

ggplot(data = filtered_dis, mapping = aes(x =  course, y = sum_click)) + 
  geom_bar(stat = "identity", fill = "lightblue") + labs(title = "Interaction of Disabled & Non Disabled Students in Each Course", 
                                     x = "Course", y = "Total Click Per Student")+ theme(axis.text.x = element_text(angle = 90)) # Interaction of Disabled Students

                 # ---- Pie Chart ---- #

# Disabled Students

slices_dis <- grouped_percent$percent # Slice Percentage
lbls_dis <- grouped_percent$final_result # Slice Labels
lbls_dis <- paste(round(slices_dis, 2)) # Rounding Off the Percentage Values
lbls_dis <- paste(lbls_dis,"%",sep="") # Displaying Percentage Number

# Non Disabled Students

slices_non <- grouped_percent_non$percent # Slice Percentage
lbls_non <- grouped_percent_non$final_result # Slice Labels
lbls_non <- paste(round(slices_non, 2)) # Rounding Off the Percentage Values
lbls_non <- paste(lbls_non,"%",sep="") # Displaying Percentage Number

par(mfrow = c(1, 2))  # Setting the Plotting Area


pie(slices_dis,labels = lbls_dis, col=rainbow(length(lbls_dis)),
    main="Disabled", radius = 0.8)# Pie Chart for Disabled Students

pie(slices_non,labels = lbls_non, col=rainbow(length(lbls_non)),
    main="Non-Disabled", radius = 0.8) # Pie Chart for Non Disabled Students 

legend("bottomright", c("Distinction", "Pass", "Fail", "Withdrawn"), fill = rainbow(length(lbls_dis)), cex = 0.8) # Pie Chart Legend

# ***********************************************************************************************************************************************************************************************#

# Statistical Analysis

#----------------------- Number of Attempts ------------------------------------# 

group_1_fail <- grouped_att_no %>% filter(final_result == 'Fail') # No Attempt
group_2_fail <- grouped_att %>% filter(final_result == 'Fail') # Attempts

group_1_pass <- grouped_att_no %>% filter(final_result == 'Pass') # No Attempt
group_2_pass <- grouped_att %>% filter(final_result == 'Pass') # Attempts

f <- c(group_1_fail$percent, group_2_fail$percent) # Extracting Percentage
t.test(f) # Fail

p <- c(group_2_pass$percent, group_1_pass$percent)
t.test(p) # Pass

#----------------------- Disability --------------------------------------------#

group_1_dis <- grouped_percent %>% filter(final_result == 'Distinction') # Disabled
group_2_dis <- grouped_percent_non  %>% filter(final_result == 'Distinction') # Non Disabled

group_1_p <- grouped_percent %>% filter(final_result == 'Pass') # Disabled
group_2_p <- grouped_percent_non  %>% filter(final_result == 'Pass') # Non Disabled

group_1_f <- grouped_percent %>% filter(final_result == 'Fail') # Disabled
group_2_f <- grouped_percent_non  %>% filter(final_result == 'Fail') # Non Disabled

group_1_with <- grouped_percent %>% filter(final_result == 'Withdrawn') # Disabled
group_2_with <- grouped_percent_non  %>% filter(final_result == 'Withdrawn') # Non Disabled

dis_distinct <- c(group_1_dis$percent, group_2_dis$percent) # Extracting Percentage
t.test(dis_distinct) # Distinction

dis_pass <- c(group_1_p$percent, group_2_p$percent) # Extracting Percentage
t.test(dis_pass) # Pass

dis_fail <- c(group_1_f$percent, group_2_f$percent) # Extracting Percentage
t.test(dis_fail) # Fail

dis_with <- c(group_1_with$percent, group_2_with$percent) # Extracting Percentage
t.test(dis_with) # Withdrawn

# ***********************************************************************************************************************************************************************************************#