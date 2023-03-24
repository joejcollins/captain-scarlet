library(testthat)

source(here::here("src_r/sedn2brc.R"))

# Define a test for the rename_columns function
test_that("rename_columns renames columns correctly", {
  # Create a test dataframe
  test_df <- data.frame(old_name1 = 1:3,
                         old_name2 = c("a", "b", "c"),
                         old_name3 = c(TRUE, FALSE, TRUE))

  # Expected result
  expected_df <- data.frame(new_name1 = 1:3,
                             new_name2 = c("a", "b", "c"),
                             new_name3 = c(TRUE, FALSE, TRUE))

  # Call the function
  result_df <- rename_columns(test_df)

  # Test that the function returns the expected result
  expect_equal(result_df, expected_df)
})
