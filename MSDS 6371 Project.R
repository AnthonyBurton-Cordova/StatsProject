#Install packages
install.packages("Tidyverse")
install.packages("ggplot2")

#run Library
library(tidyverse)
library(ggplot2)

#Get and Read Data
AmesData <- read.csv(file.choose())
AmesData

#Check and Remove NA's
sum(is.na(AmesData$GrLIvArea))

#Addressing Assumptions (Linearity, Variance, Normality, and Independence)

#Linearity


