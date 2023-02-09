# setwd("~/Documents/NBN/Data/updates/SEDN")

library(stringi)
library(stringr)

license <- 'CC-BY'
record_basis <- 'HumanObservation'
rights_holder <- 'Shropshire Ecological Data Network'
institution_code <- 'SEDN'
id_verification <- 'Accepted'

dataset_Name <- 'Shropshire Ecological Data Network Database'

data_r6 <- read.csv(file="flora_2022.csv", 
                      stringsAsFactors = FALSE)


trim <- function (x) gsub("^\\s+|\\s+$", "", x)

data_r6$Date <- trim(data_r6$Date)

data_r6$date_chars <- nchar(data_r6$Date)
unique(nchar(data_r6$Date))
# 20  4 19 16 22 18 17 11 23 21 24  8 10 13  9 12 15 14 26 25  0

names(data_r6)[names(data_r6) == 'Y'] <- 'Year'


unique(nchar(data_r6$Year))
data_r6[is.na(data_r6$Year),]
nrow(data_r6[is.na(data_r6$Year),])

data_r6 <- data_r6[!is.na(data_r6$Year),]

nrow(data_r6)

# Y 4
data_r6$eventDate[data_r6$date_chars==4] <- data_r6$Date[data_r6$date_chars==4]

# M 8
unique(data_r6$Date[data_r6$date_chars==8])
# long month and year, i.e. Jan 1987
data_r6$Date[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==-1]
data_r6$eventDate[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==-1] <- format(as.Date(paste("01", data_r6$Date[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==-1], sep=" "),
                                                            format="%d %b %Y"),"%Y-%m")

data_r6$Date[nchar(data_r6$Date)==8 & regexpr('/', data_r6$Date) ==3]
data_r6$eventDate[data_r6$Date=="02/12/09"] <- "2009-12-02"
data_r6$eventDate[data_r6$Date=="01/02/10"] <- "2010-02-01"
data_r6$eventDate[data_r6$Date=="01/12/09"] <- "2009-12-01"

data_r6[nchar(data_r6$Date)==8, c('eventDate','Date')]


# M 9
unique(data_r6$Date[data_r6$date_chars==9])
data_r6$eventDate[nchar(data_r6$Date)==9] <- format(as.Date(paste("01", data_r6$Date[nchar(data_r6$Date)==9], sep=" "),
                                                                                              format="%d %b %Y"),"%Y-%m")
data_r6$eventDate[data_r6$Date=="15/8/2015"] <- "2015-08-15"
data_r6[nchar(data_r6$Date)==9, c('eventDate','Date')]


# M 10
unique(data_r6$Date[data_r6$date_chars==10])
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


unique(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==3])
data_r6$eventDate[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==3] <- format(as.Date(data_r6$Date[nchar(data_r6$Date)==10 & regexpr('/', data_r6$Date) ==3],
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
                                  paste(data_r6$Year[nchar(data_r6$Date)==11 & regexpr('August', data_r6$Date) ==1],
                                                "-08", sep="")

checking <- data_r6[nchar(data_r6$Date)==11, c('Year','eventDate','Date')]


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
          paste(data_r6$Year[nchar(data_r6$Date)==12 & regexpr('October', data_r6$Date) ==1],
                                            "-10", sep="")

checking <- data_r6[nchar(data_r6$Date)==12, c('Year','eventDate','Date')]


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
  paste(data_r6$Year[nchar(data_r6$Date)==13 & regexpr('November', data_r6$Date) ==1],
        "-11", sep="")
data_r6$eventDate[nchar(data_r6$Date)==13 & regexpr('December', data_r6$Date) ==1] <- 
  paste(data_r6$Year[nchar(data_r6$Date)==13 & regexpr('December', data_r6$Date) ==1],
        "-12", sep="")
data_r6$eventDate[nchar(data_r6$Date)==13 & regexpr('February', data_r6$Date) ==1] <- 
  paste(data_r6$Year[nchar(data_r6$Date)==13 & regexpr('February', data_r6$Date) ==1],
        "-02", sep="")

checking <- data_r6[nchar(data_r6$Date)==13, c('Year','eventDate','Date')]


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
  paste(data_r6$Year[nchar(data_r6$Date)==14 & regexpr('September', data_r6$Date) ==1],
        "-09", sep="")

checking <- data_r6[nchar(data_r6$Date)==14, c('Year','eventDate','Date')]

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

checking <- data_r6[nchar(data_r6$Date)==15, c('Year','eventDate','Date')]


# M 16
unique(data_r6$Date[data_r6$date_chars==16])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==16]))

unique(data_r6$Date[nchar(data_r6$Date)==16 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)])

data_r6$eventDate[nchar(data_r6$Date)==16 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)] <- 
  format(as.Date(paste(data_r6$Year[nchar(data_r6$Date)==16 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)],
        "-05-", substr(data_r6$Date[nchar(data_r6$Date)==16 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)], 
                       9, 9), sep=""), format="%Y-%m-%d"),"%Y-%m-%d")


unique(data_r6$Date[nchar(data_r6$Date)==16 & regexpr(',', data_r6$Date) ==-1])
data_r6$eventDate[nchar(data_r6$Date)==16 & regexpr(',', data_r6$Date) ==-1] <- 
  format(as.Date(data_r6$Date[nchar(data_r6$Date)==16 & regexpr(',', data_r6$Date) ==-1],
                 format="%d %b %Y"),"%Y-%m-%d")

