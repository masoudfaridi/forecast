library(tidyverse)
library(prophet)
y_r =1:10
for(i in 11:100){
  y_r[i]=y_r[i-10]+rnorm(1,0,0.51)
}
x = y_r+rnorm(100,0,.51)
df <- data.frame(ds = seq(as.Date("2022-01-01"), by = "day", length.out = 100),
                 y=y_r,
                 helper_variable = x)

df_train=df[1:80,]
m <- prophet(df_train, fit=FALSE)
m <- add_regressor(m, 'helper_variable', standardize = FALSE)
m <- fit.prophet(m, df_train)
future <- make_future_dataframe(m, periods = 20)
future$helper_variable=df$helper_variable[81:100]
forecast <- predict(m, future)

plot(m,forecast)

