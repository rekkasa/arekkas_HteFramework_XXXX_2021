library(tidyverse)

mappedOverallRelativeResults <- readRDS(
  "~/Documents/Projects/arekkas_HteFramework_XXXX_2021/.scratch/AceBeta9Outcomes/data/mappedOverallRelativeResults.rds"
)
mappedOverallAbsoluteResults <- readRDS(
  "~/Documents/Projects/arekkas_HteFramework_XXXX_2021/.scratch/AceBeta9Outcomes/data/mappedOverallAbsoluteResults.rds"
)
map_outcomes <- readRDS(
  "~/Documents/Projects/arekkas_HteFramework_XXXX_2021/.scratch/AceBeta9Outcomes/data/map_outcomes.rds"
)
map_exposures <- readRDS(
  "~/Documents/Projects/arekkas_HteFramework_XXXX_2021/.scratch/AceBeta9Outcomes/data/map_exposures.rds"
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
  )

ggplot(
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
    position = position_dodge(.5)
  ) +
  geom_errorbar(
    position = position_dodge(.5),
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
      "mdcr",
      "mdcd",
      "ccae"
    )
  ) +
  theme_bw() +
  theme(
    legend.position = "top",
    legend.title = element_blank(),
    axis.title.y = element_blank(),
    strip.background = element_rect(
      fill = "#ffffff"
    )
  )


absolute <- prepareDataset(mappedOverallAbsoluteResults) %>%
  filter(
    stratOutcome == "Acute myocardial infarction",
    estOutcome != "Cough"
  )

ggplot(
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
    position = position_dodge(.5)
  ) +
  geom_errorbar(
    position = position_dodge(.5),
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
      "mdcr",
      "mdcd",
      "ccae"
    )
  ) +
  theme_bw() +
  theme(
    legend.position = "top",
    legend.title = element_blank(),
    axis.title.y = element_blank(),
    strip.background = element_rect(
      fill = "#ffffff"
    )
  )

