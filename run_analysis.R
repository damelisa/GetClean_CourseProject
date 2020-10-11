library(dplyr)

# read test & train data
test <- read.table("./X_test.txt")
train <- read.table("./X_train.txt")

# read header for test & train data
header <- read.table("./features.txt", colClasses=c("NULL", NA))

# set header as column names for test and train data
headerc <- unlist(header)
colnames(test) <- headerc
colnames(train) <- headerc

# read & add training and subject labels column
testl <- read.table("./y_test.txt")
tests <- read.table("./subject_test.txt")
testf <- cbind(tests, test, testl)
colnames(testf)[1] <- "subject"
colnames(testf)[563] <- "Training_labels"

trainl <- read.table("./y_train.txt")
trains <- read.table("./subject_train.txt")
trainf <- cbind(trains, train, trainl)
colnames(trainf)[1] <- "subject"
colnames(trainf)[563] <- "Training_labels"

# combine train & test dataframes, select interesting columns and sort according to subject number
data <- rbind(trainf, testf) %>% 
  select(matches("std|mean|Train|subject")) %>% 
  arrange(subject)

# add descriptive column for activity
data <-  mutate(data, activity = case_when(
  data$Training_labels == 1 ~ "walking",
  data$Training_labels == 2 ~ "walking_upstairs",
  data$Training_labels == 3 ~ "walking_downstairs",
  data$Training_labels == 4 ~ "sitting",
  data$Training_labels == 5 ~ "standing",
  data$Training_labels == 6 ~ "laying"))

# add more descriptive variable names
colnames(data) <- gsub("^t", "time", colnames(data))
colnames(data) <- gsub("(Acc)", "Accelerometer", colnames(data))
colnames(data) <- gsub("Mag", "Magnitude", colnames(data))
colnames(data) <- gsub("f", "frequency", colnames(data))
colnames(data) <- gsub("Gyro", "Gyroscope", colnames(data))
colnames(data) <- gsub("mean\\(\\)", "Mean", colnames(data))
colnames(data) <- gsub("std\\(\\)", "Std-Deviation", colnames(data))

# make new dataset with averaged data grouped by subject & activity
tidydata <- arrange(data, subject, Training_labels) %>% group_by(subject, activity) %>% summarise_all(funs(mean))

write.table(tidydata, "./tidydata.txt", row.name=FALSE)