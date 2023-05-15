# Test the data frame conversions.
library(tidyverse)
library(testthat)

source(here::here("src_r/tbl_edit.R"))

# Define a test for the rename_columns function
test_that("rename_columns renames columns correctly", {
  # ARRANGE
  input_tbl <- tibble(
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
  expected_tbl <- tibble(
    Taxon = c("One", "Two"),
    `Common name` = c("One", "Two"),
    `Site name` = c("One", "Two"),
    `Sample method` = c("One", "Two")
  )
  message()
  # ACT
  result_df <- rename_columns(input_tbl, rename_map)
  # ASSERT
  expect_equal(result_df, expected_tbl)
})


# test_that("remove_columns removes the correct columns", {
#   # ARRANGE
#   df <- data.frame(
#     Original.name = c("John", "Jane"), Age = c(25, 30),
#     Sort.order = c(2, 1), Gender = c("Male", "Female")
#   )
#   # ACT
#   result <- remove_columns(df)
#   # ASSERT
#   expect_equal(ncol(result), 2)
#   # Check that the resulting data frame does not contain the old columns
#   expect_false("Original.name" %in% colnames(result))
#   expect_false("Sort.order" %in% colnames(result))
# })
