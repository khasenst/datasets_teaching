# load data frame
data_url                       <- "https://raw.githubusercontent.com/khasenst/datasets_teaching/refs/heads/main/salary_data.csv"
salary                         <- na.omit(read.csv(data_url, header = TRUE))

# convert character variables to factors
salary$Gender                  <- as.factor(salary$Gender)
salary$Education.Level         <- as.factor(salary$Education.Level)
salary$Job.Title               <- as.factor(salary$Job.Title)

# reassign levels
levels(salary$Education.Level) <- c("missing", "BS", "BS", "HS",
                                    "MS", "MS", "PhD", "PhD")
salary$Education.Level         <- factor(salary$Education.Level, 
                                         levels = c("missing", "HS", "BS", "MS", "PhD"))


dir.create(file.path("/content/salary_data"))
uniq_job <- unique(salary$Job.Title)
for (i in 1:length(uniq_job)) {
  sub <- subset(salary, Job.Title == uniq_job[i])
  # create a folder called
  job_path <- file.path("/content/salary_data", uniq_job[i])
  if (!file.exists(job_path)) {
    dir.create(job_path)
  }
  for (j in 1:nrow(sub)) {
    write.csv(sub[j,], file.path(job_path, paste0("entry", j, ".csv")), row.names = FALSE)
  }
}