#####################################
# Submitted by: Shubham S. Nandanwar
# Student ID: 205833000
# Course: GG-606-A - Scientific Data Wrangling
#####################################

# Importing libraries
library(dplyr)
library(readr)
library(ggplot2)
library(dplyr)
library(plotly)
library(hrbrthemes)
library(lubridate)

# set strings as factors to false
options(stringsAsFactors = FALSE)

# Creating working directory
mainDir <- "D:/GG606_D1/Data/"
CleanDir <- "Clean_Data"
####### CLEANING & CORRECTING ########
# merging multiple csv files to one for cleaning the data  
multmerge = function(path){
  filenames=list.files(path=path, full.names=TRUE)
  print(filenames)
  rbindlist(lapply(filenames, fread))
}

# folder path where all the raw data exists
path <- paste(mainDir,CleanDir,sep = "",collapse = NULL)
# Calling multimerge function and storing data in DF 
DF <- multmerge(path)

DF <- DF %>% 
  rename(
    "NO2 Mean (Parts per Million)" = "NO2 Mean",
    "SO2 Mean (Parts per Million)" = "SO2 Mean",
    "O3 Mean (Parts per Billion)" = "O3 Mean",
    "CO Mean (Parts per Billion)" = "CO Mean"
  )

# To improve the presentation via graph, I am now splitting US based on divisions defined by US Census Bureau (Info link: https://www.mapsofworld.com/usa/usa-maps/united-states-regional-maps.html)
list_NewEngland <- list("Maine","New Hampshire", "Vermont", "Massachusetts", "Rhode Island", "Connecticut")
list_MiddleAtlantic <- list("New York","Pennsylvania", "New Jersey")
list_EastNorthCentral <- list("Wisconsin","Michigan", "Illinois", "Indiana", "Ohio")
list_WestNorthCentral <- list("North Dakota","South Dakota", "Nebraska", "Kansas", "Minnesota", "Iowa")
list_SouthAtlantic <- list("Delaware","Maryland", "District of Columbia", "Virginia", "West Virginia", "North Carolina", "South Carolina", "Georgia", "Florida")
list_EastSouthCentral <- list("Kentucky","Tennessee", "Mississippi", "Alabama")
list_WestSouthCentral <- list("Oklahoma","Texas", "Arkansas", "Louisiana")
list_Mountain <- list("Idaho","Montana", "Wyoming", "Nevada", "Utah", "Colorado", "Arizona", "New Mexico")
list_Pacific <- list("Alaska","Washington", "Oregon", "California", "Hawaii")

NewEngland_df <- DF[DF$State %in% list_NewEngland, ]
MiddleAtlantic_df <- DF[DF$State %in% list_MiddleAtlantic, ]
EastNorthCentral_df <- DF[DF$State %in% list_EastNorthCentral, ]
WestNorthCentral_df <- DF[DF$State %in% list_WestNorthCentral, ]
SouthAtlantic_df <- DF[DF$State %in% list_SouthAtlantic, ]
EastSouthCentral_df <- DF[DF$State %in% list_EastSouthCentral, ]
WestSouthCentral_df <- DF[DF$State %in% list_WestSouthCentral, ]
Mountain_df <- DF[DF$State %in% list_Mountain, ]
Pacific_df <- DF[DF$State %in% list_Pacific, ]



# Creating directory for NewEngland region in Results folder
Results_NewEngland = "Results/NewEngland"
dir.create(file.path(mainDir, Results_NewEngland), showWarnings = FALSE)

# Multiple of all states line plot
p<-ggplot(NewEngland_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_NewEngland,"/NewEngland_NO2_main_plot.png",sep=""),
  plot = p,device = "png")


p<-ggplot(NewEngland_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_NewEngland,"/NewEngland_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p<-ggplot(NewEngland_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_NewEngland,"/NewEngland_SO2_main_plot.png",sep=""),
  plot = p,device = "png")

p<-ggplot(NewEngland_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_NewEngland,"/NewEngland_CO_main_plot.png",sep=""),
  plot = p,device = "png")



# Creating directory for MiddleAtlantic region in Results folder
Results_MiddleAtlantic = "Results/MiddleAtlantic"
dir.create(file.path(mainDir, Results_MiddleAtlantic), showWarnings = FALSE)

