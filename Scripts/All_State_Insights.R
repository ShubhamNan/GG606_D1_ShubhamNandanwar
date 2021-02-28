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
library(RColorBrewer)

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

p <- DF %>%
  ggplot( aes(x=Month_Yr, y=`NO2 Mean`)) +
  geom_area(fill="#69b3a2", alpha=0.5) +
  geom_line(color="#69b3a2") +
  ylab("NO2 Mean(Parts ber Billions)") +
  theme_ipsum()

# Turn it interactive with ggplotly
p <- ggplotly(p)
p

Results="Results"
Results_all = "Results/All_States"
dir.create(file.path(mainDir, Results), showWarnings = FALSE)
dir.create(file.path(mainDir, Results_all), showWarnings = FALSE)

# Multiple of all states line plot
p<-ggplot(DF, aes(x = Month_Yr, y =`NO2 Mean`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()


ggsave(
  paste(mainDir,Results_all,"/All_State_NO2_main_plot.png",sep=""),
  plot = p,device = "png")


p<-ggplot(DF, aes(x = Month_Yr, y =`CO Mean`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()


ggsave(
  paste(mainDir,Results_all,"/All_State_CO_main_plot.png",sep=""),
  plot = p,device = "png")


p<-ggplot(DF, aes(x = Month_Yr, y =`SO2 Mean`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()


ggsave(
  paste(mainDir,Results_all,"/All_State_SO2_main_plot.png",sep=""),
  plot = p,device = "png")


p<-ggplot(DF, aes(x = Month_Yr, y =`O3 Mean`, group = 1)) + 
  geom_line(aes(color = State)) +
  theme_minimal()


ggsave(
  paste(mainDir,Results_all,"/All_State_O3_main_plot.png",sep=""),
  plot = p,device = "png")


# plotting bar graph of mean
plot_DF <- aggregate(DF[, c("NO2 Mean","O3 Mean","SO2 Mean","CO Mean")], list(DF$State), mean)

plot_DF <- plot_DF %>% 
  rename(
    "State" = "Group.1")
dev.off()
coul <- brewer.pal(5, "Set2") 
png(file = paste(mainDir,Results_all,"/All_State_Bar_Plot.png",sep=""),   # The directory you want to save the file in
    width = 1544, height = 1080)
p<-barplot(t(as.matrix(plot_DF[, 2:5])), 
        beside = TRUE,
        names.arg = plot_DF$State,
        legend.text = TRUE,
        ylab = "Parts per Million/Billion",
        xlab = "State",
        col=coul)

dev.off()
