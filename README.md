# Bolsa Família ITS analysis of Infant Mortality 

## Repository overview

This repository was adapted from work undertaken in my undergraduate dissertation examining the socioeconomic impacts of Brazil’s Bolsa Família Programme (PBF) using an Interrupted Time Series (ITS) approach.

The original dissertation analysed multiple socioeconomic indicators across poverty, inequality, education, and health using aggregate national data from the World Bank between 1993 and 2022. This repository presents only an example of the infant mortality (health indicator) analysis to demonstrate statistical modelling, diagnostic testing, and documentation in R.

---------------------

## Data

The analysis uses publicly available data from the World Bank covering the period 1993–2022.

Infant mortality was used as a broad indicator of population health and is defined as the number of deaths of children under one year of age per 1,000 live births.

Intervention variables were constructed to represent:
- 2003: introduction of Bolsa Família Programme
- 2006: enforcement of programme conditionalities

Data preparation was undertaken in Excel prior to analysis in R.

-------------------

## Methodology

An Interrupted Time Series (ITS) approach was used for this analysis.

ITS is a quasi-experimental approach that estimates changes in an outcome by comparing trends before and after a clearly defined intervention point. Specifically, it models whether there is a statistically significant change in level (an immediate jump) or slope (a change in trend) following the introduction of a policy. These are then compared against a projected counterfactual – what would have occurred in the absence of the intervention.

---------------

## Diagnostic testing and model refinement

Diagnostic testing suggested that the linearity assumption was violated for infant mortality. A quadratic time term was therefore introduced, which improved overall model fit.

Additionally, the histogram of residuals showed slight skewness, suggesting minor deviation from normality. However, the normal Q-Q plot demonstrated a strong fit, indicating that the normality assumption was broadly satisfied. 

Diagnostic checks included:
- residual histograms
- Q-Q plots
- residuals versus fitted plots
- Breusch-Pagan tests
- Durbin-Watson tests

---------------------

## Results summary

The regression results showed a statistically significant downward trend in infant mortality over time, with both the linear term and the quadratic term significant at the 1% level. This suggests that while infant mortality fell between 1993 and 2022, the pace of improvement slowed over time – an intuitive pattern, as reductions tend to taper off once substantial progress has been made and further gains become progressively harder to achieve.

---------------

## Limitations

The long-term decline in infant mortality may reflect broader improvements in public health, rather than the direct impact of Bolsa Família alone. In particular, the Family Health Strategy (Estratégia de Saúde da Família – ESF), introduced in 1994, expanded access to immunisations, maternal care, and health education and has been associated with reductions in infant mortality (Machinko et al., 2006). These overlapping interventions make it difficult to isolate the programme’s independent effect and highlights a common challenge associated with real-world policy evaluation.

--------------------

## Repository structure

- `data/` contains the dataset used in the analysis
- `scripts/` contains R scripts for time series plot, diagnostic testing and ITS modelling
- `outputs/figures/` contains plots and visualisations
- `outputs/tables/` contains regression output tables

------------

## Skills demonstrated

- R programming
- Interrupted Time Series modelling
- diagnostic testing
- statistical interpretation
- data visualisation
- workflow organisation and documentation