# Multiple of all states line plot
p <- ggplot(MiddleAtlantic_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_MiddleAtlantic,"/MiddleAtlantic_NO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(MiddleAtlantic_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_MiddleAtlantic,"/MiddleAtlantic_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(MiddleAtlantic_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_MiddleAtlantic,"/MiddleAtlantic_S02_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(MiddleAtlantic_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_MiddleAtlantic,"/MiddleAtlantic_CO_main_plot.png",sep=""),
  plot = p,device = "png")



# Creating directory for EastNorthCentral region in Results folder
Results_EastNorthCentral = "Results/EastNorthCentral"
dir.create(file.path(mainDir, Results_EastNorthCentral), showWarnings = FALSE)

# Multiple of all states line plot
p <- ggplot(EastNorthCentral_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_EastNorthCentral,"/EastNorthCentral_NO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(EastNorthCentral_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_EastNorthCentral,"/EastNorthCentral_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(EastNorthCentral_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_EastNorthCentral,"/EastNorthCentral_SO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(EastNorthCentral_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_EastNorthCentral,"/EastNorthCentral_CO_main_plot.png",sep=""),
  plot = p,device = "png")



# Creating directory for WestNorthCentral region in Results folder
Results_WestNorthCentral = "Results/WestNorthCentral"
dir.create(file.path(mainDir, Results_WestNorthCentral), showWarnings = FALSE)
# Multiple of all states line plot
p <- ggplot(WestNorthCentral_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_WestNorthCentral,"/WestNorthCentral_NO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(WestNorthCentral_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_WestNorthCentral,"/WestNorthCentral_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(WestNorthCentral_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_WestNorthCentral,"/WestNorthCentral_SO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(WestNorthCentral_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_WestNorthCentral,"/WestNorthCentral_CO_main_plot.png",sep=""),
  plot = p,device = "png")



# Creating directory for SouthAtlantic region in Results folder
Results_SouthAtlantic = "Results/SouthAtlantic"
dir.create(file.path(mainDir, Results_SouthAtlantic), showWarnings = FALSE)
# Multiple of all states line plot
p <- ggplot(SouthAtlantic_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_SouthAtlantic,"/SouthAtlantic_NO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(SouthAtlantic_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_SouthAtlantic,"/SouthAtlantic_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(SouthAtlantic_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_SouthAtlantic,"/SouthAtlantic_SO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(SouthAtlantic_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_SouthAtlantic,"/SouthAtlantic_CO_main_plot.png",sep=""),
  plot = p,device = "png")



# Creating directory for EastSouthCentral region in Results folder
Results_EastSouthCentral = "Results/EastSouthCentral"
dir.create(file.path(mainDir, Results_EastSouthCentral), showWarnings = FALSE)
# Multiple of all states line plot
p <- ggplot(EastSouthCentral_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_EastSouthCentral,"/EastSouthCentral_NO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(EastSouthCentral_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_EastSouthCentral,"/EastSouthCentral_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(EastSouthCentral_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_EastSouthCentral,"/EastSouthCentral_SO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(EastSouthCentral_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_EastSouthCentral,"/EastSouthCentral_CO_main_plot.png",sep=""),
  plot = p,device = "png")


# Creating directory for WestSouthCentral region in Results folder
Results_WestSouthCentral = "Results/WestSouthCentral"
dir.create(file.path(mainDir, Results_WestSouthCentral), showWarnings = FALSE)
# Multiple of all states line plot
p <- ggplot(WestSouthCentral_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_WestSouthCentral,"/WestSouthCentral_NO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(WestSouthCentral_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_WestSouthCentral,"/WestSouthCentral_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(WestSouthCentral_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_WestSouthCentral,"/WestSouthCentral_SO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(WestSouthCentral_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_WestSouthCentral,"/WestSouthCentral_CO_main_plot.png",sep=""),
  plot = p,device = "png")



# Creating directory for Mountain region in Results folder
Results_Mountain = "Results/Mountain"
dir.create(file.path(mainDir, Results_Mountain), showWarnings = FALSE)
# Multiple of all states line plot
p <- ggplot(Mountain_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_Mountain,"/Mountain_NO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(Mountain_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_Mountain,"/Mountain_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(Mountain_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_Mountain,"/Mountain_SO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(Mountain_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_Mountain,"/Mountain_CO_main_plot.png",sep=""),
  plot = p,device = "png")



# Creating directory for Pacific region in Results folder 
Results_Pacific = "Results/Pacific"
dir.create(file.path(mainDir, Results_Pacific), showWarnings = FALSE)
# Multiple of all states line plot
p <- ggplot(Pacific_df, aes(x = Month_Yr, y =`NO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_Pacific,"/Pacific_NO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(Pacific_df, aes(x = Month_Yr, y =`O3 Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_Pacific,"/Pacific_O3_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(Pacific_df, aes(x = Month_Yr, y =`SO2 Mean (Parts per Million)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_Pacific,"/Pacific_SO2_main_plot.png",sep=""),
  plot = p,device = "png")

p <- ggplot(Pacific_df, aes(x = Month_Yr, y =`CO Mean (Parts per Billion)`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()
ggsave(
  paste(mainDir,Results_Pacific,"/Pacific_CO_main_plot.png",sep=""),
  plot = p,device = "png")

