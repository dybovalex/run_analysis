
#reading data from file to data.frame
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
y_train <-read.table("y_train.txt")
y_test <- read.table("y_test.txt")
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")

#binding data train in one table
data.train <- data.frame(subject_train, y_train, X_train)

#bindign data text in one table
data.test <- data.frame(subject_test, y_test, X_test)

#combining the data in one table
data.all <- rbind(data.test, data.train)
library(dplyr)
data.all <- tbl_df(data.all)

#reading the names and changing the row names in all.data.frame
features <- read.table("features.txt")
names <- as.character(features[,2])
names <- gsub( "-", "_", names)
colnames(data.all)<-c("PersonNr", "Activity", names)


#changing the coded activity with actual activity names
activity_labels <- read.table("activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])
for (i in unique(data.all$Activity)) {
    data.all$Activity[data.all$Activity == i] <- activity_labels[i,2]                                               
}

#extractint means and standard deviation of each measurement
#determing if mean or std in the column name
mean_std <- grepl("mean", colnames(data.all)) | grepl("std", colnames(data.all))

#adding two colums (person and activity)
mean_std[c(1,2)] = c(T,T)
#extracting the mean and std
data.mean_std <- data.all[mean_std]

#grouping data by PersonNr and Activity
data.group <- group_by(data.mean_std, PersonNr, Activity)

#taking the names of the grouped data
group.names <- colnames(data.group)
#making summary table for first variable
data.final <- summarize_(data.group, paste("mean(",group.names[3],")"))


#adding the all variable to summury table
for (i in 4:length(group.names)) {
    data.final <- data.frame(data.final, summarize_(data.group, paste("mean(",group.names[i],")"))[,3])
}

#write final data to file
write.table(data.final, file = "./data_final.txt", row.names = F)





