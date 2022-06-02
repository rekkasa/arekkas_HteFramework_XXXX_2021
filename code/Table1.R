#!/usr/bin/env Rscript

library(tidyverse)

map_outcomes <- readRDS("data/processed/map_outcomes.rds")
map_exposures <- readRDS("data/processed/map_exposures.rds")

incidence <- readRDS("data/processed/incidence.rds") %>%
  select(
    database,
    treatmentId,
    comparatorId,
    stratOutcome,
    estOutcome,
    riskStratum,
    treatmentPersons,
    comparatorPersons,
    treatmentDays,
    comparatorDays,
    treatmentOutcomes,
    comparatorOutcomes
  ) %>%
  left_join(map_outcomes, by = c("stratOutcome" = "outcome_id")) %>%
  select(-stratOutcome) %>%
  rename("stratOutcome" = "outcome_name") %>%
  left_join(map_outcomes, by = c("estOutcome" = "outcome_id")) %>%
  select(-estOutcome) %>%
  rename("estOutcome" = "outcome_name") %>%
  left_join(map_exposures, by = c("treatmentId" = "exposure_id")) %>%
  select(-treatmentId) %>%
  rename("treatment" = "exposure_name") %>%
  left_join(map_exposures, by = c("comparatorId" = "exposure_id")) %>%
  select(-comparatorId) %>%
  rename("comparator" = "exposure_name") %>%
  filter(
    estOutcome %in% c(
      "acute_myocardial_infarction",
      "hospitalization_with_heart_failure",
      "stroke"
    ),
    stratOutcome == "acute_myocardial_infarction"
  ) %>%
  mutate(
    treatmentDays = round(treatmentDays / 365),
    comparatorDays = round(comparatorDays / 365),
    stratOutcome =  factor(
    stratOutcome,
    levels = c(
      "acute_myocardial_infarction",
      "hospitalization_with_heart_failure",
      "stroke"
    ),
    labels = c(
        "acute myocardial infarction",
        "hospitalization with heart failure",
        "stroke"
      )
    ),
    estOutcome =  factor(
    estOutcome,
    levels = c(
      "acute_myocardial_infarction",
      "hospitalization_with_heart_failure",
      "stroke"
    ),
    labels = c(
        "acute myocardial infarction",
        "hospitalization with heart failure",
        "stroke"
      )
    )
  )

readr::write_csv(incidence, "data/processed/supp_table1.csv")
