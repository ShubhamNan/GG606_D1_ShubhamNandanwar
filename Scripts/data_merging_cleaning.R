library(dplyr)
library(readr)
library(data.table)
library(qwraps2)

mainDir <- "D:/GG606_D1/Data/"
rawDir <- "Raw data/US_pollution_2000_2016/"
###### CLEANING ########
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

# taking mean to convert 4 rows into 1
str(DF)
Mean_DF <- aggregate(DF[, 10:29], list(DF$Date,DF$State), mean)
# Changing name of grouped Columns to Date and State. 
Mean_DF <- Mean_DF %>% 
  rename(
    "Date" = "Group.1",
    "State" = "Group.2"
  )

#Checking data summary 
str(Mean_DF)

# Removing as they are NA Units here after aggregation
# We will extract Units from main Data Frame 
drop <- c("NO2 Units","O3 Units","SO2 Units","CO Units")
Cleaned_df = Mean_DF[,!(names(Mean_DF) %in% drop)]

# Adding Clean Data Directory to our repository 
cleanDir <- "Clean_Data"
dir.create(file.path(mainDir, cleanDir), showWarnings = FALSE)

#splitting the data by State and crating multiple dataset for better insights
split_pollution_df <- split(Cleaned_df, Cleaned_df$State)

#saving the split data
lapply(names(Cleaned_df), function(x){
  write_csv(Cleaned_df[[x]], path = paste(mainDir,cleanDir,"/",x, ".csv", sep = ""))
})
