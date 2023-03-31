library(lubridate)

# parse date string
date_str <- "17 May 1814"
date_str <- "1814"

date <- parse_date_time(date_str, orders = c("dmy", "Y", "Ymd"))

