figures/CombinedAbsolute.tiff figures/CombinedRelative.tiff : code/CombinedPlots.R\
	data/processed/mappedOverallRelativeResults.rds\
	data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$<

figures/CovariateBalance.tiff : code/CovariateBalancePlot.R\
  data/processed/balance_ccae_stratifyByPs_1001_1002_104_104.rds\
  data/processed/balance_mdcd_stratifyByPs_1001_1002_104_104.rds\
  data/processed/balance_mdcr_stratifyByPs_1001_1002_104_104.rds
	$<

figures/PsDensity.tiff : code/PsDensityPlot.R\
	data/processed/psDensity_ccae_stratifyByPs_1001_1002_104_104.rds\
  data/processed/psDensity_mdcd_stratifyByPs_1001_1002_104_104.rds\
  data/processed/psDensity_mdcr_stratifyByPs_1001_1002_104_104.rds
	$<

data/processed/table1.csv : code/Table1.R
	$<

submission/manuscript.pdf : submission/manuscript.rmd\
	data/processed/table1.csv
	R -e 'rmarkdown::render("submission/manuscript.rmd", output_format = "bookdown::pdf_document2")'
