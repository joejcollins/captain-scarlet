# setwd("~/Documents/NBN/Data/updates/SEDN")

library(stringi)
library(stringr)

license <- 'CC-BY'
record_basis <- 'HumanObservation'
rights_holder <- 'Shropshire Ecological Data Network'
institution_code <- 'SEDN'
id_verification <- 'Accepted - considered correct'

dataset_Name <- 'Shropshire Ecological Data Network Database'

data_r6 <- read.csv(file="data/raw/flora_2023_split_1.csv", 
                    stringsAsFactors = FALSE)

# Rename the column name - y to Year
colnames(data_r6)[colnames(data_r6) == "Y"] ="year"

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

colnames(data_r6)[4] <- "Date"

data_r6$Date <- trim(data_r6$Date)

data_r6$date_chars <- nchar(data_r6$Date)
unique(data_r6$date_chars)
# 11 15 12 14 19 23 20 22 25 26 28 27 21 18  4 24  8 16 13  9 17 10  7  6  5  0
unique(nchar(data_r6$year))
data_r6[is.na(data_r6$year),]
nrow(data_r6[is.na(data_r6$year),])

data_r6 <- data_r6[!is.na(data_r6$year),]

nrow(data_r6)

# Y 4
data_r6$eventDate[data_r6$date_chars==4] <- data_r6$Date[data_r6$date_chars==4]

# 5 after Y
unique(data_r6$Date[data_r6$date_chars==5])
data_r6$eventDate[data_r6$date_chars==5] <- gsub(">", "/", data_r6$Date[data_r6$date_chars==5])

# 6 and 7
unique(data_r6$Date[data_r6$date_chars %in% c(6,7)])
data_r6$eventDate[data_r6$date_chars %in% c(6,7)] <- 
                    format(as.Date(paste0(substr(data_r6$Date[data_r6$date_chars %in% c(6,7)], 1, data_r6$date_chars[data_r6$date_chars %in% c(6,7)] -2),
                                        data_r6$year[data_r6$date_chars %in% c(6,7)]),
                            format="%d/%m/%Y"
                            ),"%Y-%m-%d")


# M 8
unique(data_r6$Date[data_r6$date_chars==8])
# long month and year, i.e. Jan 1987
data_r6$Date[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==-1]
data_r6$eventDate[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==-1] <- format(as.Date(paste("01", data_r6$Date[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==-1], sep=" "),
                                                            format="%d %b %Y"),"%Y-%m")

data_r6$Date[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==3]

data_r6$eventDate[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==3] <- 
  format(as.Date(paste0(substr(data_r6$Date[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==3], 
                               1, 
                               data_r6$date_chars[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==3] -2),
                        data_r6$year[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==3]),
                 format="%d/%m/%Y"
  ),"%Y-%m-%d")

data_r6[nchar(data_r6$Date)==8, c('eventDate','Date')]


# M 9
unique(data_r6$Date[data_r6$date_chars==9])
data_r6$eventDate[nchar(data_r6$Date)==9] <- format(as.Date(paste("01", data_r6$Date[nchar(data_r6$Date)==9], sep=" "),
                                                                                              format="%d %b %Y"),"%Y-%m")
data_r6$eventDate[data_r6$Date=="1/10/1979"] <- "1979-10-01"
data_r6$eventDate[data_r6$Date=="15/8/2015"] <- "2015-08-15"
data_r6[nchar(data_r6$Date)==9, c('eventDate','Date')]


# M 10
see <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==10]))
unique(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==-1])
unique(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==-1 & regexpr(' ', data_r6$Date) != 2])
data_r6$eventDate[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==-1 & regexpr(' ', data_r6$Date) != 2] <- 
                              format(as.Date(paste("01", data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==-1 & regexpr(' ', data_r6$Date) != 2], sep=" "),
                                                            format="%d %b %Y"),"%Y-%m")

data_r6$eventDate[data_r6$Date=="21 JUL1927"] <- "1927-07-21"

unique(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==-1 & regexpr(' ', data_r6$Date) == 2])
data_r6$eventDate[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==-1 & regexpr(' ', data_r6$Date) == 2] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==-1 & regexpr(' ', data_r6$Date) == 2],
                 format="%d %b %Y"),"%Y-%m-%d")


unique(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('00/', data_r6$Date) ==1])
data_r6$eventDate[nchar(data_r6$Date)==10 & regexpr('00/', data_r6$Date) ==1] <- format(as.Date(paste0("01/", substring(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('00/', data_r6$Date) ==1],4,10)),
                                                            format="%d/%m/%Y"),"%Y-%m")

