if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Load activity_labels.txt
my_activity <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Load features.txt
my_features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extract only the mean and standard deviation
extract_my_features <- grepl("mean|std", my_features)

# Load and process test dataset
my_X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
my_y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

my_subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(my_X_test) = my_features

# Extract only mean and standard deviation
my_X_test = my_X_test[,extract_my_features]

# Load filtered activity_labels
my_y_test[,2] = my_activity[my_y_test[,1]]
names(my_y_test) = c("Activity_ID", "Activity_Label")
names(my_subject_test) = "subject"

# Bind data
my_test_data <- cbind(as.data.table(my_subject_test), my_y_test, my_X_test)

# Load and process train dataset
my_X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
my_y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

my_subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(my_X_train) = my_features

# Extract only the mean and standard deviation
my_X_train = my_X_train[,extract_my_features]

# Load filtered data
my_y_train[,2] = my_activity[my_y_train[,1]]
names(my_y_train) = c("Activity_ID", "Activity_Label")
names(my_subject_train) = "subject"

# Bind data
my_train_data <- cbind(as.data.table(my_subject_train), my_y_train, my_X_train)

# Merge test and train data
data = rbind(my_test_data, my_train_data)

id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast
tidy_set = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_set, file = "./tidy.txt")