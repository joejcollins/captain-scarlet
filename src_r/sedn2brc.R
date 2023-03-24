# Merge the split data files.
merge_csv_files <- function(data_path) {
  all_files <- list.files(data_path, pattern = "*1.csv", full.names = TRUE)
  # Create a single data frame from the CSV files
  data_frames <- list()
  for (filename in all_files) {
    df <- read.csv(filename)
    data_frames <- append(data_frames, list(df))
  }
  merged_df <- do.call(rbind, data_frames)
  return(merged_df)
}


# Rename the SEDN columns to suit BRC.
rename_columns <- function(df_to_rename) {
  rename_map <- c("Common.Name" = "Common name",
                  "Site" = "Site name")
  for (i in 1:length(rename_map)) {
    col_name <- names(rename_map[i])
    new_col_name <- rename_map[[i]]
    if (col_name %in% names(df_to_rename)) {
      names(df_to_rename)[
        which(names(df_to_rename) == col_name)
        ] <- new_col_name
    }
  }
  return(df_to_rename)
}


# Remove columns from a data frame.
remove_columns <- function(df_with_all_columns) {
  cols_to_remove <- c("Original.name", "Sort.order")
  df_with_less_columns <- df_with_all_columns[, 
    !(names(df_with_all_columns) %in% cols_to_remove)]
  return(df_with_less_columns)
}


###############################################################################
# Main script
merged_df <- merge_csv_files("./data/raw")
merged_df <- rename_columns(merged_df)
merged_df <- remove_columns(merged_df)

# Save the transformed data frame.
write.csv(merged_df, file = "./data/processed/VC40.csv", row.names = FALSE)