unique(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==3 & regexpr('00/', data_r6$Date) ==-1])
data_r6$eventDate[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==3 & regexpr('00/', data_r6$Date) ==-1] <- format(as.Date(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==3  & regexpr('00/', data_r6$Date) ==-1],
                                                  format="%d/%m/%Y"),"%Y-%m-%d")

data_r6[nchar(data_r6$Date)==10, c('eventDate','Date')]


# M 11
unique(data_r6$Date[data_r6$date_chars==11])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==11]))

unique(data_r6$Date[nchar(data_r6$Date)==11 & regexpr(' ', data_r6$Date) ==3])
data_r6$eventDate[nchar(data_r6$Date)==11 & regexpr(' ', data_r6$Date) ==3] <- 
        format(as.Date(data_r6$Date[nchar(data_r6$Date)==11 & regexpr(' ', data_r6$Date) ==3],
                                             format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==11 & regexpr(' ', data_r6$Date) ==2])
data_r6$eventDate[nchar(data_r6$Date)==11 & regexpr(' ', data_r6$Date) ==2] <- 
          format(as.Date(data_r6$Date[nchar(data_r6$Date)==11 & regexpr(' ', data_r6$Date) ==2],
                        format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==11 & regexpr('Autumn', data_r6$Date) ==1])
data_r6$eventDate[data_r6$Date=="Autumn 1923"] <- "1923-10-23/12-21"

unique(data_r6$Date[nchar(data_r6$Date)==11 & regexpr('August', data_r6$Date) ==1])
data_r6$eventDate[nchar(data_r6$Date)==11 & regexpr('August', data_r6$Date) ==1] <- 
                                  paste(data_r6$year[nchar(data_r6$Date)==11 & regexpr('August', data_r6$Date) ==1],
                                                "-08", sep="")

checking <- data_r6[nchar(data_r6$Date)==11, c('year','eventDate','Date')]


# M 12
unique(data_r6$Date[data_r6$date_chars==12])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==12]))

unique(data_r6$Date[nchar(data_r6$Date)==12 & regexpr(' ', data_r6$Date) ==3])
data_r6$eventDate[nchar(data_r6$Date)==12 & regexpr(' ', data_r6$Date) ==3] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==12 & regexpr(' ', data_r6$Date) ==3],
                 format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==12 & regexpr(' ', data_r6$Date) ==2])
data_r6$eventDate[nchar(data_r6$Date)==12 & regexpr(' ', data_r6$Date) ==2] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==12 & regexpr(' ', data_r6$Date) ==2],
                 format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==12 & regexpr('October', data_r6$Date) ==1])
data_r6$eventDate[nchar(data_r6$Date)==12 & regexpr('October', data_r6$Date) ==1] <- 
          paste(data_r6$year[nchar(data_r6$Date)==12 & regexpr('October', data_r6$Date) ==1],
                                            "-10", sep="")

unique(data_r6$Date[nchar(data_r6$Date)==12 & regexpr('January', data_r6$Date) ==1])
data_r6$eventDate[nchar(data_r6$Date)==12 & regexpr('January', data_r6$Date) ==1] <- 
  paste(data_r6$year[nchar(data_r6$Date)==12 & regexpr('January', data_r6$Date) ==1],
                                        "-01", sep="")

checking <- data_r6[nchar(data_r6$Date)==12, c('year','eventDate','Date')]


# M 13
unique(data_r6$Date[data_r6$date_chars==13])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==13]))

unique(data_r6$Date[nchar(data_r6$Date)==13 & regexpr(' ', data_r6$Date) ==3])
data_r6$eventDate[nchar(data_r6$Date)==13 & regexpr(' ', data_r6$Date) ==3] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==13 & regexpr(' ', data_r6$Date) ==3],
                 format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==13 & regexpr(' ', data_r6$Date) ==2])
data_r6$eventDate[nchar(data_r6$Date)==13 & regexpr(' ', data_r6$Date) ==2] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==13 & regexpr(' ', data_r6$Date) ==2],
                 format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==13 & regexpr('November', data_r6$Date) ==1])
data_r6$eventDate[nchar(data_r6$Date)==13 & regexpr('November', data_r6$Date) ==1] <- 
  paste(data_r6$year[nchar(data_r6$Date)==13 & regexpr('November', data_r6$Date) ==1],
        "-11", sep="")
