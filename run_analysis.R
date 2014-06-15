
library('plyr')

ExtractFeatures <- function(root.dir) {
  file.name <- paste(root.dir, "/features.txt", sep = "")
  features <- read.table(file.name, col.names = c("Number", "Description"), 
                         stringsAsFactors = FALSE)
  
  features <- subset(features, grepl("^tBodyAcc\\-|^tGravityAcc\\-|^tBodyGyro\\-",
                     Description))
  features <- subset(features, grepl("mean\\(\\)|std\\(\\)" , Description))  
  features$Description <- gsub("[+-]", ".", features$Description)
  features$Description <- gsub("\\(|\\)|\\[|\\]", "", features$Description)
  features
}

ExtractActivitiesLabels <- function(root.dir) {
  file.name <- paste(root.dir, "/activity_labels.txt", sep = "")
  read.table(file.name, col.names = c("Activity", "Label"), 
             stringsAsFactors = FALSE)  
}

ReadDataByType <- function(root.dir, type, features, activities.labels) {
  file.name <- paste(root.dir, "/", type, "/subject_", type, ".txt",sep = "")
  subjects <- read.table(file.name, header = FALSE, col.names = c("Subject"))
  
  file.name <- paste(root.dir, "/", type, "/y_", type, ".txt",sep = "")
  activities <- read.table(file.name, col.names = c("Activity"))
	activities <- sapply(activities, function(a) activities.labels$Label[a])

  file.name <- paste(root.dir, "/", type, "/X_", type, ".txt",sep = "")
  data <- read.table(file.name, header = FALSE)
  data <- data[, features$Number]  
	colnames(data) <- features$Description

	cbind(subjects, activities, data)
}

RunAnalysis <- function(root.dir = "UCI HAR Dataset") {
  features <- ExtractFeatures(root.dir)  
  activities.labels <- ExtractActivitiesLabels(root.dir)
  
  data <-
    rbind(ReadDataByType(root.dir, "test", features, activities.labels), 
          ReadDataByType(root.dir, "train", features, activities.labels))
  
	ddply(data, .(Subject, Activity), numcolwise(mean))
}
