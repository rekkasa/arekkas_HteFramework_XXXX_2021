#!/usr/bin/env Rscript

library(tidyverse)

databases <- c("ccae", "mdcd", "mdcr")
pp <- list()

for (i in seq_along(databases)) {
  pattern <- paste0("^bal.*", databases[i], ".*104_104*.rds")
  pp[[i]] <- list.files(
    path = ".scratch/AceBeta9Outcomes/data",
    pattern = pattern,
    full.names = TRUE
  ) %>%
    map(readRDS) %>%
    bind_rows() %>%
    tibble() %>%	
    CohortMethod::plotCovariateBalanceScatterPlot(
      beforeLabel = "",
      afterLabel = toupper(databases[i])
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
ggsave(
  "figures/CovariateBalance.tiff",
  plot, 
  compression = "lzw", 
  width       = 600, 
  height      = 350,
  units       = "mm",
  dpi         = 300
)
