premergeShinyResults <- function(
  pathList,
  negativeControlPathList,
  saveDirectory
) {


  saveDir <- file.path(
    saveDirectory,
    "multipleRseeAnalyses"
  )

  if (!dir.exists(saveDir)) {
    dir.create(
      saveDir,
      recursive = TRUE
    )
  }

  createAnlysisPath <- function(
    path,
    file
  ) {
    res <- file.path(
      path,
      file
    )
    return(res)
  }

  mergeFun <- function(
    analysisDirs,
    file
  ) {
    lapply(
      analysisDirs,
      readRDS
    ) %>%
      dplyr::bind_rows() %>%
      saveRDS(
        file.path(
          saveDir,
          paste(
            file,
            "rds",
            sep = "."
          )
        )
      )
  }

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "analyses.rds"
  )
  lapply(
    analysisDirs,
    readRDS
  ) %>%
    plyr::join_all(
      type = "full"
    ) %>%
    saveRDS(
      file.path(
        saveDir,
        "analyses.rds"
      )
    )
  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "map_exposures.rds"
  )
  lapply(
    analysisDirs,
    readRDS
  ) %>%
    plyr::join_all(
      type = "full"
    ) %>%
    saveRDS(
      file.path(
        saveDir,
        "map_exposures.rds"
      )
    )

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "map_outcomes.rds"
  )
  lapply(
    analysisDirs,
    readRDS
  ) %>%
    plyr::join_all(
      type = "full"
    ) %>%
    saveRDS(
      file.path(
        saveDir,
        "map_outcomes.rds"
      )
    )

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "incidence.rds"
  )

  mergeFun(
    analysisDirs = analysisDirs,
    file = "incidence"
  )

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "incidenceOverall.rds"
  )

  mergeFun(
    analysisDirs = analysisDirs,
    file = "incidenceOverall"
  )

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "predictionPerformance.rds"
  )
  mergeFun(
    analysisDirs = analysisDirs,
    file = "predictionPerformance"
  )

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "mappedOverallResults.rds"
  )
  mergeFun(
    analysisDirs = analysisDirs,
    file = "mappedOverallResults"
  )

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "mappedOverallAbsoluteResults.rds"
  )
  mergeFun(
    analysisDirs = analysisDirs,
    file = "mappedOverallAbsoluteResults"
  )

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "mappedOverallRelativeResults.rds"
  )
  mergeFun(
    analysisDirs = analysisDirs,
    file = "mappedOverallRelativeResults"
  )

  analysisDirs <- sapply(
    pathList,
    createAnlysisPath,
    file = "mappedOverallCasesResults.rds"
  )
  mergeFun(
    analysisDirs = analysisDirs,
    file = "mappedOverallCasesResults"
  )

  if (length(negativeControlPathList) != 0) {
    analysisDirs <- sapply(
      negativeControlPathList,
      createAnlysisPath,
      file = "negativeControls.rds"
    )
    mergeFun(
      analysisDirs = analysisDirs,
      file = "negativeControls"
    )

    analysisDirs <- sapply(
      negativeControlPathList,
      createAnlysisPath,
      file = "mappedOverallResultsNegativeControls.rds"
    )
    mergeFun(
      analysisDirs = analysisDirs,
      file = "mappedOverallResultsNegativeControls"
    )
  }

  for (path in pathList) {
    filesToCopy <- list.files(
      path,
      pattern = "^overall|^auc|^bal|^ps|cal",
      full.names = TRUE
    )
    file.copy(
      filesToCopy,
      saveDir
    )
  }
}

pathList <- negativeControlPathList <- list.dirs("data/processed/", full.names = T, recursive = FALSE)
