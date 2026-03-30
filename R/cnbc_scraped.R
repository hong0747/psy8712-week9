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
ggplot(cnbc_tbl, aes(x=source, y=length)) +
  geom_boxplot() +
  scale_x_discrete("Source") +
  scale_y_continuous("Length") + 
  labs(title = "Length of Headlines by Source")

# Analysis
cnbc_aov <- aov(length ~ source, data = cnbc_tbl)
cnbc_aov_summary <- summary(cnbc_aov)
cnbc_aov_summary
cnbc_F <- cnbc_aov_summary[[1]]$`F value`[1]
cnbc_p <- cnbc_aov_summary[[1]]$`Pr(>F)`[1]
cnbc_df_1 <- cnbc_aov_summary[[1]]$Df[1]
cnbc_df_2 <- cnbc_aov$df.residual

# Publication
# The results of an ANOVA comparing lengths across sources was F(3, 130) = 3.08, p = .03. This test was statistically significant.
paste("The results of an ANOVA comparing lengths across sources was F(", cnbc_df_1, ", ", cnbc_df_2, ") = ", sub("^0\\.", ".", round(cnbc_F, 2)), ", p = ", sub("^0\\.", ".", round(cnbc_p, 2)), ". This test ", ifelse(cnbc_p < .05, "was", "was not"), " statistically significant.", sep="")