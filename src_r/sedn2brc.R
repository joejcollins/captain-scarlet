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

# Rename the SEDN columns to suit BRC.
rename_columns <- function(df_to_rename) {
  rename_map <- c(
    "Species" = "Taxon",
    "Common.Name" = "Common name",
    "Site" = "Site name",
    "Record.type" = "Sample method"
    )
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

###############################################################################
# Main script
sedn_df <- merge_csv_files("./data/raw")
sedn_df <- transform_columns(sedn_df)
sedn_df <- rename_columns(sedn_df)
sedn_df <- remove_columns(sedn_df)


# Save the transformed data frame.
write.csv(sedn_df, file = "./data/processed/VC40.csv", row.names = FALSE)
