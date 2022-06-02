#!/usr/bin/env Rscript

library(tidyverse)
library(scales)

args <- commandArgs(trailingOnly = TRUE)
outcome <- as.character(args[1])
fileType <- as.character(args[2])

mappedOverallAbsoluteResults <- readRDS(
  "data/processed/mappedOverallAbsoluteResults.rds"
)
map_outcomes <- readRDS(
  "data/processed/map_outcomes.rds"
)
map_exposures <- readRDS(
  "data/processed/map_exposures.rds"
)

prepareDataset <- function(data) {
  data %>%
    left_join(
      map_outcomes,
      by = c("stratOutcome" = "outcome_id")
    ) %>%
    select(-stratOutcome) %>%
    rename("stratOutcome" = "outcome_name") %>%
    left_join(
      map_outcomes,
      by = c("estOutcome" = "outcome_id")
    ) %>%
    select(-estOutcome) %>%
    rename("estOutcome" = "outcome_name") %>%
    left_join(
      map_exposures,
      by = c("treatment" = "exposure_id")
    ) %>%
    select(-treatment) %>%
    rename("treatment" = "exposure_name") %>%
    left_join(
      map_exposures,
      by = c("comparator" = "exposure_id")
    ) %>%
    select(-comparator) %>%
    rename("comparator" = "exposure_name") %>%
    mutate(
      estOutcome = factor(
        estOutcome,
        rev(unique(estOutcome))
      )
    )
}


absolute <- prepareDataset(mappedOverallAbsoluteResults) %>%
  filter(
    stratOutcome == outcome
  ) %>%
  mutate(
    database = toupper(database),
    estimate = 100 * estimate,
    lower = 100 * lower,
    upper = 100 * upper,
    estOutcome = stringr::str_replace_all(estOutcome, "_", " "),
    stratOutcome = stringr::str_replace_all(stratOutcome, "_", " "),
    estOutcome = stringr::str_replace_all(estOutcome, "hospitalization", "hospitalisation"),
    estOutcome = stringr::str_replace_all(estOutcome, "emia", "aemia"),
    stratOutcome = stringr::str_replace_all(stratOutcome, "_", " "),
    stratOutcome = stringr::str_replace_all(stratOutcome, "hospitalization", "hospitalisation"),
    stratOutcome = stringr::str_replace_all(stratOutcome, "emia", "aemia"),
    outcomeType = ifelse(
      estOutcome %in% c(
        "acute myocardial infarction",
        "hospitalisation with heart failure",
        "stroke"
      ),
      "Main outcomes",
      "Safety outcomes"
    )
  )

absolutePlot <- ggplot(
  data = absolute,
  aes(
    x = riskStratum,
    y = estimate,
    ymin = lower,
    ymax = upper,
    color = estOutcome,
    group = estOutcome
  )
) +
  geom_point(size = 4.5, position = position_dodge(width = .6)) +
  geom_line(size = .8, position = position_dodge(width = .6), linetype = 2, alpha = .55) +
  geom_errorbar(position = position_dodge(width = .6), width = 0, size = 1.2) +
  scale_y_continuous(
    # trans = "log10",
    # limits = c(.6, 4.04),
    name = "Absolute risk reduction (%)",
    labels = comma_format(decimal.mark = intToUtf8("0x00B7"))
  ) +
  xlab("Risk quarter") +
  facet_grid(outcomeType ~ database, scales = "free") +
  geom_hline(
    aes(yintercept = 0)
  ) +
  scale_color_manual(
    values = c(
      "#264653",
      "#2A9D8F",
      "#E76F51",
      "#0450B4",
      "#1184A7",
      "#6FB1A0",
      "#B4418E",
      "#EA515F",
      "#FEA802"
    ),
    breaks = c(
      "acute myocardial infarction",
      "hospitalisation with heart failure",
      "stroke",
      "abnormal weight gain",
      "angioedema",
      "cough",
      "hyperkalaemia",
      "hypokalaemia",
      "hypotension"
    )
  ) +
  guides(col = guide_legend(nrow = 3)) +
  theme_bw() +
  theme(
    #legend.position = c(.2, .962),
    legend.position = "top",
    legend.title = element_blank(),
    legend.text = element_text(size = 32),
    # legend.background = element_rect(fill = "#a8dadc"),
    panel.grid.minor = element_blank(),
    axis.title = element_text(size = 32),
    axis.text = element_text(size = 25),
    strip.text = element_text(size = 35, color = "white"),
    strip.background = element_rect(fill = "#127475"),
    panel.spacing.y = unit(8, "mm")
  )

if (fileType == "tiff") {
  fileName <- paste0(
    paste(
      "CombinedAbsolute",
      outcome,
      sep = "_"
    ),
    ".tiff"
  )
  ggsave(
    file.path(
      "figures",
      fileName
    ),
    absolutePlot, 
    compression = "lzw", 
    width       = 650, 
    height      = 350,
    units       = "mm",
    dpi         = 300
  )
} else if (fileType == "svg") {
  fileName <- paste0(
    paste(
      "CombinedAbsolute",
      outcome,
      sep = "_"
    ),
    ".svg"
  )
  ggsave(
    file.path(
      "figures",
      fileName
    ),
    absolutePlot, 
    width       = 650, 
    height      = 350,
    units       = "mm"
  )
}


