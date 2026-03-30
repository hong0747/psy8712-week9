# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(rvest)

# Data Import and Cleaning

# Visualization
#Displays an appropriate tidyverse visualization of the relationship between source and length.

# Analysis
#Runs an ANOVA comparing mean lengths across the four sources, including calculating the p-value associated with that relationship. Don't worry about post-hoc tests. You will probably want to look at anova() and/or aov().

# Publication
paste("The results of an ANOVA comparing lengths across sources was F(", "INSERTDFN", "INSERTDFD", ") = ", sub("^0\\.", ".", round("INSERTF", 2)), "p = ", sub("^0\\.", ".", round("INSERTP", 2)), ". This test ", ifelse("INSERTF" < .05, "was", "was not"), " statistically significant.”)