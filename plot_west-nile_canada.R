### Plot Reported West Nile Cases in Canada ###
### Author: Jean-Paul R. Soucy ###

# Load libraries
library(ggplot2) # ggplot

# Load data
wn <- read.csv("https://raw.githubusercontent.com/jeanpaulrsoucy/west-nile-canada/master/west-nile_canada_2002-2019.csv",
                header = TRUE, stringsAsFactors = FALSE) # load data from GitHub

# Set most recent update date for data
date_current <- "2019-10-26"

# Plot time series with loess smoothing
ggplot(data = wn, aes(x = year, y = cases)) +
  # plot observed cases
  geom_point(color = "black") +
  # plot dashed line connecting observed cases
  geom_line(aes(color = "obs", linetype = "obs")) +
  # loess smoothing of time series (grey line)
  # fill = NA to remove CI - bounds are extremely large
  stat_smooth(
    aes(color = "smooth", linetype = "smooth"), fill = NA,
    method = "loess") +
  # label every two years on the x-axis
  scale_x_continuous(name = "Year", breaks = seq(min(wn$year), max(wn$year), 2)) +
  # label y-axis
  scale_y_continuous(name = "Cases", breaks = pretty(wn$cases), limits = c(0, max(pretty(wn$cases)))) +
  # create legend
  scale_color_manual(name = "Legend",
                     values = c("obs" = "black", "smooth" = "grey"),
                     labels = c("obs" = "Observed cases", "smooth" = "Smoothed value")) +
  scale_linetype_manual(name = "Legend",
                        values = c("obs" = "dashed", "smooth" = "solid"),
                        labels = c("obs" = "Observed cases", "smooth" = "Smoothed value")) +
  # add title and citation footnote
  labs(title = "Reported West Nile Cases in Canada, 2002–2019",
       caption = paste0(
         "Data provided by Public Health Agency of Canada (data current as of ",
         date_current, ").")) +
  # improve plot readability
  theme_classic() +
  theme(legend.position = c(0.85, 0.85), # legend to upper left
        legend.key.size = unit(30, "pt"), # increase size of legend elements
        legend.title = element_blank(),
        legend.text = element_text(size = 14),
        axis.title = element_text(size = 14),
        axis.title.x = element_text(margin = margin(t = 10)),
        axis.title.y = element_text(margin = margin(r = 10)),
        axis.text = element_text(size = 12, colour = "black"),
        plot.title = element_text(size = 16, hjust = 0.5), # centre title
        plot.caption = element_text(hjust = 0) # left justify caption
  )
