library(plyr)
#1.Merges the training and the test sets to create one data set.
read1 <- read.table("train/X_train.txt")
read2 <- read.table("test/X_test.txt")
X_table <- rbind(read1, read2)

read1 <- read.table("train/subject_train.txt")
read2<- read.table("test/subject_test.txt")
subject_table <- rbind(read1, read2)

read1 <- read.table("train/y_train.txt")
read2 <- read.table("test/y_test.txt")
y_table<- rbind(read1, read2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt")
mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])
X_table<- X_table[, mean_and_std]
names(X_table) <- features[mean_and_std, 2]

#3 Use descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
y_table[, 1] <- activities[y_table[, 1], 2]
names(y_table) <- "activity"

#4 Appropriately label the data set with descriptive variable names

names(subject_table) <- "subject"
com_data <- cbind(X_table, y_table, subject_table)
#Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
averages_data <- ddply(com_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)
