# DATA DESCRIPTION

This dataset was constructed using publicly available World Bank data for infant mortality, filtered for Brazil and the relevant time period.

It was prepared in Excel prior to statistical analysis in R and therefore includes intervention variables for 2003 and 2006.

Variables included:

- `Time` : yearly observations from 1993 to 2022
- `PBF_2003` : dummy variable representing the 2003 rollout of Bolsa Família
- `Post_2003` : post-2003 trend variable
- `PBF_2006` : intervention dummy for the 2006 enforcement of conditionalities
- `Post_2006` : post-2006 trend variable
- `Infant_mortality.xls` : infant mortality rate per 1,000 live births
