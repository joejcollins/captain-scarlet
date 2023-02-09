my_file <- read.csv("flora_2022.csv")
grps <- (split(my_file, (seq(nrow(my_file))-1) %/% 200000))
for (i in seq_along(grps)) {
  write.csv(grps[[i]], paste0("flora_2022_split_", i, ".csv"))
}