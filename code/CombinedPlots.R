#!/usr/bin/env Rscript

library(tidyverse)

mappedOverallRelativeResults <- readRDS(
  "data/processed/multipleRseeAnalyses/mappedOverallRelativeResults.rds"
)
mappedOverallAbsoluteResults <- readRDS(
  "data/processed/multipleRseeAnalyses/mappedOverallAbsoluteResults.rds"
)
map_outcomes <- readRDS(
  "data/processed/multipleRseeAnalyses/map_outcomes.rds"
)
map_exposures <- readRDS(
  "data/processed/multipleRseeAnalyses/map_exposures.rds"
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
    stratOutcome == "acute_myocardial_infarction"
  ) %>%
  mutate(
    database = toupper(database),
    estOutcome = stringr::str_replace_all(estOutcome, "_", " "),
    stratOutcome = stringr::str_replace_all(stratOutcome, "_", " "),
    outcomeType = ifelse(
      estOutcome %in% c(
        "acute myocardial infarction",
        "hospitalization with heart failure",
        "stroke"
      ),
      "Main",
      "Safety"
    )
    # estimate = log(estimate),
    # lower = log(lower),
    # upper = log(upper)
  )

relativePlot <- ggplot(
  data = relative,
  aes(
    x = riskStratum,
    y = estimate,
    color = estOutcome,
    group = estOutcome
  )
) +
  geom_point(
    #position = position_dodge(.5),
    size     = 3.5
  ) +
  geom_line() +
  facet_grid(outcomeType ~ database, scales = "free") +
  geom_hline(
    aes(yintercept = 1),
    linetype = "dashed"
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
      "hospitalization with heart failure",
      "stroke",
      "abnormal weight gain",
      "angioedema",
      "cough",
      "hyperkalemia",
      "hypokalemia",
      "hypotension"
    )
  ) +
  theme_bw() +
  theme(legend.position = "top")

# relativePlotSafety <- ggplot(
#   data = relative %>%
#     filter(
#       !(estOutcome %in% c(
#         "acute myocardial infarction",
#         "hospitalization with heart failure",
#         "stroke"
#       )
#     )),
#   aes(
#     x = riskStratum,
#     y = estimate,
#     color = estOutcome,
#     group = estOutcome,
#   )
# ) +
#   geom_point(
#     #position = position_dodge(.5),
#     size     = 3
#   ) +
#   geom_line() +
#   facet_wrap(~database) +
#   scale_color_manual(
#     values = c(
#       "#0450B4",
#       "#1184A7",
#       "#6FB1A0",
#       "#B4418E",
#       "#EA515F",
#       "#FEA802"
#     ),
#     breaks = c(
#       "abnormal weight gain",
#       "angioedema",
#       "cough",
#       "hyperkalemia",
#       "hypokalemia",
#       "hypotension"
#     )
#   ) +
#   theme_bw() +
#   theme(legend.position = "bottom")
# 
# 
# relativePlot <- cowplot::plot_grid(
#   plotlist = list(relativePlotMain, relativePlotSafety),
#   ncol = 1
# )

ggsave(
  "figures/CombinedRelative.tiff",
  relativePlot, 
  compression = "lzw", 
  width       = 600, 
  height      = 350,
  units       = "mm",
  dpi         = 300
)



# absolute <- prepareDataset(mappedOverallAbsoluteResults) %>%
#   filter(
#     stratOutcome == "acute_myocardial_infarction"
#     # estOutcome != "Cough"
#   ) %>%
#   mutate(
#     database = toupper(database),
#     estimate = 100 * estimate,
#     lower    = 100 * lower,
#     upper    = 100 * upper,
#     estOutcome = stringr::str_replace_all(estOutcome, "_", " ")
#   )
# 
# absolutePlot <- ggplot(
#   data = absolute,
#   aes(
#     y = estOutcome,
#     x = estimate,
#     color = database,
#     xmin = lower,
#     xmax = upper
#   )
# ) +
#   geom_point(
#     position = position_dodge(.5),
#     size = 3.5
#   ) +
#   geom_errorbar(
#     position = position_dodge(.5),
#     size = 1.1,
#     width = 0
#   ) +
#   facet_grid(~riskStratum) +
#   geom_vline(
#     aes(xintercept = 0),
#     linetype = "dashed"
#   ) +
#   xlab("Absolute risk reduction (%)") +
#   scale_color_manual(
#     values = c(
#       "#66c2a5",
#       "#fc8d62",
#       "#8da0cb"
#     ),
#     breaks = c(
#       "MDCR",
#       "MDCD",
#       "CCAE"
#     )
#   ) +
#   theme_bw() +
#   theme(
#     legend.position = "top",
#     legend.title = element_blank(),
#     axis.title.y = element_blank(),
#     axis.text.x  = element_text(size = 25),
#     axis.text.y  = element_text(size = 25),
#     axis.title   = element_text(size = 35),
#     legend.text  = element_text(size = 30), 
#     strip.text   = element_text(size = 25),
#     strip.background = element_rect(
#       fill = "#ffffff"
#     ),
#   )
# 
# ggsave(
#   "figures/CombinedAbsolute.tiff",
#   absolutePlot, 
#   compression = "lzw", 
#   width       = 600, 
#   height      = 350,
#   units       = "mm",
#   dpi         = 300
# )


# relativePlot <- ggplot(
#   data = relative,
#   aes(
#     y = estOutcome,
#     x = estimate,
#     color = database,
#     xmin = lower,
#     xmax = upper
#   )
# ) +
#   geom_point(
#     position = position_dodge(.5),
#     size     = 3.5
#   ) +
#   geom_errorbar(
#     position = position_dodge(.5),
#     size = 1.1,
#     width = 0
#   ) +
#   facet_grid(~riskStratum) +
#   geom_vline(
#     aes(xintercept = 1),
#     linetype = "dashed"
#   ) +
#   xlab("Hazard ratio") +
#   scale_color_manual(
#     values = c(
#       "#66c2a5",
#       "#fc8d62",
#       "#8da0cb"
#     ),
#     breaks = c(
#       "MDCR",
#       "MDCD",
#       "CCAE"
#     )
#   ) +
#   theme_bw() +
#   theme(
#     legend.position = "top",
#     legend.title = element_blank(),
#     axis.title.y = element_blank(),
#     axis.text.x  = element_text(size = 25),
#     axis.text.y  = element_text(size = 25),
#     axis.title   = element_text(size = 35),
#     legend.text  = element_text(size = 30), 
#     panel.grid.minor = ggplot2::element_blank(),
#     panel.grid.major.y = ggplot2::element_blank(),
#     strip.text   = element_text(size = 25),
#     strip.background = element_rect(
#       fill = "#ffffff"
#     ),
#   )
