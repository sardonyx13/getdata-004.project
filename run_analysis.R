GetRequiredReatures <- function(root.dir) {
	file.name <- paste(root.dir, "/features.txt", sep = "")
	features <- read.table(file.name, col.names = c("Number", "Description"), stringsAsFactors = FALSE)
	features <- subset(features, grepl("mean\\(\\)|std\\(\\)", Description))
	features
}

ReadActivitiesLabels <- function(root.dir) {
	file.name <- paste(root.dir, "/activity_labels.txt", sep = "")
	activities <- read.table(file.name, col.names = c("Activity", "Label"), stringsAsFactors = FALSE)
	activities
}

ReadXdata <- function(root.dir, type, cols) {
	file.name <- paste(root.dir, "/", type, "/X_", type, ".txt",sep = "")
	data <- read.table(file.name, header = FALSE)
	data[, cols]
}

ReadSubjects <- function(root.dir, type) {
	file.name <- paste(root.dir, "/", type, "/subject_", type, ".txt",sep = "")
	read.table(file.name, header = FALSE, col.names = c("Subject"))
}

ReadActivities <- function(root.dir, type) {
	file.name <- paste(root.dir, "/", type, "/y_", type, ".txt",sep = "")
	activities <- read.table(file.name, col.names = c("Activity"))
	activities
}

ReadDataByType <- function(root.dir, type, features, activities.labels) {
	subjects <- ReadSubjects(root.dir, type)	
	activities <- sapply(ReadActivities(root.dir, type), function(a) activities.labels$Label[a])

	data <- ReadXdata(root.dir, type, features$Number)
	colnames(data) <- features$Description
	data <- cbind(subjects, activities, data)
	data
}

ReadData <- function(root.dir) {
	message("reading a features list...")
	features <- GetRequiredReatures(root.dir)
	
	message("reading an activities list...")
	activities.labels <- ReadActivitiesLabels(root.dir)

	message("reading tests data...")
	test <- ReadDataByType(root.dir, "test", features, activities.labels)
	
	message("reading train data...")
	train <- ReadDataByType(root.dir, "train", features, activities.labels)
	
	data <- rbind(test, train)
	data
}

RunAnalysis <- function(root.dir) {
	data <- ReadData(root.dir)
	
	message("processing data...")
	#sapply(split(data, list(data$Subject, data$Activity)), function(a) sapply(a[c(-1, -2)], mean))
}
