#!/usr/bin/env Rscript

library(tidyverse)

tableCcae <- tibble(
  database = "ccae",
  outcome = c(
    "Acute myocardial infarction",
    rep("", 3),
    "Heart failure (hosp)",
    rep("", 3),
    "Stroke (ischemic or hemorrhagic)",
    rep("", 3)
  ),
  riskQuarter = rep(1:4, 3),
  patientsAce = c(
    161099, 204882, 214413, 204167,
    146259, 188006, 218052, 230226,
    146069, 187524, 217070, 226128
  ),
  personYearsAce = c(
    276171, 372197, 393583, 351727,
    249809, 341014, 399394, 400330,
    294484, 340234, 397830, 393861
  ),
  eventsAce = c(
    203, 534, 117, 2095,
    228, 457, 826, 2012,
    299, 554, 947, 1718
  ),
  patientsBeta = c(
    133977, 90193, 80662, 90908,
    126387, 84280, 83421, 98380,
    126264, 84000, 83038, 97628
  ),
  personYearsBeta = c(
    220633, 169231, 150035, 154419,
    206706, 158425, 155222, 169139,
    206453, 157913, 154587, 167810
  ),
  eventsBeta = c(
    135, 321, 535, 1520,
    378, 340, 570, 1773,
    320, 351, 521, 1077
  )
)

tableMdcr <- tibble(
  database = "mdcr",
  outcome = c(
    "Acute myocardial infarction",
    rep("", 3),
    "Heart failure (hosp)",
    rep("", 3),
    "Stroke (ischemic or hemorrhagic)",
    rep("", 3)
  ),
  riskQuarter = rep(1:4, 3),
  patientsAce = c(
    27853,
    27596,
    25893,
    20319,
    27530,
    27486,
    25482,
    19704,
    27291,
    27054,
    24763,
    18666
  ),
  personYearsAce = c(
    57541,
    56910,
    53202,
    38710,
    56886,
    56644,
    52475,
    37842,
    56413,
    55846,
    50976,
    35775
  ),
  eventsAce = c(
    231,
    387,
    560,
    828,
    364,
    582,
    965,
    1578,
    375,
    490,
    752,
    979
  ),
  patientsBeta = c(
    15057,
    15134,
    17017,
    22590,
    14847,
    15183,
    16500,
    20746,
    14734,
    15011,
    16209,
    20905
  ),
  personYearsBeta = c(
    32627,
    32861,
    35187,
    42073,
    32183,
    32622,
    34234,
    39414,
    31988,
    32220,
    33763,
    39444
  ),
  eventsBeta = c(
    142,
    238,
    404,
    903,
    317,
    482,
    865,
    2109,
    229,
    371,
    629,
    1094
  )
)

tableMdcd <- tibble(
  database = "mdcd",
  outcome = c(
    "Acute myocardial infarction",
    rep("", 3),
    "Heart failure (hosp)",
    rep("", 3),
    "Stroke (ischemic or hemorrhagic)",
    rep("", 3)
  ),
  riskQuarter = rep(1:4, 3),
  patientsAce = c(
    14347,
    18412,
    18893,
    15168,
    18004,
    18190,
    17386,
    11775,
    17963,
    18063,
    17129,
    11917
  ),
  personYearsAce = c(
    19972,
    26737,
    31231,
    27383,
    25006,
    27253,
    29261,
    21440,
    24939,
    27086,
    28846,
    21627
  ),
  eventsAce = c(
    15,
    99,
    226,
    561,
    87,
    208,
    453,
    970,
    59,
    180,
    356,
    536
  ),
  patientsBeta = c(
    13858,
    9793,
    9312,
    13036,
    16028,
    9108,
    8618,
    9928,
    15996,
    9045,
    8582,
    10891
  ),
  personYearsBeta = c(
    17056,
    14180,
    15041,
    22158,
    20042,
    13527,
    14219,
    17197,
    19991,
    13411,
    14155,
    18601
  ),
  eventsBeta = c(
    20,
    53,
    174,
    587,
    120,
    138,
    340,
    1155,
    46,
    104,
    208,
    573
  )
)

table <- tableCcae %>% bind_rows(tableMdcd) %>% bind_rows(tableMdcr)
readr::write_csv(table, "data/processed/table1.csv")
