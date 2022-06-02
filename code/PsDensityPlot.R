#!/usr/bin/env Rscript

library(tidyverse)
library(scales)


args <- commandArgs(trailingOnly = TRUE)
fileType <- as.character(args[1])

databases <- c("ccae", "mdcd", "mdcr")
map_exposures <- readRDS("data/processed/map_exposures.rds")
pp <- list()

for (i in seq_along(databases)) {
  pattern <- paste0("^ps.*", databases[i], ".*2_2.*.rds")
  pp[[i]] <- list.files(
    path = "data/processed",
    pattern = pattern,
    full.names = TRUE
  ) %>%
    readRDS() %>%
    dplyr::mutate(
      treatment = ifelse(
        treatment == 1,
        treatmentId,
        comparatorId
      )
    ) %>%
    dplyr::left_join(
    map_exposures,
    by = c("treatment" = "exposure_id")
  ) %>% 
    ggplot2::ggplot(
      ggplot2::aes(
        x = x,
        y = y
      )
    ) +
    ggplot2::geom_density(
      stat = "identity",
      ggplot2::aes(
        color = exposure_name,
        group = exposure_name,
        fill = exposure_name
      )
    ) +
    scale_x_continuous(
      breaks = seq(0, 1, .5),
      labels = comma_format(decimal.mark = intToUtf8("0x00B7"))
    ) +
    ggplot2::facet_grid(~riskStratum) +
    ggplot2::ylab(
      label = toupper(databases[i])
    ) +
    ggplot2::xlab(
      label = "Preference score"
    ) +
    ggplot2::scale_fill_manual(
      values = alpha(c("#fc8d59", "#91bfdb"), .6)
    ) +
    ggplot2::scale_color_manual(
      values = alpha(c("#fc8d59", "#91bfdb"), .9)
    ) +
    theme_classic() +
    ggplot2::theme(
      legend.title    = ggplot2::element_blank(),
      legend.position = "none",
      axis.title.x    = element_blank(),
      axis.line.y     = element_blank(),
      axis.ticks.y    = element_blank(),
      axis.text.y     = element_blank(),
      axis.text.x     = element_text(size = 22),
      axis.title      = element_text(size = 30),
      strip.text      = element_text(size = 25)
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
ggsave(
  "figures/PsDensity.tiff",
  plot, 
  compression = "lzw", 
  width       = 600, 
  height      = 350,
  units       = "mm",
  dpi         = 300
)

if (fileType == "tiff") {
  fileName <- "PsDensity.tiff"
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
  fileName <- "PsDensity.svg"
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


