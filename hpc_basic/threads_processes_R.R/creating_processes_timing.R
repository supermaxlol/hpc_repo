
library(parallel)
library(tictoc)

# Define the work function
do_work <- function(process_number) {
  start_time <- proc.time()[3]
  cat(sprintf("[Process %d] Starting work at %.2f\n", process_number, start_time))
  
  i <- 0
  for(j in 1:20000000) {
    i <- i + 1
  }
  
  end_time <- proc.time()[3]
  duration <- end_time - start_time
  cat(sprintf("[Process %d] Finished work at %.2f. Response time: %.2f seconds\n", 
              process_number, end_time, duration))
  
  return(list(process = process_number, 
              start_time = start_time, 
              end_time = end_time, 
              duration = duration))
}

# Main execution function
main <- function() {
  num_cores <- 5
  cat("Creating cluster with", num_cores, "cores\n")
  cl <- makeCluster(num_cores)
  
  cat("Starting processes...\n")
  process_numbers <- 1:num_cores
  
  tic()
  results <- parLapply(cl, process_numbers, do_work)
  
  stopCluster(cl)
  
  total_time <- toc()
  
  cat(sprintf("\nAll %d processes completed.\n", length(results)))
  
  cat("\nSummary of process durations:\n")
  for(result in results) {
    cat(sprintf("Process %d: %.2f seconds\n", 
                result$process, 
                result$duration))
  }
}

# Run the main function
main()
