figures/CombinedAbsolute.tiff figures/CombinedRelative.tiff : code/CombinedPlots.R\
	                                                      data/processed/mappedOverallRelativeResults.rds\
	                                                      data/processed/mappedOverallAbsoluteResults.rds\
							      data/processed/map_outcomes.rds\
							      data/processed/map_exposures.rds
	$<

data/processed/table1.csv : code/Table1.R
	$<

submission/manuscript.pdf : submission/manuscript.rmd\
	                    data/processed/table1.csv
	R -e 'rmarkdown::render("submission/manuscript.rmd", output_format = "all")'
