# Reviewer 1
## Points
  - Structuring and descriptions are not well organized
  - What is new? If it is the use of OMOP it's not demonstrated
    well (presentation of only one database, no explicit reference
    to OMOP, etc)
  - No explicit reference to the publicly available code until the
    very end of the paper
  - INTRODUCTION
    - Make contributions clear
    - Would be good to write the introduction as a motivation for
      the listed contributions
  - BACKGROUND
    - There is no background section
    - Cover relevant literature (methods, OHDSI, OMOP)
  - MATERIALS AND METHODS
    - Figure 1 is not referenced in the main text. Also it is 
      too schematic and hard to understand. What is its purpose?
    - Define cohorts properly
    - Define the matching process
    - Make the model more structured, e.g. what happens if outcome
      appears after the 2 years? Is there this flexibility?
    - The framework uses a case-control (??) design. Make clear
      that this the desired setting.
    - There should be an `Evaluation` section coming before the
      `Results` section
  - RESULTS
    - The example doesn't demonstrate the power of OMOP
    - Results are demonstrated in multiple figures. What is their
      purpose? Also, refer to figures in the main text
  - DISCUSSION
    - Why use this specific package instead of the alternatives?
    - What makes your framework standardized?
    - At the end of the discussion it is said that a proof of concept 
      was demonstrated. what is the concept? what is the proof? it is 
      said that it is easily applicable and highly informative: in 
      what respect? how is it demonstrated in the paper?
## Comments
  - Figure **is** referenced in text (p4.7). Maybe need to expand a bit
    more on the presentation of the figure
  - We are not using a case-control design. It's maybe useful
    to define which setting is required (T-C-O cohorts, etc). Isn't that
    already described in Step 1, though?
  - Figure 1 is not really an overview of the steps, but rather a
    presentation of steps 3 and 4. Maybe move later in the text?
  - Evaluation should always be carried out before the results. Since
    analyses are carried out in one go, evaluation metrics/graphics
    are generated at the same time with the results. It's in the hands
    of the researcher to thoroughly go over the evaluation first

# Reviewer 2
## Points
  - Lack of specificity: causal parameter of interest, 
    representativeness of the sample of the target population,
    the explicit assumptions made and the validity of these assumptions.
    The manuscript does not provide enough detail and precision for 
    the key features of causal inference
  - How is multiplicity handled (9 outcomes and, for each, produce 4 
    treatment effectiveness estimates, without any control for 
    multiplicity of inference)?
  - More thorough analysis of the worked example.
  - ABSTRACT
    - What is the "OHDSI Methods Library"?
  - APPROACH
    - What is the causal question? ATE or ATT?
    - Provide more guidance for the selection of the database
    - Define `Target cohort`. That is not standard causal inference
      terminology
    - Data is used twice, once for prediction and once for estimation.
      This seems incorrect. Justify and explain how standard errors and
      estimates are impacted
    - Why use PS matching before developing the prediction model? Why
      not using other methods (e.g. weighting)?
    - Do you estimate different risk strata for each outcome?
    - Poolability of datasets: the error in estimation may 
      differ across databases. Kindly indicate how poolability 
      of the datasets is determined
    - Why quartiles? Perhaps comment on how much variation in 
      the predictions is required to create a fixed number of risk 
      strata
    - Are you re-estimating the propensity score again, within each 
      stratum? Please provide justification, How does this impact the 
      estimator (that is, two design effects of matching)?
    - Step 5: Covariate balance should occur before treatment effect
      estimation
  - RESULTS
    - Step 1: What is meant by "one year follow-up"? Maybe related to
      database restrictions. What about age or comorbidity restrictions?
    - The sampling frame for MarketScan should be described, the 
      completeness of the data (does MarketScan Medicaid data 
      include those under managed care arrangements or just fee 
      for service), are you looking a dually-eligible individuals, 
      what are the pharmacy benefits (for instance, the Medicare 
      beneficiaries need to be enrolled in Part D), how many 
      diagnosis codes are used (Medicaid typically records fewer 
      than Medicare which will lead to differential ascertainment), etc
    - Step 3: What constitutes censoring?
    - What about competing risks (death is a competing risk)?
    - How was covariate balance and overlap assessed?
    - Was the proportional hazards assumption met?
    - The matched design effects should be included in the estimation 
      step (e.g., strata = pairs)
    - Adjust confidence intervals for multiplicity
    - Include an analysis assessing how sensitive findings are to 
      unmeasured confounding
    - Supply authors of reference 28

## Comments
  - We demonstrate covariate balance and overlap in the supplement for
    a single database. Should we do it for all and/or move to main
    manuscript?
  - Write paragraph and include 1 figure about the combined results
    across all databases
  - Part of the response for the multiplicity issues could be the part
    from the LEGEND-Hypertension paper: the package provides you with 
    all the results across as many data sources as you like and then
    it's up to you to correct for multiplicity (Discussion section, 
    Lancet). The same for pooling?
  - Reason for re-estimating PS in strata. Find references from
    subgroup analyses in observational data

# Reviewer 3
## Points
  - HTE analysis has been used in the RCT setting and not in the
    observational. Add more references about it or include a
    comparative RCT study
  - Add review content and references in the `Introduction` section
  - Emphasize the novelty of the method
  - Move some parts from `Results` to `Methods` to improve readability
  - Subsection 3.4: Provide more details about the estimation results
  - Include results from other databases (currently in `Supplement`)
    to demonstrate robustness
  - Section 3.3, line 28 - 30. The sentence "We chose a time horizon 
    of 2 years after inclusion into the target cohort…" is duplicated
## Comments

# Reviewer 4
## Points
  -  In abstract should spell out OMOP before using it
  -  In the legend for Fig 1 and related text in manuscript, the term 
     'quartile' would be more appropriate than 'quarter'. For item C 
     suggest 'the prediction model to the entire population'. Also for 
     item D in this legend suggest 'We separate into risk subgroups'
  - page 6 line 4: quartiles instead of quarters
  - On page 7, lines 2-3 suggest the following: 'As a proof of 
    concept, ... to beta blockers. The former are among the most ...'
  - page 7 line 17; suggest you consistently refer to 'efficacy' 
    outcome rather than 'main' outcomes, as the latter suggests the 
    safety outcomes are less important, and the two names are 
    interchanged throughout manuscript
  - page 8 section 3.3: lines 18 - 20 repeat the prior sentence
  - page 8 line 26:  can you clarify whether you then present average 
    effects from among the five quintiles that you specify within the 
    four quartiles of predicted risk?
  - table 1 column title"  quarter <- quartile
  - page 9 line 12 main <- efficacy
  - Fig 2:  suggest putting the event rate below the other two and 
    invert its direction, this will increase interpretability and 
    graphically suggests that the absolute and relative risks build 
    off of the treatment/comp  event rates within each hof the 
    predictive risk quartiles
## Comments
# ToDo
  - Create graphs demonstrating results across all databases
  - Assess proportional hazard assumption
