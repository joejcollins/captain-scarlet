numbers <- read.csv("./data.csv", stringsAsFactors=FALSE)

# Filter out the numbers lower that 12
numbers <- numbers[numbers$number > 12,]

# Save the filtered numbers
write.csv(numbers, "./filtered.csv")
