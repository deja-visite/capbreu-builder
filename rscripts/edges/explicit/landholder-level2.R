#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

landholder_level1 <- function(input.csv, output.csv){
  
  library(dplyr)

base_edge_list<-read.csv(input.csv)

landholder_level2<-
  base_edge_list %>% 
  select(landholder.id, level2.id) %>%
  rename(from="landholder.id",to="level2.id") %>% 
  mutate(label="is member of",type="level2-member") %>% 
  select(from,to,label,type) %>% 
  arrange(from)

write.csv(landholder_level2, file = output.csv, row.names = FALSE)

}

suppressWarnings(
  suppressMessages(
    landholder_level1(args[1],args[2])
  )
)
