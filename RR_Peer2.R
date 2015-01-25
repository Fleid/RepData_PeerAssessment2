
# Session initialization

setwd("~/Documents/GitHub/RepData_PeerAssessment2")
Sys.setlocale("LC_TIME", "en_US")

library(ggplot2)
library(R.utils)

sessionInfo()

# Get data

download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", destfile = "StormData.csv.bz2", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf", destfile = "StormData_Documentation.pdf", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2FNCDC%20Storm%20Events-FAQ%20Page.pdf", destfile = "StormData_FAQ.pdf", method = "curl")

bunzip2("StormData.csv.bz2", overwrite = FALSE, remove = FALSE)

SD_Raw <- read.csv("StormData.csv", header = TRUE, sep = ",")

# Question 1
# Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?


# Question 2
# Across the United States, which types of events have the greatest economic consequences?