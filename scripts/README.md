# SCRIPTS DESCRIPTION

This folder contains the R scripts used for the Interrupted Time Series (ITS) analysis of infant mortality outcomes in Brazil following the implementation of Bolsa Família.

## Scripts included

### `PBF-inf_mort-TS-script.R`

Produces the initial time series visualisation for infant mortality between 1993 and 2022 and marks the 2003 and 2006 intervention points.

Main tasks:
- import dataset
- create time series object
- generate trend plot
- visualise intervention timing

---

### `PBF-inf_mort-diagnostic-script.R`

Conducts diagnostic testing for the initial ITS regression model.

Diagnostic checks include:
- residual histograms
- Q-Q plots
- residuals versus fitted plots
- Breusch-Pagan tests
- Durbin-Watson tests

Diagnostic testing suggested that the linearity assumption was not fully satisfied, so a quadratic time term was introduced and the model was re-estimated.

---

### `PBF-inf_mort-ITS-script.R`

Runs the main Interrupted Time Series regression analysis using Generalised Least Squares (GLS) models with ARMA error structures.

Main tasks:
- estimate ITS regression models
- apply quadratic time specification
- generate regression output tables
- estimate counterfactual trends
- calculate prediction intervals
- visualise factual and counterfactual trends

---

## Software and packages

The scripts were written in R using the following packages:
- readxl
- ggplot2
- nlme
- dplyr
- stargazer
- lmtest
