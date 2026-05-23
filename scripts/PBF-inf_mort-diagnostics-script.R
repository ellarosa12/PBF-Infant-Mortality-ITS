#DIAGNOSTIC TESTS FOR INFANT MORTALITY

#download data set
library(readxl)
library(ggplot2)
library(nlme)
library(dplyr)
library(stargazer)

RPBF <- read_excel("data/PBF-inf-mort-infdata.xlsx")


#FITTING ITS MODEL:
ITS_inf_mort <- lm(Infant_mortality.xls ~ Time + PBF_2003 + Post_2003 + PBF_2006 + Post_2006, data = RPBF)


#CHECKING FOR NORMALITY:
#extract residuals
res_inf_mort <- resid(ITS_inf_mort)
#plot residuals
hist(res_inf_mort, main = "Histogram of Residuals: Infant Mortality Rate", xlab = "Residuals", col = "skyblue")
#further test using Q-Q plot
qqnorm(res_inf_mort)
qqline(res_inf_mort, main = "Normal Q-Q Plot: Infant Mortality Rate", col = "red", lwd = 2)

#CHECKING FOR LINEARITY:
# 1. Visual check
plot(fitted(ITS_inf_mort), res_inf_mort,
     main = "Residuals vs Fitted Values: Infant Mortality Rate",
     xlab = "Fitted Values",
     ylab = "Residuals",
     col = "blue", pch = 19)
abline(h = 0, col = "red", lwd = 2)


#ADDING QUADRATIC TERM:
#the residuals vs fitted plot suggested that the linearity assumption was not satisfied
#so a quadratic time term was added and the model was re-estimated

ITS_inf_mort_quad <- lm(Infant_mortality.xls ~ Time + I(Time^2) + PBF_2003 + Post_2003 + PBF_2006 + Post_2006, data = RPBF)

#extract residuals from quadratic model
res_inf_mort_quad <- resid(ITS_inf_mort_quad)

#re-check linearity using quadratic model
plot(fitted(ITS_inf_mort_quad), res_inf_mort_quad,
     main = "Residuals vs Fitted Values: Infant Mortality Rate (Quadratic Term),
     xlab = "Fitted Values",
     ylab = "Residuals",
     col = "blue", pch = 19)
abline(h = 0, col = "red", lwd = 2)


# 2. HOMOSKEDASTICITY: Breusch-Pagan Test
library(lmtest)
bptest(ITS_inf_mort_quad)


#CHECK FOR AUTOCORRELATION
library(lmtest)
# Run Durbin-Watson test
dwtest(ITS_inf_mort_quad)

