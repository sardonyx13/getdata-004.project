get_required_features <- function(root_dir) {
	file_name <- paste(root_dir, "/features.txt", sep = "")
	features <- read.table(file_name, col.names = c("Number", "Description"), stringsAsFactors = FALSE)
	features <- subset(features, grepl("mean\\(\\)|std\\(\\)", Description))
	features
}

read_activities_labels <- function(root_dir) {
	file_name <- paste(root_dir, "/activity_labels.txt", sep = "")
	activities <- read.table(file_name, col.names = c("Activity", "Label"), stringsAsFactors = FALSE)
	activities
}

read_x_data <- function(root_dir, type, cols) {
	file_name <- paste(root_dir, "/", type, "/X_", type, ".txt",sep = "")
	data <- read.table(file_name, header = FALSE)
	data[, cols]
}

read_subjects <- function(root_dir, type) {
	file_name <- paste(root_dir, "/", type, "/subject_", type, ".txt",sep = "")
	read.table(file_name, header = FALSE, col.names = c("Subject"))
}

read_activities <- function(root_dir, type) {
	file_name <- paste(root_dir, "/", type, "/y_", type, ".txt",sep = "")
	activities <- read.table(file_name, col.names = c("Activity"))
	activities
}

read_data_by_type <- function(root_dir, type, features, activities_labels) {
	subjects <- read_subjects(root_dir, type)	
	activities <- sapply(read_activities(root_dir, type), function(a) activities_labels$Label[a])

	data <- read_x_data(root_dir, type, features$Number)
	colnames(data) <- features$Description
	data <- cbind(subjects, activities, data)
	data
}

read_data <- function(root_dir) {
	message("reading a features list...")
	features <- get_required_features(root_dir)
	
	message("reading an activities list...")
	activities_labels <- read_activities_labels(root_dir)

	message("reading tests data...")
	test <- read_data_by_type(root_dir, "test", features, activities_labels)
	
	message("reading train data...")
	train <- read_data_by_type(root_dir, "train", features, activities_labels)
	
	data <- rbind(test, train)
	data
}

run_analysis <- function(root_dir) {
	data <- read_data(root_dir)
	
	message("processing data...")
	s <- split(data, list(data$Subject, data$Activity))
	#sapply(split(data, list(data$Subject, data$Activity)), function(a) sapply(a[c(-1, -2)], mean))
}
