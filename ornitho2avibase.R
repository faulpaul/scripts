###
### ornitho2avibase.R
###
### open ornitho csv file and convert it to a
### avibase csv file
###

### usage:
### change the filename accordingly and execute the script

### variables
inputfile = "path/to/export.txt"
outputfile = "path/to/avibaseimport.csv"

### read ornitho file
data <- data.frame()
data <- read.csv(inputfile, header=TRUE, sep="\t", stringsAsFactors=FALSE)

### merge the needed scientific name and observation date into an new dataframe
data2 <- cbind(data["LATIN_SPECIES"], data["DATE"])

## merge common name, estimation, number, municipality, detail, comment into one column
data2 <- cbind(data2, do.call(paste, data[c(3,33,34,23,35,67)]))

## remove first row
data2 <- (data2[(-c(1)),])

### sort unique
data2$DATE <- as.Date(data2$DATE , "%d.%m.%Y")
data2 <- data2[order(data2$DATE ),]
data2 <- data2[!duplicated(data2$LATIN_SPECIES), ]

## fix date format
data2["DATE"] <- gsub("[-]","/", data2$DATE)

##rename columns
names(data2) <- c("ScientificName","ObsDt","Details")

## write into avibase csv file
write.csv(data2, outputfile, row.names=FALSE)

