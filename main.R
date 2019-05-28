
real_estate_data = read.csv('real_estate_p.csv')
head(real_estate_data); dim(real_estate_data)

# Scatterplot
plot(Price~Living.Area, data=real_estate_data, xlab="Living.Area", ylab = "Price")

# Mean x and y
mean.x = mean(real_estate_data$Living.Area)
mean.y = mean(real_estate_data$Price)

# SD of x and y
sd.x = sd(real_estate_data$Living.Area)
sd.y = sd(real_estate_data$Price)

# Correlation
r = cor(real_estate_data$Living.Area, real_estate_data$Price)

#Slope
b1 = r*(sd.x/sd.y)

#Intercept
b0 = mean.y - b1 * mean.x

#LS Line
model <- lm(Price~Living.Area, data=real_estate_data); summary(model)
abline(model, col = 'Red')

# Confidence Interval
confint(model, level = 0.95)

predict(model, data.frame(Living.Area = 1850), level = 0.90, interval = "confidence")

summary(real_estate_data$Price)
newx = seq(0e+00, 6e+05)

# Superimpose scatterplot
ci90 = predict(model, newdata = dsata.frame(Living.Area=newx), level = 0.90, interval = "confidence" )
lines(newx, ci90[,2], col="blue"); lines(newx,ci90[,3],col="blue")


# Residual plot vs predicted value
plot(model$residuals~model$fitted.values, xlab = "Predicted", ylab = "Residual")
abline(0,0, col = 'Red')

# Normality plot of residuals
qqnorm(model$residuals)
qqline(model$residuals, col = 'red')


# Multiple Regression
model_1 <- lm(formula = Price ~ Living.Area + Bedrooms + Fireplaces, data = real_estate_data)

anova(model_1)

confint(model_1, level = 0.95)

#Converting to Central.Air, Waterfront, and New Construct into categorical variables

real_estate_data$Central.Air <- factor(real_estate_data$Central.Air)
real_estate_data$Waterfront <- factor(real_estate_data$Waterfront)
real_estate_data$New.Construct <- factor(real_estate_data$New.Construct)



m0 <- lm(Price~. ,data=real_estate_data); summary(m0)

m.step<- step(m0, direction = "backward")

