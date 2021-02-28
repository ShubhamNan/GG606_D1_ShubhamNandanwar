#####################################
# Submitted by: Shubham S. Nandanwar
# Student ID: 205833000
# Course: GG-606-A - Scientific Data Wrangling
#####################################

# Importing library
library(dplyr)
library(readr)
library(data.table)
library(qwraps2)

# Creating working directory
mainDir <- "D:/GG606_D1/Data/"
rawDir <- "Raw data/US_pollution_2000_2016/"
####### CLEANING & CORRECTING ########
# merging multiple csv files to one for cleaning the data  
multmerge = function(path){
  filenames=list.files(path=path, full.names=TRUE)
  print(filenames)
  rbindlist(lapply(filenames, fread))
}

# folder path where all the raw data exists
path <- paste(mainDir,rawDir,sep = "",collapse = NULL)
# Calling multimerge function and storing data in DF 
DF <- multmerge(path)

# Summary of the data.frame
str(DF)

# Converting all NA to 0
DF[is.na(DF)] <- 0

# checking DF
DF

# renaming column "Date Local" to "Date"
DF <- DF %>% 
  rename(
    "Date" = "Date Local"
  )

# Creating Month-Year and Year columns
DF$Month_Yr <- format(as.Date(DF$Date), "%Y-%m")
DF$Year <- format(as.Date(DF$Date),"%Y")

str(DF)
# taking mean to convert 4 rows into 1
Mean_DF <- aggregate(DF[, 10:29], list(DF$Month_Yr,DF$State,DF$Year), mean)
str(DF)
# Changing name of grouped Columns to Date and State. 
Mean_DF <- Mean_DF %>% 
  rename(
    "Month_Yr" = "Group.1",
    "State" = "Group.2",
    "Year" = "Group.3"
  )

#Checking data summary 
str(Mean_DF)

# Removing as they are NA Units here after aggregation
# We will extract Units from main Data Frame 
drop <- c("NO2 Units","O3 Units","SO2 Units","CO Units")
Cleaned_df = Mean_DF[,!(names(Mean_DF) %in% drop)]

######## GENERATING & SAVING CLEAN DATA #########
# Adding Clean Data Directory to our repository 
cleanDir <- "Clean_Data"
dir.create(file.path(mainDir, cleanDir), showWarnings = FALSE)


#splitting the data by State and crating multiple dataset for better insights
split_clean_df <- split(Cleaned_df, Cleaned_df$State)


#saving the split data
lapply(names(split_clean_df), function(x){
  write_csv(split_clean_df[[x]], path = paste(mainDir,cleanDir,"/",x, ".csv", sep = ""))
})
