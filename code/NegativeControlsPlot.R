#!/usr/bin/env Rscript
source("code/helpers/GenerateNcPlot.R")
library(tidyverse)
library(grid)

args <- commandArgs(trailingOnly = TRUE)
db <- as.character(args[1])
fileType <- as.character(args[2])

negativeControls <- readRDS("data/processed/negativeControls.rds") %>%
  filter(!is.na(seLogRr))

plotRiskStratifiedNegativeControls <- function(negativeControls) {
  riskStrata <- unique(negativeControls$riskStratum)
  plots <- list()
  for (i in seq_along(riskStrata)) {
    negativeControlsSubset <- negativeControls %>%
      filter(riskStratum == riskStrata[i])

    # null <- EmpiricalCalibration::fitNull(
    #   logRr   = log(negativeControlsSubset$estimate),
    #   seLogRr = negativeControlsSubset$seLogRr
    # )

    # plots[[i]] <- EmpiricalCalibration::plotCalibrationEffect(
    #   logRrNegatives   = log(negativeControlsSubset$estimate),
    #   seLogRrNegatives = negativeControlsSubset$seLogRr,
    #   null             = null
    # ) +
    #   ggtitle(paste("Q", i)) +
    #   theme(
    #     plot.title = element_text(size = 32),
    #     axis.title = element_blank()
    #   )
    plots[[i]] <- generateNcPlot(
      logRr   = log(negativeControlsSubset$estimate),
      seLogRr = negativeControlsSubset$seLogRr,
      trueLogRr        = rep(0, nrow(negativeControlsSubset))
    ) +
      ggtitle(paste("Q", i)) +
      theme(
        plot.title = element_text(size = 32),
        axis.title = element_blank()
      )
  }
  gridList <- list(
    plots[[1]] +
      theme(
        axis.title.x = ggplot2::element_blank(),
        axis.title.y = ggplot2::element_blank(),
        axis.text.x = element_blank()
      ),
    plots[[2]] + 
      theme(
        axis.title = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank()
      ),
    plots[[3]],
    plots[[4]] +
      theme(
        axis.title = element_blank(),
        axis.text.y = element_blank()
      )
  )

  bottom <- textGrob("Relative risk", gp = gpar(fontsize = 40))
  left <- textGrob("Standard error", gp = gpar(fontsize = 40), rot = 90)

  gridExtra::grid.arrange(
    grobs = gridList,
    nrow  = 2,
    bottom = bottom,
    left = left
  )
}

ncs <- negativeControls %>%
  filter(
    database == db,
    stratOutcome == 2
  )

plot <- plotRiskStratifiedNegativeControls(ncs)

# plot <- gridExtra::grid.arrange(pp[[1]], pp[[2]], pp[[3]], nrow = 3)
fileName <- paste0(
  paste(
    "NegativeControlsPlot",
    db,
    sep = "_"
  ),
  ".tiff"
)

ggsave(
  file.path(
    "figures",
    fileName
  ),
  plot, 
  compression = "lzw", 
  width       = 800, 
  height      = 450,
  units       = "mm",
  dpi         = 300
)

if (fileType == "tiff") {
  fileName <- paste0(
    paste(
      "NegativeControlsPlot",
      db,
      sep = "_"
    ),
    ".tiff"
  )
  ggsave(
    file.path(
      "figures",
      fileName
    ),
    plot, 
    compression = "lzw", 
    width       = 800, 
    height      = 450,
    units       = "mm",
    dpi         = 300
  )
} else if (fileType == "svg") {
  fileName <- paste0(
    paste(
      "NegativeControlsPlot",
      db,
      sep = "_"
    ),
    ".svg"
  )
  ggsave(
    file.path(
      "figures",
      fileName
    ),
    plot,
    width       = 800, 
    height      = 450,
    units       = "mm"
  )
}
