#ITS REGRESSION INFANT MORTALITY

#download data set
library(readxl)
library(ggplot2)
library(nlme)
library(dplyr)
library(stargazer)

RPBF <- read_excel("data/PBF-inf-mort-data.xlsx")


#producing regression table
#A quadratic term is included because diagnostic testing suggested the linearity assumption was not satisfied.

model.inf_mort2 = gls(Infant_mortality.xls ~ Time + I(Time^2) + PBF_2003 + Post_2003 + PBF_2006 + Post_2006, data = RPBF, method="ML", correlation=corARMA(p=2,q=2,form=~Time))
summary(model.inf_mort2)
stargazer(model.inf_mort2, type = "text", title = "Regression Results for Infant Mortality", digits = 3)


#predicting ITS 

predictSE.gls <- function(model, newdata, se.fit = TRUE, ...) {
#extract the model matrix
  X <- model.matrix(formula(model)[-2], newdata)
  
#get predicted values
  fit <- as.vector(X %*% coef(model))
  
  if (se.fit) {
#compute standard errors
    V <- vcov(model)
    se <- sqrt(diag(X %*% V %*% t(X)))
    return(data.frame(fit = fit, se = se))
  } else {
    return(data.frame(fit = fit))
  }
}

RPBF<-RPBF %>% mutate(
  model.inf_mort2.predictions = predictSE.gls (model.inf_mort2, RPBF, se.fit=T)$fit,
  model.inf_mort2.se = predictSE.gls (model.inf_mort2, RPBF, se.fit=T)$se
)

ggplot(RPBF,aes(Time,Infant_mortality.xls))+
  geom_ribbon(aes(ymin = model.inf_mort2.predictions - (1.96*model.inf_mort2.se), ymax = model.inf_mort2.predictions + (1.96*model.inf_mort2.se)), fill = "lightgreen")+
  geom_line(aes(Time,model.inf_mort2.predictions),color="black",lty=1)+
  geom_point(alpha=0.3)


  
#predicting the first counterfactual
  
RPBF2<-filter(RPBF,Time<2003)
model.inf_mort.e = gls(Infant_mortality.xls ~ Time + I(Time^2), data = RPBF2, correlation= corARMA(p=1, q=1, form = ~ Time), method="ML")

RPBF<-RPBF %>%mutate(
  model.inf_mort.e.predictions=predictSE.gls(model.inf_mort.e,newdata=RPBF,se.fit=T)$fit,
  model.inf_mort.e.se=predictSE.gls(model.inf_mort.e,RPBF,se.fit=T)$se
)

#predict the second
RPBF3<-filter(RPBF,Time<2006)
model.inf_mort.f = gls(Infant_mortality.xls ~ Time + I(Time^2) + PBF_2003 + Post_2003, data = RPBF3, correlation= corARMA(p=1, q=1, form = ~ Time), method="ML")

RPBF<-RPBF %>%mutate(
  model.inf_mort.f.predictions=predictSE.gls(model.inf_mort.f,newdata=RPBF,se.fit=T)$fit,
  model.inf_mort.f.se=predictSE.gls(model.inf_mort.f,RPBF,se.fit=T)$se
)


#plot
ggplot(RPBF, aes(Time, Infant_mortality.xls)) +
  
  geom_ribbon(aes(
    ymin = model.inf_mort.f.predictions - (1.96 * model.inf_mort.f.se),
    ymax = model.inf_mort.f.predictions + (1.96 * model.inf_mort.f.se)
  ), fill = "lightblue") +
  
  geom_line(aes(y = model.inf_mort.f.predictions), color = "blue", lty = 2) +
  
  geom_ribbon(aes(
    ymin = model.inf_mort.e.predictions - (1.96 * model.inf_mort.e.se),
    ymax = model.inf_mort.e.predictions + (1.96 * model.inf_mort.e.se)
  ), fill = "pink") +
  
  geom_line(aes(y = model.inf_mort.e.predictions), color = "red", lty = 2) +
  
  geom_ribbon(aes(
    ymin = model.inf_mort2.predictions - (1.96 * model.inf_mort2.se),
    ymax = model.inf_mort2.predictions + (1.96 * model.inf_mort2.se)
  ), fill = "lightgreen") +
  
  geom_line(aes(y = model.inf_mort2.predictions), color = "black", lty = 1) +
  
  geom_point(alpha = 0.3) +
  
 #Add intervention lines
  geom_vline(xintercept = c(2003, 2006), linetype = "dashed", color = "darkgreen", size = 1) +
  
  labs(
    title = "Infant Mortality ITS",
    x = "Year",
    y = "Infant Mortality"
  ) +
  
  theme_minimal()


