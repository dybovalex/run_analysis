# run_analysis

the data was download from the link (coursera).

The files were unziped and copied to the R workspace. 

All files were read using read.table command. 
The data were merged using data.frame command and then rbind command. 
The names of variables were read from the file.  
The colums names of merged data.frames were changed according to the names read from the file
The second column "activity" was recoded (the numbers were substituted with descriptive names using for loop)
The data that contains mean and std deviation were extracted from the all data. grepl function was used to check column names
The obtained data was grouped by group_by function (package dplyr). 
The mean was calculated for each person and activity using the 1st variable. 
The final data was constructed by for loop going through all colunms
The table was written to file using write.table function