data_r6$eventDate[nchar(data_r6$Date)==13 & regexpr('December', data_r6$Date) ==1] <- 
  paste(data_r6$year[nchar(data_r6$Date)==13 & regexpr('December', data_r6$Date) ==1],
        "-12", sep="")
data_r6$eventDate[nchar(data_r6$Date)==13 & regexpr('February', data_r6$Date) ==1] <- 
  paste(data_r6$year[nchar(data_r6$Date)==13 & regexpr('February', data_r6$Date) ==1],
        "-02", sep="")

checking <- data_r6[nchar(data_r6$Date)==13, c('year','eventDate','Date')]


# M 14
unique(data_r6$Date[data_r6$date_chars==14])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==14]))

unique(data_r6$Date[nchar(data_r6$Date)==14 & regexpr(' ', data_r6$Date) ==3])
data_r6$eventDate[nchar(data_r6$Date)==14 & regexpr(' ', data_r6$Date) ==3] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==14 & regexpr(' ', data_r6$Date) ==3],
                 format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==14 & regexpr(' ', data_r6$Date) ==2])
data_r6$eventDate[nchar(data_r6$Date)==14 & regexpr(' ', data_r6$Date) ==2] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==14 & regexpr(' ', data_r6$Date) ==2],
                 format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==14 & regexpr('September', data_r6$Date) ==1])
data_r6$eventDate[nchar(data_r6$Date)==14 & regexpr('September', data_r6$Date) ==1] <- 
  paste(data_r6$year[nchar(data_r6$Date)==14 & regexpr('September', data_r6$Date) ==1],
        "-09", sep="")

checking <- data_r6[nchar(data_r6$Date)==14, c('year','eventDate','Date')]

# M 15
unique(data_r6$Date[data_r6$date_chars==15])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==15]))

unique(data_r6$Date[nchar(data_r6$Date)==15 & regexpr(' ', data_r6$Date) ==3])
data_r6$eventDate[nchar(data_r6$Date)==15 & regexpr(' ', data_r6$Date) ==3] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==15 & regexpr(' ', data_r6$Date) ==3],
                 format="%d %b %Y"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==15 & regexpr(' ', data_r6$Date) ==2])
data_r6$eventDate[nchar(data_r6$Date)==15 & regexpr(' ', data_r6$Date) ==2] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==15 & regexpr(' ', data_r6$Date) ==2],
                 format="%d %b %Y"),"%Y-%m-%d")

checking <- data_r6[nchar(data_r6$Date)==15, c('year','eventDate','Date')]


# M 16
unique(data_r6$Date[data_r6$date_chars==16])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==16]))

unique(data_r6$Date[nchar(data_r6$Date)==16 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)])

data_r6$eventDate[nchar(data_r6$Date)==16 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)] <- 
  format(as.Date(paste(data_r6$year[nchar(data_r6$Date)==16 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)],
        "-05-", substr(data_r6$Date[nchar(data_r6$Date)==16 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)], 
                       9, 9), sep=""), format="%Y-%m-%d"),"%Y-%m-%d")


unique(data_r6$Date[nchar(data_r6$Date)==16 & regexpr(',', data_r6$Date) ==-1])
data_r6$eventDate[nchar(data_r6$Date)==16 & regexpr(',', data_r6$Date) ==-1] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==16 & regexpr(',', data_r6$Date) ==-1],
                 format="%d %b %Y"),"%Y-%m-%d")

checking <- data_r6[nchar(data_r6$Date)==16, c('year','eventDate','Date')]

# M 17
unique(data_r6$Date[data_r6$date_chars==17])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==17]))

unique(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)])
data_r6$eventDate[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)] <- 
  format(as.Date(paste(data_r6$year[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)],
                "-05-", substr(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)], 
                               regexpr(',', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)])+2, 
                               regexpr(' May', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)])-1), 
                              sep=""), 
                  format="%Y-%m-%d"),"%Y-%m-%d")


unique(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)])
data_r6$eventDate[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)] <- 
  format(as.Date(paste(data_r6$year[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)],
                "-06-", substr(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)], 
                               regexpr(',', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)])+2, 
                               regexpr(' June', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)])-1), 
                sep=""), 
          format="%Y-%m-%d"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)])
data_r6$eventDate[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)] <- 
  format(as.Date(paste(data_r6$year[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)],
                "-07-", substr(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)], 
                               regexpr(',', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)])+2, 
                               regexpr(' July', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)])-1), 
                sep=""), 
          format="%Y-%m-%d"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==17 & regexpr(',', data_r6$Date) ==-1])
