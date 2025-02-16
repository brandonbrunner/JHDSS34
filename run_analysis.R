##initialize
setwd("C:/Users/brunnb/OneDrive for Business 1/R/JHDSS/Course3/Week4/Assignment")
train_values <- read.table(file = 'UCI HAR Dataset/train/X_train.txt', header=F)
test_values <- read.table(file = 'UCI HAR Dataset/test/X_test.txt', header=F)

###Question 3
###Use descriptive activity names to name the activities in the data set
activity_labels <- read.table(file = 'UCI HAR Dataset/activity_labels.txt', header=F, stringsAsFactors = F)

train_labels <- read.table(file = 'UCI HAR Dataset/train/Y_train.txt', header=F, stringsAsFactors = F) #read in activity codes
train_labels <- merge(x=train_labels, y=activity_labels, by.x='V1', by.y='V1', sort=F) #join activity code with activity description
train_values <- cbind(Activity = train_labels$V2, train_values) #use cbind to put activity description at beginning
rm(train_labels) #clean up

test_labels <- read.table(file = 'UCI HAR Dataset/test/Y_test.txt', header=F, stringsAsFactors = F) #same song and dance for test set
test_labels <- merge(x=test_labels, y=activity_labels, by.x='V1', by.y='V1', sort=F)
test_values <- cbind(Activity = test_labels$V2, test_values)
rm(test_labels)

rm(activity_labels) #clean up

#apply subject labels to training set before the merge to make our lives easier
train_subjects <- read.table(file='UCI HAR Dataset/train/subject_train.txt', header=F) #read in subject code
train_values <- cbind(Subject = train_subjects, train_values) #bind subject code to the beginning of the dataset
                                                              #note that there was no dataset to conver to subject description
rm(train_subjects) #clean up

test_subjects <- read.table(file='UCI HAR Dataset/test/subject_test.txt', header=F)
test_values <- cbind(Subject = test_subjects, test_values)
rm(test_subjects)

###Question 1
###Merge the training and the test sets to create one data set.
merged <- rbind(train_values, test_values)
rm(train_values)
rm(test_values)
write.csv(file='./OutputData/1merged.csv', x=merged)

###Question 4
###Appropriately label the data set with descriptive variable names.
var_names <- read.table(file = 'UCI HAR Dataset/features.txt', header=F, stringsAsFactors = F)
colnames(merged) <- c('Subject', 'Activity', var_names$V2)
rm(var_names)

###Question 2
###Extract only the measurements on the mean and standard deviation for each measurement.
mean_indices <- grep(colnames(merged), pattern='^.*-mean\\(') #find when "-mean(" is in the variable name
sd_indices <- grep(colnames(merged), pattern='^.*-std\\(') #find when "-std(" is in the variable name

mean_measurements <- merged[, mean_indices] #grab only those instances with "-mean(" is in the variable name
sd_measurements <- merged[, sd_indices] #grab only those instances with "-std(" is in the variable name

write.csv(file='./OutputData/2mean.csv', x=mean_measurements)
write.csv(file='./OutputData/2sd.csv', x=sd_measurements)

###Question 5
###From the data set in step 4, create a second, independent tidy data set 
###with the average of each variable for each activity and each subject.

#average by subject
bySubject <- matrix(nrow=length(unique(merged$Subject)), ncol=(ncol(merged))-2) #initialize
colnames(bySubject) <- colnames(merged)[3:ncol(merged)] #use variable names
rownames(bySubject) <- unique(merged$Subject) #use subject code

for( i in 3:ncol(merged) ){ #loop through the columns
     bySubject[,i-2] <- tapply(X=merged[,i], INDEX=merged$Subject, FUN='mean') #tapply mean over the subject codes
}
bySubject <- as.data.frame(bySubject) #convert to data frame

#average by activity
byActivity <- matrix(nrow=length(unique(merged$Activity)), ncol=(ncol(merged))-2) #same song and dance for activities
colnames(byActivity) <- colnames(merged)[3:ncol(merged)]
rownames(byActivity) <- unique(merged$Activity)

for( i in 3:ncol(merged) ){
     byActivity[,i-2] <- tapply(X=merged[,i], INDEX=merged$Activity, FUN='mean')
}
byActivity <- as.data.frame(byActivity)

#supposed principles of "tidy" dataset
colnames(bySubject) <- gsub(x=colnames(bySubject), pattern='^t', replacement='time') #make descriptive
colnames(bySubject) <- gsub(x=colnames(bySubject), pattern='^f', replacement='freq') #make descriptive
colnames(bySubject) <- gsub(x=colnames(bySubject), pattern='\\(', replacement='') #no symbols
colnames(bySubject) <- gsub(x=colnames(bySubject), pattern='\\)', replacement='') #no symbols
colnames(bySubject) <- gsub(x=colnames(bySubject), pattern='-', replacement='') #no symbols
colnames(bySubject) <- gsub(x=colnames(bySubject), pattern='X$', replacement='Xaxis') #make descriptive
colnames(bySubject) <- gsub(x=colnames(bySubject), pattern='Y$', replacement='Yaxis') #make descriptive
colnames(bySubject) <- gsub(x=colnames(bySubject), pattern='Z$', replacement='Zaxis') #make descriptive
colnames(bySubject) <- tolower(colnames(bySubject)) #bullshit "lowercase" tidy principle

colnames(byActivity) <- gsub(x=colnames(byActivity), pattern='^t', replacement='time') #make descriptive
colnames(byActivity) <- gsub(x=colnames(byActivity), pattern='^f', replacement='freq') #make descriptive
colnames(byActivity) <- gsub(x=colnames(byActivity), pattern='\\(', replacement='') #no symbols
colnames(byActivity) <- gsub(x=colnames(byActivity), pattern='\\)', replacement='') #no symbols
colnames(byActivity) <- gsub(x=colnames(byActivity), pattern='-', replacement='') #no symbols
colnames(byActivity) <- gsub(x=colnames(byActivity), pattern='X$', replacement='Xaxis') #make descriptive
colnames(byActivity) <- gsub(x=colnames(byActivity), pattern='Y$', replacement='Yaxis') #make descriptive
colnames(byActivity) <- gsub(x=colnames(byActivity), pattern='Z$', replacement='Zaxis') #make descriptive
colnames(byActivity) <- tolower(colnames(byActivity)) #bullshit "lowercase" tidy principle

#write out
write.table(byActivity, './OutputData/5Activity.csv', row.name=F)
write.csv(bySubject, './OutputData/5Subject.csv')

q5 <- rbind(byActivity, bySubject)
write.table(x=q5, file='./OutputData/averages.txt', row.names = F)