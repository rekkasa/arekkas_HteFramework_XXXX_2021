figures/CombinedRelative_acute_myocardial_infarction.tiff : code/CombinedRelativePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< acute_myocardial_infarction tiff

figures/CombinedRelative_hospitalization_with_heart_failure.tiff : code/CombinedRelativePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< hospitalization_with_heart_failure tiff

figures/CombinedRelative_stroke.tiff : code/CombinedRelativePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< stroke tiff

figures/CombinedAbsolute_acute_myocardial_infarction.tiff : code/CombinedAbsolutePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< acute_myocardial_infarction tiff

figures/CombinedAbsolute_hospitalization_with_heart_failure.tiff : code/CombinedAbsolutePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< hospitalization_with_heart_failure tiff

figures/CombinedAbsolute_stroke.tiff : code/CombinedAbsolutePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< stroke tiff

figures/CombinedRelative_acute_myocardial_infarction.svg : code/CombinedRelativePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< acute_myocardial_infarction svg

figures/CombinedRelative_hospitalization_with_heart_failure.svg : code/CombinedRelativePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< hospitalization_with_heart_failure svg

figures/CombinedRelative_stroke.svg : code/CombinedRelativePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< stroke svg

figures/CombinedAbsolute_acute_myocardial_infarction.svg : code/CombinedAbsolutePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< acute_myocardial_infarction svg

figures/CombinedAbsolute_hospitalization_with_heart_failure.svg : code/CombinedAbsolutePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< hospitalization_with_heart_failure svg

figures/CombinedAbsolute_stroke.svg : code/CombinedAbsolutePlots.R\
  data/processed/mappedOverallRelativeResults.rds\
  data/processed/mappedOverallAbsoluteResults.rds\
  data/processed/map_outcomes.rds\
  data/processed/map_exposures.rds
	$< stroke svg

figures/CovariateBalance.tiff : code/CovariateBalancePlot.R\
	data/processed/map_exposures.rds\
	data/processed/balance_ccae_ccae_Stratify\ on\ PS_1_17_2_2.rds\
	data/processed/balance_mdcd_mdcd_Stratify\ on\ PS_1_17_2_2.rds\
	data/processed/balance_mdcr_mdcr_Stratify\ on\ PS_1_17_2_2.rds
	$< tiff

figures/CovariateBalance.svg : code/CovariateBalancePlot.R\
	data/processed/map_exposures.rds\
	data/processed/balance_ccae_ccae_Stratify\ on\ PS_1_17_2_2.rds\
	data/processed/balance_mdcd_mdcd_Stratify\ on\ PS_1_17_2_2.rds\
	data/processed/balance_mdcr_mdcr_Stratify\ on\ PS_1_17_2_2.rds
	$< svg

figures/PsDensity.tiff : code/PsDensityPlot.R\
	data/processed/map_exposures.rds\
	data/processed/psDensity_ccae_ccae_Stratify\ on\ PS_1_17_2_2.rds\
	data/processed/psDensity_mdcd_mdcd_Stratify\ on\ PS_1_17_2_2.rds\
	data/processed/psDensity_mdcr_mdcr_Stratify\ on\ PS_1_17_2_2.rds
	$< tiff

figures/PsDensity.svg : code/PsDensityPlot.R\
	data/processed/map_exposures.rds\
	data/processed/psDensity_ccae_ccae_Stratify\ on\ PS_1_17_2_2.rds\
	data/processed/psDensity_mdcd_mdcd_Stratify\ on\ PS_1_17_2_2.rds\
	data/processed/psDensity_mdcr_mdcr_Stratify\ on\ PS_1_17_2_2.rds
	$< svg

figures/NegativeControlsPlot.tiff : code/NegativeControlsPlot.R\
	code/helpers/GenerateNcPlot.R\
	data/processed/negativeControls.rds
	$<

figures/NegativeControlsPlot_ccae.tiff : code/NegativeControlsPlot.R\
	code/helpers/GenerateNcPlot.R\
	data/processed/negativeControls.rds
	$< ccae tiff

figures/NegativeControlsPlot_mdcd.tiff : code/NegativeControlsPlot.R\
	code/helpers/GenerateNcPlot.R\
	data/processed/negativeControls.rds
	$< mdcd tiff

figures/NegativeControlsPlot_mdcr.tiff : code/NegativeControlsPlot.R\
	code/helpers/GenerateNcPlot.R\
	data/processed/negativeControls.rds
	$< mdcr tiff

figures/NegativeControlsPlot_ccae.svg : code/NegativeControlsPlot.R\
	code/helpers/GenerateNcPlot.R\
	data/processed/negativeControls.rds
	$< ccae svg

figures/NegativeControlsPlot_mdcd.svg : code/NegativeControlsPlot.R\
	code/helpers/GenerateNcPlot.R\
	data/processed/negativeControls.rds
	$< mdcd svg

figures/NegativeControlsPlot_mdcr.svg : code/NegativeControlsPlot.R\
	code/helpers/GenerateNcPlot.R\
	data/processed/negativeControls.rds
	$< mdcr svg

data/processed/table1.csv : code/Table1.R
	$<

submission/manuscript.pdf : submission/manuscript.rmd\
	submission/references.bib\
	data/processed/table1.csv\
	figures/NegativeControlsPlot_ccae.tiff\
	figures/PsDensity.tiff\
	figures/CovariateBalance.tiff\
	figures/CombinedRelative_acute_myocardial_infarction.tiff\
	figures/CombinedAbsolute_acute_myocardial_infarction.tiff
	R -e 'rmarkdown::render("submission/manuscript.rmd", output_format = "bookdown::pdf_document2")'

submission/manuscript.docx : submission/manuscript.rmd\
	data/processed/table1.csv\
	submission/reference.docx
	R -e 'rmarkdown::render("submission/manuscript.rmd", output_format = "bookdown::word_document2")'


.PHONY: supplement_figures svg_figures manuscript_figures
supplement_figures : 
	make figures/CombinedRelative_stroke.tiff;
	make figures/CombinedAbsolute_stroke.tiff;
	make figures/CombinedRelative_hospitalization_with_heart_failure.tiff;
	make figures/CombinedAbsolute_hospitalization_with_heart_failure.tiff;
	make figures/NegativeControlsPlot_ccae.tiff;
	make figures/NegativeControlsPlot_mdcd.tiff;
	make figures/NegativeControlsPlot_mdcr.tiff;
	make figures/PsDensity.tiff;
	make figures/CovariateBalance.tiff;

svg_figures : 
	make figures/CombinedRelative_acute_myocardial_infarction.svg;
	make figures/CombinedAbsolute_acute_myocardial_infarction.svg;
	make figures/CombinedRelative_hospitalization_with_heart_failure.svg;
	make figures/CombinedAbsolute_hospitalization_with_heart_failure.svg;
	make figures/CombinedRelative_stroke.svg;
	make figures/CombinedAbsolute_stroke.svg;
	make figures/PsDensity.svg;
	make figures/CovariateBalance.svg;
	make figures/NegativeControlsPlot_ccae.svg;
	make figures/NegativeControlsPlot_mdcd.svg;
	make figures/NegativeControlsPlot_mdcr.svg;

manuscript_figures :
	make figures/CombinedRelative_acute_myocardial_infarction.tiff;
	make figures/CombinedAbsolute_acute_myocardial_infarction.tiff;
