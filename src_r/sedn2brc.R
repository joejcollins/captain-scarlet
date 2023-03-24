
# Rename the SEDN columns to suit BRC
rename_columns <- function(df) {
  new_name_map <- c("Common.Name" = "Common name",
                 "Site" = "Site name")
  names(df) <- new_name_map[names(df)]
}


# Remove columns from a dataframe
remove_columns <- function(df) {
  cols_to_remove <- c("Original.name", "Sort.order")
  df <- df[, !(names(df) %in% cols_to_remove)]
  return df
}


################################################################################
# Main script
data_path <- "./data/raw"
all_files <- list.files(data_path, pattern = "*.csv", full.names = TRUE)

# Create a single dataframe from the CSV files
dataframes <- list()
for (filename in all_files) {
  df <- read.csv(filename)
  dataframes <- append(dataframes, list(df))
}
merged_df <- do.call(rbind, dataframes)

# Tidy up the columns.
rename_columns(merged_df)
merged_df <- remove_columns(merged_df)

write.csv(merged_df, file = "./data/processed/VC40.csv", row.names = FALSE)
