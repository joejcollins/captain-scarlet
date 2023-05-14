library(lubridate)

# Merge the split data files.
merge_csv_files <- function(data_path) {
  all_files <- list.files(data_path, pattern = "*1.csv", full.names = TRUE)
  # Create a single data frame from the CSV files
  data_frames <- list()
  for (filename in all_files) {
    df <- read.csv(filename)
    data_frames <- append(data_frames, list(df))
  }
  sedn_df <- do.call(rbind, data_frames)
  return(sedn_df)
}



# Remove columns from a data frame.
remove_columns <- function(df_with_all_columns) {
  cols_to_remove <- c(
    "Original.name",
    "TVK",
    "Display.name",
    "EA",
    "L",
    "F",
    "R",
    "N",
    "S",
    "Sort.order",
    "Site.Status",
    "Owner"
  )
  # Get column indices to remove
  cols_to_remove <- match(cols_to_remove, names(df_with_all_columns))
  # Remove columns
  df_new <- df_with_all_columns[, -cols_to_remove]
  return(df_new)
}

# Transform the column contents
transform_columns <- function(df) {
  df$Record.type <- ifelse(
    df$Record.type == "field record", "Field Observation", df$Record.type
  )
  df$Record.type <- ifelse(
    df$Record.type == "voucher specimen", "Voucher Specimen", df$Record.type
  )
  return(df)
}

# Determine the date precision
date_precision <- function(date_str) {
  # parse date string
  date <- parse_date_time(date_str, orders = c("dmy", "mdY", "Ymd", "Ym", "Y"))

  # determine the type of date
  if (is.na(date$day) & is.na(date$month)) {
    "year"
  } else if (is.na(date$day)) {
    "month"
  } else {
    "day"
  }
}

# Determine the range that the date covers
convert_to_range <- function(date_str) {
  # determine the type of date
  date_precision <- date_precision(date_str)

  # parse date string and create date range
  if (date_precision == "year") {
    start_date <- parse_date_time(date_str, orders = c("Y"))
    end_date <- start_date %m+% years(1) - seconds(1)
  } else if (date_type == "month") {
    start_date <- parse_date_time(paste0(date_str, "-01"), orders = c("Y-m-d"))
    end_date <- start_date %m+% months(1) - seconds(1)
  } else {
    start_date <- parse_date_time(date_str, orders = c("dmy", "mdY", "Ymd"))
    end_date <- start_date %m+% days(1) - seconds(1)
  }

  # format date range as ISO 8601 string
  paste0(format(start_date, "%Y-%m-%dT%H:%M:%S"), "/", format(end_date, "%Y-%m-%dT%H:%M:%S"))
}

###############################################################################
# Main script
sedn_df <- merge_csv_files("./data/raw")
sedn_df <- transform_columns(sedn_df)
sedn_df <- rename_columns(sedn_df)
sedn_df <- remove_columns(sedn_df)
sedn_df$date_range <- apply(sedn_df["Date"], 2, convert_to_range)


# Save the transformed data frame.
write.csv(sedn_df, file = "./data/processed/VC40.csv", row.names = FALSE)