data_r6$eventDate[nchar(data_r6$Date)==17 & regexpr(',', data_r6$Date) ==-1] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==17 & regexpr(',', data_r6$Date) ==-1],
                 format="%d %b %Y"),"%Y-%m-%d")

checking <- data_r6[nchar(data_r6$Date)==17, c('year','eventDate','Date')]

# M 18
dates <- c(18,19,20,21,22,23,24,25,26,27,28)
unique(data_r6$Date[data_r6$date_chars %in% dates])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars %in% dates]))

data_r6$eventDate[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)] <- 
  format(as.Date(paste(substr(data_r6$Date[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)],
                       regexpr(',', 
                               data_r6$Date[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)])+2,
                       nchar(data_r6$Date[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)])-4
                      ),
                data_r6$year[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)],
                sep=""
              ),
          format="%d %b %Y"
          ),"%Y-%m-%d")

checking <- data_r6[nchar(data_r6$Date) %in% dates, c('year','eventDate','Date')]

# 2. add VerificationStatus
data_r6$identificationVerificationStatus <- id_verification

# 4. add datasetName
data_r6$datasetName <- dataset_Name

# 5. add license
data_r6$license <- license

# 6. add basisOfRecord
data_r6$basisOfRecord <- record_basis

data_r6$occurrenceStatus <- 'present'

# 7. add rightsHolder
data_r6$rightsHolder <- rights_holder
data_r6$institutionCode <- institution_code

# 8. extract only the fields that we need
names(data_r6)

data_dwc <- data_r6[,c(2:9,11:18)]
names(data_dwc)

colnames(data_dwc) <- c("scientificName", "taxonID", "verbatimEventDate","year",
                        "recordedBy", "identifiedBy","gridReference","locality", 
                        "eventDate", "identificationVerificationStatus", "datasetName",
                        "license","basisOfRecord",                   
                        "occurrenceStatus", "rightsHolder","institutionCode")

unique(nchar(data_dwc$gridReference))
# 8  6 10  5 12 11  7  9 21  4  3 15

data_dwc$gridReference <- gsub(" ", "", data_dwc$gridReference, fixed = TRUE)

# dodgy grid references
data_dwc$gridReference[data_dwc$gridReference=="SJ66410345     "] <- "SJ66410345"
data_dwc$gridReference[data_dwc$gridReference=="SJ3930620478         "] <- "SJ3930620478"
data_dwc$gridReference[data_dwc$gridReference=="N/A"] <- NA
data_dwc$gridReference[data_dwc$gridReference==" SJ31663769"] <- "SJ31663769"
data_dwc$gridReference[data_dwc$gridReference=="SJ3028?"] <- "SJ30"
data_dwc$gridReference[data_dwc$gridReference=="SJ7042?"] <- "SJ70"
data_dwc$gridReference[data_dwc$gridReference=="SJ26216"] <- "SJ26"
data_dwc$gridReference[data_dwc$gridReference=="SJ6603081"] <- "SJ66"
data_dwc$gridReference[data_dwc$gridReference=="SJ453228 "] <- "SJ453228"
data_dwc$gridReference[data_dwc$gridReference=="SJ5580057"] <- "SJ55"

unique(nchar(data_dwc$gridReference))
# 8  6 10  5 12  7 21  9  4 11 NA
unique(data_dwc$gridReference[nchar(data_dwc$gridReference)==21])

data_dwc$locationID <- data_dwc$locality
data_dwc$taxonID[data_dwc$taxonID=="N/A"] <- NA

data_dwc$occurrenceID <- paste0("urn:catalog:SEDN:",rownames(data_dwc))

# source(file="~/Documents/NBN/Data/R/nbn_recorder6_to_darwin_core_regex_functions.R")
# data_dwc$locality <- string_make_utfeight(data_dwc$locality)
# data_dwc$recordedBy <- string_make_utfeight(data_dwc$recordedBy)



checking <- data_dwc[,c('year','verbatimEventDate','eventDate')]
checking$nchar_date <- nchar(checking$verbatimEventDate)

data_dwc$eventDate[is.na(data_dwc$eventDate)] <- data_dwc$year[is.na(data_dwc$eventDate)]

connection <- file("SEDN_Feb_2021.csv", encoding="UTF-8")
write.csv(data_dwc, file=connection, row.names = FALSE, na="")

nrow(data_dwc)



