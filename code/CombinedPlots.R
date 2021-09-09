#!/usr/bin/env Rscript

library(tidyverse)

mappedOverallRelativeResults <- readRDS(
  "data/processed/mappedOverallRelativeResults.rds"
)
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


relative <- prepareDataset(mappedOverallRelativeResults) %>%
  filter(
    stratOutcome == "Acute myocardial infarction"
  ) %>%
  mutate(
    database = toupper(database)
  )

relativePlot <- ggplot(
  data = relative,
  aes(
    y = estOutcome,
    x = estimate,
    color = database,
    xmin = lower,
    xmax = upper
  )
) +
  geom_point(
    position = position_dodge(.5),
    size     = 3.5
  ) +
  geom_errorbar(
    position = position_dodge(.5),
    size = 1.1,
    width = 0
  ) +
  facet_grid(~riskStratum) +
  geom_vline(
    aes(xintercept = 1),
    linetype = "dashed"
  ) +
  xlab("Hazard ratio") +
  scale_color_manual(
    values = c(
      "#66c2a5",
      "#fc8d62",
      "#8da0cb"
    ),
    breaks = c(
      "MDCR",
      "MDCD",
      "CCAE"
    )
  ) +
  theme_bw() +
  theme(
    legend.position = "top",
    legend.title = element_blank(),
    axis.title.y = element_blank(),
    axis.text.x  = element_text(size = 25),
    axis.text.y  = element_text(size = 25),
    axis.title   = element_text(size = 35),
    legend.text  = element_text(size = 30), 
    strip.text   = element_text(size = 25),
    strip.background = element_rect(
      fill = "#ffffff"
    ),
  )

ggsave(
  "figures/CombinedRelative.tiff",
  relativePlot, 
  compression = "lzw", 
  width       = 600, 
  height      = 350,
  units       = "mm",
  dpi         = 300
)



absolute <- prepareDataset(mappedOverallAbsoluteResults) %>%
  filter(
    stratOutcome == "Acute myocardial infarction"
    # estOutcome != "Cough"
  ) %>%
  mutate(
    database = toupper(database)
  )

absolutePlot <- ggplot(
  data = absolute,
  aes(
    y = estOutcome,
    x = estimate,
    color = database,
    xmin = lower,
    xmax = upper
  )
) +
  geom_point(
    position = position_dodge(.5),
    size = 3.5
  ) +
  geom_errorbar(
    position = position_dodge(.5),
    size = 1.1,
    width = 0
  ) +
  facet_grid(~riskStratum) +
  geom_vline(
    aes(xintercept = 0),
    linetype = "dashed"
  ) +
  xlab("Absolute risk reduction (%)") +
  scale_color_manual(
    values = c(
      "#66c2a5",
      "#fc8d62",
      "#8da0cb"
    ),
    breaks = c(
      "MDCR",
      "MDCD",
      "CCAE"
    )
  ) +
  theme_bw() +
  theme(
    legend.position = "top",
    legend.title = element_blank(),
    axis.title.y = element_blank(),
    axis.text.x  = element_text(size = 25),
    axis.text.y  = element_text(size = 25),
    axis.title   = element_text(size = 35),
    legend.text  = element_text(size = 30), 
    strip.text   = element_text(size = 25),
    strip.background = element_rect(
      fill = "#ffffff"
    ),
  )

ggsave(
  "figures/CombinedAbsolute.tiff",
  absolutePlot, 
  compression = "lzw", 
  width       = 600, 
  height      = 350,
  units       = "mm",
  dpi         = 300
)

