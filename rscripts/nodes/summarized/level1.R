#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

level1 <- function(base_node_list.csv, level1.csv){
  
  library(dplyr)
  
  base_node_list<-read.csv(base_node_list.csv)
  
  level1<-
    base_node_list %>% 
    rename(id="level1.id",label="level1.label") %>% 
    group_by(id,label) %>%
    summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
    mutate(type="level1")
  
  write.csv(level1, file = level1.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    level1(args[1],args[2])
  )
)
