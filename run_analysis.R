
library('plyr')

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
  file.name <- paste(root.dir, "/features.txt", sep = "")
  features <- read.table(file.name, col.names = c("Number", "Description"), 
                         stringsAsFactors = FALSE)
  features <- subset(features, grepl("mean\\(\\)|std\\(\\)", Description))
  
  
  file.name <- paste(root.dir, "/activity_labels.txt", sep = "")
  activities.labels <- read.table(file.name, col.names = c("Activity", "Label"), 
                                  stringsAsFactors = FALSE)
    
  
  data <-
    rbind(ReadDataByType(root.dir, "test", features, activities.labels), 
          ReadDataByType(root.dir, "train", features, activities.labels))
  
	ddply(data, .(Subject, Activity), numcolwise(mean))
}
