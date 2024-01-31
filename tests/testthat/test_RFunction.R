library('move2')

test_data <- test_data("input3_move2.rds") #file must be move2!

test_that("happy path1", {
  actual <- rFunction(data = test_data, startTime="2006-02-01T12:00:00Z", endTime="2006-05-01T12:00:00Z", filter=TRUE)
  expect_equal(length(which(mt_time(actual)>="2006-02-01T12:00:00Z" & mt_time(actual)<="2006-05-01T12:00:00Z")), 238)
})

test_that("happy path2", {
  actual <- rFunction(data = test_data, startTime="2006-02-01T12:00:00Z", endTime="2006-05-01T12:00:00Z", filter=FALSE)
  expect_equal(length(which(actual$in_time=="in")), 238)
})

test_that("time not included", {
  actual <- rFunction(data = test_data, startTime="2023-02-01T12:00:00Z", endTime="2023-05-01T12:00:00Z", filter=TRUE)
  expect_null(actual)
})
