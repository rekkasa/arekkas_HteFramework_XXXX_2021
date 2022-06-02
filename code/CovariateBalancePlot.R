#!/usr/bin/env Rscript

library(tidyverse)
library(scales)

args <- commandArgs(trailingOnly = TRUE)
fileType <- as.character(args[1])

databases <- c("ccae", "mdcd", "mdcr")
map_exposures <- readRDS("data/processed/map_exposures.rds")
pp <- list()

for (i in seq_along(databases)) {
  pattern <- paste0("^balance.*", databases[i], ".*2_2.*.rds")
  pp[[i]] <- list.files(
    path = "data/processed",
    pattern = pattern,
    full.names = TRUE
  ) %>%
    readRDS() %>%
    bind_rows() %>%
    tibble() %>%	
    CohortMethod::plotCovariateBalanceScatterPlot(
      beforeLabel = "",
      afterLabel = toupper(databases[i])
    ) +
    scale_x_continuous(
      labels = comma_format(decimal.mark = intToUtf8("0x00B7"))
    ) +
    ggplot2::facet_grid(
      ~riskStratum
    ) +
    theme_bw() +
    theme(
      plot.title   = element_blank(),
      axis.title.x = element_blank(),
      axis.text.x  = element_text(size = 22),
      axis.text.y  = element_text(size = 22),
      axis.title   = element_text(size = 30),
      strip.text   = element_text(size = 25),
      strip.background = element_rect(colour = "black", fill = NA)
    )
  
  if (i != 1) {
    pp[[i]] <- pp[[i]] +
      theme(
        strip.text       = element_blank(),
        strip.background = element_blank()
      )
  }
}

plot <- gridExtra::grid.arrange(pp[[1]], pp[[2]], pp[[3]], nrow = 3)


if (fileType == "tiff") {
  fileName <- "CovariateBalance.tiff"
  ggsave(
    file.path(
      "figures",
      fileName
    ),
    plot, 
    compression = "lzw", 
    width       = 650, 
    height      = 350,
    units       = "mm",
    dpi         = 300
  )
} else if (fileType == "svg") {
  fileName <- "CovariateBalance.svg"
  ggsave(
    file.path(
      "figures",
      fileName
    ),
    plot, 
    width       = 650, 
    height      = 350,
    units       = "mm"
  )
}
