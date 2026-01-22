# 1. Load packages
library(tidyverse)
library(car)
library(broom)
library(ggplot2)
library(MASS)
library(boot)

# 2. Read data
insurance <- read.csv("insurance.csv")

# 3. Data overview
str(insurance)
summary(insurance)

# 4. Encode categorical variables
insurance$sex <- factor(insurance$sex, levels = c("female", "male"))
insurance$smoker <- factor(insurance$smoker, levels = c("no", "yes"))
insurance$region <- factor(insurance$region)

# 4-1. EDA
summary(insurance[, c("age", "bmi", "children", "charges")])

# 4-2 Continuous predictors
ggplot(insurance, aes(age, charges)) +
  geom_point(alpha=0.4) + geom_smooth(method="lm") +
  labs(title="Charges vs Age")

ggplot(insurance, aes(bmi, charges)) +
  geom_point(alpha=0.4) + geom_smooth(method="lm") +
  labs(title="Charges vs BMI")

# 4-3 categorical predictors
ggplot(insurance, aes(smoker, charges, fill=smoker)) +
  geom_boxplot() + theme_minimal()

# 5. Multiple Linear Regression
fit_full <- lm(charges ~ age + sex + bmi + children + smoker + region, data = insurance)
summary(fit_full)

# 6. Diagnostic checks
par(mfrow = c(2, 2))
plot(fit_full)


# 6-1 influential points
influencePlot(fit_full)

# 6-2 multicollinearity check
vif(fit_full)  

# 7. Model refinement

# 7.1 Remove influential points
insurance_clean <- insurance[-c(1301, 578, 544), ]
fit_clean <- lm(charges ~ age + sex + bmi + children + smoker + region, data = insurance_clean)
summary(fit_clean)

summary(fit_full)$coefficients
summary(fit_clean)$coefficients

plot(fit_clean)

# 7.2 Add interation term bmi*smoker
fit_interact <- lm(charges ~ age + sex + bmi * smoker + children + region, data = insurance)
summary(fit_interact)

anova(fit_full, fit_interact)
AIC(fit_full, fit_interact)

ggplot(insurance, aes(x = bmi, y = charges, color = smoker)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Interaction: BMI × Smoker",
       x = "BMI", y = "Insurance Charges (USD)")

par(mfrow = c(2, 2))
plot(fit_interact)

# 7.3 Box-cox and charge transformation
par(mfrow = c(1, 1))
bc<-boxcox(fit_interact, lambda = seq(-2, 2, 0.1))

fit_log <- lm(log(charges) ~ age + sex + bmi * smoker + children + region, data = insurance)
summary(fit_log)

AIC(fit_full, fit_log)

par(mfrow=c(2,2))
plot(fit_log)

# 8. Forward selection based on AIC
vars <- c("age", "sex", "bmi", "children", "smoker", "region", "bmi:smoker")

current_model <- lm(log(charges) ~ 1, data = insurance)
remaining <- vars

while (length(remaining) > 0) {
  
  pvals <- c()
  
  for (v in remaining) {
    f <- as.formula(
      paste("log(charges) ~", 
            paste(c(attr(terms(current_model), "term.labels"), v), collapse = " + "))
    )
    
    m <- lm(f, data = insurance)
    
    p <- anova(current_model, m)$`Pr(>F)`[2]
    
    if (!is.na(p)) {
      pvals[v] <- p
    }
  }

  if (length(pvals) == 0) {
    message("No valid p-values — stopping.")
    break
  }
  
  best <- names(which.min(pvals))
  best_p <- min(pvals)
  
  cat("Candidate:", best, "p =", best_p, "\n")
  
  if (!is.na(best_p) && best_p < 0.05) {
    message(paste("Adding:", best))
    current_model <- update(current_model, paste(". ~ . +", best))
    remaining <- setdiff(remaining, best)
  } else {
    message("No predictors meet the entry criterion; stopping.")
    break
  }
}

summary(current_model)

