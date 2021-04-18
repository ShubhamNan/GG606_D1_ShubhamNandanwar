#####################################
# Submitted by: Shubham S. Nandanwar
# Student ID: 205833000
# Course: GG-606-A - Scientific Data Wrangling
#####################################

install.packages("lubridate")

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
mainDir <- "D:/GG606/Data/"
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


######### Creating plot and tables for Middle Atlantic division and New England division ############
# Line plot of all states in Middle Atlantic division
p<-ggplot(MiddleAtlantic_df, aes(x = Year, y =`NO2 Mean (Parts per Million)`, group = State)) +
  geom_line(aes(color = State)) +
  labs(title="NO2 Emission in MiddleAtlantic from 2013-2016",x="Year", y = "NO2 (Parts per Million)") +
  theme_apa(
    legend.pos = "right",
    legend.use.title = FALSE,
    legend.font.size = 12,
    x.font.size = 12,
    y.font.size = 12,
    facet.title.size = 12,
    remove.y.gridlines = TRUE,
    remove.x.gridlines = TRUE
  )
ggsave(
  paste(mainDir,Plots_D3,"/MiddleAtlantic_NO2_main_plot.tiff",sep=""),
  plot = p,device = "tiff")

# Creating correlation table for NewEngland dataframe in APA style and exporting it as .doc file
apa.cor.table(NewEngland_df,filename = "D:/GG606_D1/Data/Results/Tables_D3/Example1.doc",table.number = 1,show.conf.interval = F)

# Creating a table of ANOVA using apa table and exporting in word
apa.aov.table(lm(`NO2 Mean (Parts per Million)`~State,NewEngland_df),filename = "D:/GG606_D1/Data/Results/Tables_D3/Example4.doc",table.number = 1)



###### Creating Insights of only single state of USA: Alabama ######
# Creating a DF for Alabama
alabama_df <- read.csv(file = 'D:/GG606_D1/Data/Clean_Data_D3/Alabama.csv')
# Taking aggregate of the whole year for each pollutant
# creating subset of alabama based on year of pollution record
alabama_agg = aggregate(alabama_df,
                        by = list(alabama_df$Year),
                        FUN = mean)
# checking the aggregation result
alabama_agg
# Removing three extra columns from the DF
alabama_agg_df = subset(alabama_agg, select = -c(Month_Yr,State,Group.1) )
# checking the result
alabama_agg_df


# creating a APA style table for alamaba_df_2014 dataframe.
alabama_df_2014 <- subset(alabama_df, Year == 2014)
apa.cor.table(alabama_df_2014,filename = "D:/GG606_D1/Data/Results/Tables_D3/Example3.doc",table.number = 1,show.conf.interval = F)


# Creating plots for NO2 in alabama
p<-ggplot(data=alabama_agg_df, aes(x = Year, y =`NO2 Mean`, group = 1)) + 
  geom_line(aes(color = 'NO2')) +
  labs(title="NO2 Emission in Alabama from 2013-2016",x="Year", y = "NO2 (Parts per Million)") +
  theme_apa(
    legend.pos = "right",
    legend.use.title = FALSE,
    legend.font.size = 12,
    x.font.size = 12,
    y.font.size = 12,
    facet.title.size = 12,
    remove.y.gridlines = TRUE,
    remove.x.gridlines = TRUE
  )
#Saving the ggplot
ggsave(
  paste(mainDir,Plots_D3,"/NO2_alabama_2013-2016.tiff",sep=""),
  plot = p,device = "tiff")