checking <- data_r6[nchar(data_r6$Date)==16, c('Year','eventDate','Date')]

# M 17
unique(data_r6$Date[data_r6$date_chars==17])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars==17]))

unique(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)])
data_r6$eventDate[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)] <- 
  format(as.Date(paste(data_r6$Year[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)],
                "-05-", substr(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)], 
                               regexpr(',', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)])+2, 
                               regexpr(' May', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("May", data_r6$Date)])-1), 
                              sep=""), 
                  format="%Y-%m-%d"),"%Y-%m-%d")


unique(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)])
data_r6$eventDate[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)] <- 
  format(as.Date(paste(data_r6$Year[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)],
                "-06-", substr(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)], 
                               regexpr(',', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)])+2, 
                               regexpr(' June', 
                                       data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("June", data_r6$Date)])-1), 
                sep=""), 
          format="%Y-%m-%d"),"%Y-%m-%d")

unique(data_r6$Date[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)])
data_r6$eventDate[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)] <- 
  format(as.Date(paste(data_r6$Year[nchar(data_r6$Date)==17 & grepl(",", data_r6$Date) & grepl("July", data_r6$Date)],
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

checking <- data_r6[nchar(data_r6$Date)==17, c('Year','eventDate','Date')]

# M 18
dates <- c(18,19,20,21,22,23,24,25,26)
unique(data_r6$Date[data_r6$date_chars %in% dates])
checking <- as.data.frame(unique(data_r6$Date[data_r6$date_chars %in% dates]))

data_r6$eventDate[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)] <- 
  format(as.Date(paste(substr(data_r6$Date[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)],
                       regexpr(',', 
                               data_r6$Date[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)])+2,
                       nchar(data_r6$Date[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)])-2
                      ),
                data_r6$Year[nchar(data_r6$Date) %in% dates & grepl(",", data_r6$Date)],
                sep=""
              ),
          format="%d %b %Y"
          ),"%Y-%m-%d")

checking <- data_r6[nchar(data_r6$Date) %in% dates, c('Year','eventDate','Date')]

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

data_dwc <- data_r6[,c(1:8,10:17)]
names(data_dwc)

colnames(data_dwc) <- c("occurrenceID","scientificName", "taxonID", "locality", "gridReference",
                        "verbatimEventDate","year",
                        "recordedBy", "eventDate", "identificationVerificationStatus", "datasetName",
                        "license","basisOfRecord",                   
                        "occurrenceStatus", "rightsHolder","institutionCode")

data_dwc$geodeticDatum <- "OSGB"

unique(nchar(data_dwc$gridReference))
# 6  8 10  5 12  4  9

# dodgy grid references
data_dwc$gridReference[20215] <- "SJ453228"
data_dwc$gridReference[133632] <- "SJ3930620478"
data_dwc$gridReference[874036] <- "SJ3930620478"
data_dwc$gridReference[data_dwc$gridReference=="SJ66410345     "] <- "SJ66410345"

# set the resolution 
unique(data_dwc$gridReference[nchar(data_dwc$gridReference)==6])
data_dwc$coordinateUncertaintyInMeters[nchar(data_dwc$gridReference)==6] <- 1000

unique(data_dwc$gridReference[nchar(data_dwc$gridReference)==8])
data_dwc$coordinateUncertaintyInMeters[nchar(data_dwc$gridReference)==8] <- 100

unique(data_dwc$gridReference[nchar(data_dwc$gridReference)==10])
data_dwc$coordinateUncertaintyInMeters[nchar(data_dwc$gridReference)==10] <- 10

unique(data_dwc$gridReference[nchar(data_dwc$gridReference)==5])
data_dwc$coordinateUncertaintyInMeters[nchar(data_dwc$gridReference)==5] <- 2000

unique(data_dwc$gridReference[nchar(data_dwc$gridReference)==12])
data_dwc$coordinateUncertaintyInMeters[nchar(data_dwc$gridReference)==12] <- 1

unique(data_dwc$gridReference[nchar(data_dwc$gridReference)==4])
data_dwc$coordinateUncertaintyInMeters[nchar(data_dwc$gridReference)==4] <- 10000

unique(data_dwc$gridReference[nchar(data_dwc$gridReference)==9])


# source(file="~/Documents/NBN/Data/R/nbn_recorder6_to_darwin_core_regex_functions.R")
#data_dwc$locality <- string_make_utfeight(data_dwc$locality)
#data_dwc$recordedBy <- string_make_utfeight(data_dwc$recordedBy)

# check that this is correct
#data_dwc$eventDate[data_dwc$eventDate=="1033-10-05"] <- "1933-10-05"


connection <- file("SEDN_Sept_2019_dwc.txt", encoding="UTF-8")
write.table(data_dwc, file=connection, row.names = FALSE, na="", sep="\t", quote = FALSE)


checking <- data_dwc[,c('year','verbatimEventDate','eventDate')]
checking$nchar_date <- nchar(checking$verbatimEventDate)

data_dwc[is.na(data_dwc$eventDate),]

