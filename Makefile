submission/manuscript.pdf : submission/manuscript.rmd
	R -e 'rmarkdown::render("submission/manuscript.rmd", output_format = "all")'
