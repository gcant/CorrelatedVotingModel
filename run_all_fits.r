source("fitting_fns.r")
set.seed(42)

# Run on all example csv files  that have not yet been solved.
# List the CSV files in the directory './test_dir'
files <- list.files(path = "./data", pattern = "*.csv", full.names = FALSE)

# Loop through each file in the data directory
for (file in files) {
  S <- read.csv(paste0("./data/", file), header=FALSE)

  # Remove the '.csv' suffix to get just the name
  file_name <- sub(".csv$", "", file)
  if (!file.exists(file.path('out', paste0(file_name, 'MAP1.csv')))) {
    # Pass the name into example_fn
    print(paste("Solving", file_name))
    fit_all_models(S, file_name)
    print("Done.")
  }
}

