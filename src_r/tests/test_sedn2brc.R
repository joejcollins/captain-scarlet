library(testthat)

source(here::here("src_r/sedn2brc.R"))

# Define a test for the rename_columns function
test_that("rename_columns renames columns correctly", {
  # ARRANGE
  test_df <- data.frame(old_name1 = 1:3,
                        old_name2 = c("a", "b", "c"),
                        old_name3 = c(TRUE, FALSE, TRUE))

  expected_df <- data.frame(new_name1 = 1:3,
                            new_name2 = c("a", "b", "c"),
                            new_name3 = c(TRUE, FALSE, TRUE))

  # ACT
  result_df <- rename_columns(test_df)
  # ASSERT
  expect_equal(result_df, expected_df)
})


test_that("remove_columns removes the correct columns", {
  # ARRANGE
  df <- data.frame(Original.name = c("John", "Jane"), Age = c(25, 30),
                   Sort.order = c(2, 1), Gender = c("Male", "Female"))
  # ACT
  result <- remove_columns(df)
  # ASSERT
  expect_equal(ncol(result), 2)
  # Check that the resulting data frame does not contain the old columns
  expect_false("Original.name" %in% colnames(result))
  expect_false("Sort.order" %in% colnames(result))
})
