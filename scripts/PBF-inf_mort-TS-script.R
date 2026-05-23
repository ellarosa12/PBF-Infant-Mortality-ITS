#PLOTTING TIME SERIES CHART FOR INFANT MORTALITY
#download data set
library(readxl)


RPBF <- read_excel("data/PBF-inf-mort-data.xlsx")


#PLOT TIME SERIES:
inf_mort_ts <- ts(RPBF$'Infant_mortality.xls',start=1993,frequency=1)
plot(inf_mort_ts,
     main = "Infant Mortality Rate (per 1,000 live births)",
     ylab = "Infant Mortality",
     xlab = "Year",
     col = "blue",
     lwd = 2)
# Add vertical lines at 2003 and 2006
abline(v = c(2003, 2006), col = "darkgreen", lwd = 2, lty = "dashed")
