# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(RedditExtractoR)
library(ggplot2)

# Data Import and Cleaning
rstats_month_urls <- find_thread_urls(subreddit="rstats", period="month")
rstats_month_content <- get_thread_content(rstats_month_urls$url)
rstats_month_tbl <- rstats_month_content$threads %>%
  select(title, upvotes, comments)

# Visualization
ggplot(rstats_month_tbl, aes(x=upvotes, y=comments)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  scale_x_continuous("Upvotes") +
  scale_y_continuous("Comments") + 
  labs(title = "Past Month of Threads from r/rstats")

# Analysis
rstats_month_cor <- cor.test(rstats_month_tbl$upvotes, rstats_month_tbl$comments)
rstats_month_r <- rstats_month_cor$estimate
rstats_month_p <- rstats_month_cor$p.value
rstats_month_r
rstats_month_p

# Publication