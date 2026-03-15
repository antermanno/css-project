# Final Project for Computational Social Sciences Exam

When running the scripts in rstudio, make sure to have initialized the session clicking on *final_proj.Rproj* or set the working directory the same as the root of the repository.


## Repository Layout

```
 R/                          code for easing data manipulation
 analysis/                   final analysis is performed
 data/                       maps, electoral data, google trends data
 graphs/                     code for graph generation
 methods/                    testing different approaches to estimate dirichlet
 term_paper/                 source code for the final paper
```

### `R/utils.R`

*Utility functions*: loading the electoral data, google trends data, data cleaning, data rearranging.

### `analysis/`

Performing the final analysis.

| Source | Notes |
| :----- | :---- |
| `aggregate_model.R` | estimation of the aggregate model to answer Q1 |
| `explore.R` | playing around with the data |
| `mixed_model.R` | estimation of the two step dirichlet model to answer Q2 |

### `data/`

Folders containing electoral data, google trends, map shapes.

### `graphs/`

Generating the graphs for the paper and presentation.


### `methods/`

Trying out different fitting methods for the Dirichlet model.

When running the reticulate python interface, sometimes it is required to clean the enviroment and restarting the r session to solve some errors after a failed run of a model.

| Source | Notes |
| :----- | :---- |
| `brms_dir.Rmd` | brms, bayesian model fitting with stan |
| `dirichlet.Rmd` | applying all methods on a toy dataset |
| `concentration_share_estimation.Rmd` | applying all the methods to the real data |
| `numpyro_test.Rmd` | trying out numpyro and blackjax framework |
| `gtrend.Rmd` | trying out pytrends as a google trends API |

### `term_paper/`

Source code for term paper.
