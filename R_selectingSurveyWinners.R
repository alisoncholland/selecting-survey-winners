# Install and load necessary packages

install.packages("readxl")

library("readxl")


# Set working directory to where the email file is stored on your computer and load the xls file in R

getwd()
#setwd("/Users/alison/Downloads")
setwd("/Users/alison/R_scripts")

emails_complete <- read_excel("230323_survey_prepForExams_UKpilot_users_emails.xlsx")


# How many winners for this survey?

n=5 

# Select the specified number of winners randomly

winners <- sample(emails_complete$emails,n,replace=FALSE)

# Save winners' emails in a csv file (will be saved in the same directory you specified above)

write.csv(winners, file ="winners.csv", row.names=FALSE)

# Save losers' emails in a csv file

emails_complete$match = vapply(emails_complete$emails, function(x) any(grepl(x, winners)), 1L)

losers <- subset(emails_complete, match==0)

write.csv(losers$emails, file ="losers.csv", row.names=FALSE)
