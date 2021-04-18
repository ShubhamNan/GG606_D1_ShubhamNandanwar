#####################################
# Submitted by: Shubham S. Nandanwar
# Student ID: 205833000
# Course: GG-606-A - Scientific Data Wrangling
#####################################

install.packages("ggplot2")
install.packages("plotly")
install.packages("RColorBrewer")
install.packages("hrbrthemes")
install.packages("expss")
install.packages("tidyr")
install.packages("broom")

# Importing libraries
library(dplyr)
library(readr)
library(ggplot2)
library(dplyr)
library(plotly)
library(RColorBrewer)
library(hrbrthemes)
library(expss)
library(tidyr)
library(broom)
library(apaTables)

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

p <- DF %>%
  ggplot( aes(x=Month_Yr, y=`NO2 Mean`)) +
  geom_area(fill="#69b3a2", alpha=0.5) +
  geom_line(color="#69b3a2") +
  ylab("NO2 Mean(Parts ber Billions)") +
  theme_ipsum()

# Turn it interactive with ggplotly
p <- ggplotly(p)
p


# plotting bar graph of mean
plot_DF <- aggregate(DF[, c("NO2 Mean","O3 Mean","SO2 Mean","CO Mean")], list(DF$State), mean)

plot_DF <- plot_DF %>% 
  rename(
    "State" = "Group.1")
dev.off()
coul <- brewer.pal(5, "Set2") 
png(file = paste(mainDir,Plots_D3,"/All_State_Bar_Plot.png",sep=""),   # The directory you want to save the file in
    width = 1544, height = 1080)
p<-barplot(t(as.matrix(plot_DF[, 2:5])), 
        beside = TRUE,
        names.arg = plot_DF$State,
        legend.text = TRUE,
        main = "Mean of Air Pollution Level in States of USA", 
        ylab = "Parts per Million/Billion",
        xlab = "State",
        legend.pos = "right",
        legend.use.title = FALSE,
        legend.font.size = 12,
        x.font.size = 12,
        y.font.size = 12,
        facet.title.size = 12,
        remove.y.gridlines = TRUE,
        remove.x.gridlines = TRUE,
        col=coul)

dev.off()


# Creating table to show correlation in the air pollution in each state of USA
apa.cor.table(plot_DF,filename = "D:/GG606_D1/Data/Results/Tables_D3/Example2.doc",table.number = 1, show.conf.interval = F)

