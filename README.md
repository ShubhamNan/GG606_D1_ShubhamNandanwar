# GG606_D1_ShubhamNandanwar
<br />
---------------------------------------------------------------------------------<br />
This is an assignment-3 submission for 'GG-606-A - Scientific Data Wrangling'.<br />
by Shubham Nandanwar<br />
---------------------------------------------------------------------------------<br />

***********Data source***********<br />
The dataset was downloaded from ‘https://www.kaggle.com/sogun3/uspollution’. This data was acquired from the database of U.S. EPA : https://aqsdr1.epa.gov/aqsweb/aqstmp/airdata/download_files.html and uploaded to kaggle.com as a open dataset by user named ‘BrendaSo’. The link to uploader’s profile is as follows: ‘https://www.kaggle.com/sogun3’.<br />
<br />
<br />
***********Data information***********<br />
The dataset deals with U.S. Pollution data from 2000 to 2016. The data contains four daily observations of NO2, SO2, CO AND O3 from 2000-2016 for all the states of U.S. The raw data has 29 columns and over 1.4 million observations in total. The dataset has information such as State code, county code, site number, address of the air quality meter and mean, max value, max hour, AQI and unit of the four pollutants for each day from 2000 to 2016.<br /> 
<br />
<br />
***********Simplifying/cleaning the data***********<br />
The dataset contained four daily observations of four major pollutants i.e. NO2, SO2, CO and O3. Since it was a huge dataset and I wanted to make it usable, upload-able to GitHub and presentable using plots. To do so, the downloaded data was split into several .csv files based on the U.S. states/provinces to simplify it and reduce the size of files because GitHub.com has a limited space of 100mb. Secondly, the mean of the daily four observations was taken to convert four rows to one. This decreased the size of dataset to ¼ of raw data and made it more readable.<br />
<br />
<br />
***********Correcting the dataset***********<br />
While exploring the data, few flaws were observed. To clean the data, all csv files were merged. The following cleaning was performed:<br />
•	It was observed that few columns have ‘NA’ as values, so to standardize it and make it processable, the ‘NA’ values were replaced with ‘0’. <br />
•	Renamed the ‘Date Local’ column to ‘Date’. <br />
•	Created ‘Month_Yr’ and ‘Year’ columns by extracting them from Dates to simplify the data for further processing. <br />
•	After aggregating the rows, new rows were generated called ‘Group.1’, ‘Group.2’, ‘Group.3’, so they had renamed them as ‘Month_Yr’, ‘State’ and ‘Year’. <br />
•	Dropped the column containing units of the pollutant and the whole column turned into NA after aggregating. <br />
•	I divided the data back based on the states/provinces of U.S. for better insights.<br />
<br />
<br />
***********Plotting the data***********<br />
After converting four values into one by taking mean of observation values, the dataset still consisted of daily observations which was making the plots too busy. To simplify the plots, I executed two more steps:<br />
•	First, I took mean of observation throughout the month for each month in each year. <br />
•	Second, I divided the states based on into divisions defined by US Census Bureau (Info link: https://www.mapsofworld.com/usa/usa-maps/united-states-regional-maps.html). <br />
Separate plots were made for each pollutant per U.S. division for whole 2000-2016 timeframe. <br />
<br />
<br />
***********Logic behind this repository structure***********<br />
The parent folder “GG606’ is named after the course. This folder contains a R workspace file, a ReadMe file and a Rhistory file along with three subfolders called Data, Docs and Scripts. <br />
The Data folder contains all the data and is further divided into three folders: ‘Raw data’, ‘Clean_Data’ and ‘Results’. The ‘Raw data’ folder contains the ‘US pollution’ raw data which was downloaded from an open data source website: ‘https://www.kaggle.com/sogun3/uspollution’. The ‘Clean_Data’ folder contains the cleaned csv files of all states of U.S. The ‘Results’ folder is further divided into subfolders based on the result type i.e. plots and tables. <br /> 
The ‘Docs’ folder contains metadata. <br />
The ‘Scripts’ folder contains R files which were used to clean, process and analyse the data. This folder contains three R scripts named as: ‘data_merging_cleaning’, ‘All_State_Insights’ and ‘State_creating_insights’. The ‘data_merging_cleaning’ contains codes for cleaning/tidying the U.S. pollution dataset and generating and saving the cleaned data. The ‘All_State_Insights’ contains the codes used to generate plots of the U.S. dataset with all states in single graph/plot. After plotting them together, I realised that the plot looked too busy, thereby I wrote another script named ‘State_creating_insights’ in which I drew separate plots per pollutant for Middle Atlantic and New England division for whole 2000-2016 timeframe.<br />
The order to run the scripts is as follows: <br />
data_merging_cleaning > All_State_Insights > State_creating_insights<br />
<br />
<br />


