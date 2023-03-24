
# Rename the SEDN columns to suit BRC
rename_columns <- function(df) {
  new_name_map <- c("Common.Name" = "Common name",
                 "Site" = "Site name")
  names(df) <- new_name_map[names(df)]
  return(df)
}


# Remove columns from a dataframe
remove_columns <- function(df_with_all_columns) {
  cols_to_remove <- c("Original.name", "Sort.order")
  df_with_less_columns <- df_with_all_columns[, 
    !(names(df_with_all_columns) %in% cols_to_remove)]
  return(df_with_less_columns)
}


################################################################################
# Main script
data_path <- "./data/raw"
all_files <- list.files(data_path, pattern = "*1.csv", full.names = TRUE)

# Create a single dataframe from the CSV files
dataframes <- list()
for (filename in all_files) {
  df <- read.csv(filename)
  dataframes <- append(dataframes, list(df))
}
merged_df <- do.call(rbind, dataframes)

# Tidy up the columns.
merged_df <- rename_columns(merged_df)
merged_df <- remove_columns(merged_df)

write.csv(merged_df, file = "./data/processed/VC40.csv", row.names = FALSE)
