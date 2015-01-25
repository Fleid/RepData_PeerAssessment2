
# Session initialization

setwd("~/Documents/GitHub/RepData_PeerAssessment2")
Sys.setlocale("LC_TIME", "en_US")

library(ggplot2)
library(grid)
library(R.utils) #bunzip2

sessionInfo()

# Get data

download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", destfile = "StormData.csv.bz2", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf", destfile = "StormData_Documentation.pdf", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2FNCDC%20Storm%20Events-FAQ%20Page.pdf", destfile = "StormData_FAQ.pdf", method = "curl")

bunzip2("StormData.csv.bz2", overwrite = FALSE, remove = FALSE)

SD_Raw <- read.csv("StormData.csv", header = TRUE, sep = ",")

EVTYPE_Ref <- read.csv("EVTYPE_Ref.txt",header = FALSE, sep =",")

# Question 1
# Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?
summary(SD_Raw)

h1 <- aggregate(
     cbind(SD_Raw$FATALITIES,SD_Raw$INJURIES)
    ,by=list(
            format(as.Date(SD_Raw$BGN_DATE,"%m/%d/%Y"),"%Y")
            ,as.character(SD_Raw$EVTYPE)
      )
    ,FUN=sum
  )

names(h1) <- c("YEAR","EVTYPE","FATALITIES","INJURIES") 

h1_modern <- subset(h1,h1$YEAR >= 1990)

q1 <- ggplot(h1_modern,aes(x=YEAR, y=INJURIES, colour=YEAR))
q1 <- q1 + geom_bar(stat="identity") +ylim(0,10000)

q2 <- ggplot(h1_modern,aes(x=YEAR, y=FATALITIES))
q2 <- q2 + geom_bar(stat="identity") +ylim(0,10000)

pushViewport(viewport(layout = grid.layout(1, 2)))
print(q1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(q2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))



EVLIST <- unique(h1_modern$EVTYPE[h1_modern$FATALITIES + h1_modern$INJURIES>0])





# Question 2
# Across the United States, which types of events have the greatest economic consequences?
