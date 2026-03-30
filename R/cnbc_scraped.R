# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(rvest)

# Data Import and Cleaning
sections <- c("Business", "Investing", "Tech", "Politics")
urls <- c(
  "https://www.cnbc.com/business/",
  "https://www.cnbc.com/investing/",
  "https://www.cnbc.com/technology/",
  "https://www.cnbc.com/politics/"
)

# Create empty tbl
cnbc_tbl <- tibble(
  headline = character(),
  length = integer(),
  source = character()
)

# Loop through for each url
for(i in c(1:4)){
  # Get html for each page
  page_html <- read_html(urls[i])
  
  # Get headline for each page
  headlines <- html_text(html_elements(page_html, ".Card-title"))
  
  # Compile info for new row
  row <- tibble(
    headline = headlines,
    length = str_count(headline, " "),
    source = sections[i]
  )
  
  # Add row to tbl
  cnbc_tbl <- bind_rows(cnbc_tbl, row)
}


# Visualization
#Displays an appropriate tidyverse visualization of the relationship between source and length.

# Analysis
#Runs an ANOVA comparing mean lengths across the four sources, including calculating the p-value associated with that relationship. Don't worry about post-hoc tests. You will probably want to look at anova() and/or aov().

# Publication
# INSERT COMMENT
paste("The results of an ANOVA comparing lengths across sources was F(", INSERTDFN, INSERTDFD, ") = ", sub("^0\\.", ".", round(INSERTF, 2)), "p = ", sub("^0\\.", ".", round(INSERTP, 2)), ". This test ", ifelse(INSERTF < .05, "was", "was not"), " statistically significant.”)