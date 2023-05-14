# Test the data frame conversions.

library(testthat)

source(here::here("src_r/df_conversions.R"))

# Define a test for the rename_columns function
test_that("rename_columns renames columns correctly", {
  # ARRANGE
  input_df <- data.frame(
    Species = c("One", "Two"),
    Common.Name = c("One", "Two"),
    Site = c("One", "Two"),
    Record.type = c("One", "Two")
  )
  rename_map <- c(
    "Species" = "Taxon",
    "Common.Name" = "Common name",
    "Site" = "Site name",
    "Record.type" = "Sample method"
  )
  expected_df <- data.frame(
    Taxon = c("One", "Two"),
    `Common name` = c("One", "Two"),
    `Site name` = c("One", "Two"),
    `Sample method` = c("One", "Two")
  )
  message()
  # ACT
  result_df <- rename_columns(input_df, rename_map)
  # ASSERT
  expect_equal(result_df, expected_df)
})


test_that("remove_columns removes the correct columns", {
  # ARRANGE
  df <- data.frame(
    Original.name = c("John", "Jane"), Age = c(25, 30),
    Sort.order = c(2, 1), Gender = c("Male", "Female")
  )
  # ACT
  result <- remove_columns(df)
  # ASSERT
  expect_equal(ncol(result), 2)
  # Check that the resulting data frame does not contain the old columns
  expect_false("Original.name" %in% colnames(result))
  expect_false("Sort.order" %in% colnames(result))
})
