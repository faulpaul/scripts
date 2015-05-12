###
### ReadTraining.R
###
### open all xls Files and create a graph
###

### variables
directory = "path/to/directory"
outputfile = "path/to/output.csv"
file <- data.frame()

### open files
files <- list.files(directory, full.names=TRUE)
for (i in files) {
	data <- read.csv(i, header=FALSE, sep=";", stringsAsFactors=FALSE)
	file <- rbind(file, data)
}

### set column names
names(file) <- (c("date&time", "type", "ispringversion", "fullname", "email", "comment"))

### converting colums
### Date & Time: character -> datetime
file[[1]] <- as.POSIXct(file[[1]], format="%d.%m.%Y %H:%M")

### convert "Type of EL" to a factor and extract the language
### "E-Learning Anti-Korruption DE"
file$language[file[[2]] == "E-Learning Anti-Korruption DE"] <- "DE"
file[[2]][file[[2]] == "E-Learning Anti-Korruption DE"] <- "AK"
### "Anti-corruption E-Learning - Inclusion in personal file"
file$language[file[[2]] == "Anti-corruption E-Learning - Inclusion in personal file"] <- "ENG"
file[[2]][file[[2]] == "Anti-corruption E-Learning - Inclusion in personal file"] <- "AK"	
### "ELearning Kartellrecht - Abschluss des E-Learnings"
file$language[file[[2]] == "ELearning Kartellrecht - Abschluss des E-Learnings"] <- "DE"
file[[2]][file[[2]] == "ELearning Kartellrecht - Abschluss des E-Learnings"] <- "KR"
### "Anti-trust: Inclusion in personal file"
file$language[file[[2]] == "Anti-trust: Inclusion in personal file"] <- "ENG"
file[[2]][file[[2]] == "Anti-trust: Inclusion in personal file"] <- "KR"
### other
file$language[file[[2]] == ""] <- "NA"
file[[2]][file[[2]] == ""] <- "NA"

### generate a new column containg the email domain
temp_list <- strsplit(file[[5]],"@")
temp_list <- sapply(temp_list, tolower)
file$domain <- sapply(temp_list, "[", 2)

### remove newline "\n"
file <- as.data.frame(apply(file,2,function(x)gsub('\n', '',x)))

### write to csv file
write.table(file, file = outputfile, na="", row.names=FALSE, col.names=FALSE, sep = ";", append=FALSE)

