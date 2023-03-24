

# Define a function that renames columns
rename_columns <- function(df) {
  new_names <- c("old_name1" = "new_name1",
                 "old_name2" = "new_name2",
                 "old_name3" = "new_name3")
  
  df <- rename(df, !!!new_names)
  
  return(df)
}