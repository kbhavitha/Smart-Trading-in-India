#install.packages("forecast")
#install.packages("tseries")

library('ggplot2')
library('forecast')
library('tseries')

format(Sys.Date(), "%b %d %Y")

daily_data = read.csv(file.choose())
summary(daily_data)
#daily_data<-daily_data[1:40,]
# Part 1 - Analyse the data
#daily_data$Date <- format(as.Date(daily_data$Date), "%m %d %Y")
daily_data$Date = as.Date(daily_data$Date,"%m %d %Y")
daily_data$NewDate = as.Date(daily_data$Date,"%m %d %Y")

#daily_data$Price=as.numeric(levels(daily_data$Price))[daily_data$Price]
d<-ggplot(daily_data, aes(NewDate, Price)) + geom_line() + scale_x_date(date_labels = "%Y") +
  ylab("Price") + xlab("")
d + scale_y_continuous(limits=c(320,360), breaks=c(320,330,340,350,360))


#part -remove outliers
count_ts = ts(daily_data[, c('Price')])

daily_data$clean_Price = tsclean(count_ts)

ggplot() +
  geom_line(data = daily_data, aes(x = NewDate, y = clean_Price)) + ylab('Cleaned Price')


# part 3 - to check if data is non stationary using statistics
plot(daily_data$Price)
###test 1
pacf(na.omit(daily_data$Price))
pacf(na.omit(count_ts))

#adf.test(na.omit(daily_data$Price),alternative="stationary")
adf.test(na.omit(daily_data$clean_Price),alternative="stationary")
##test 2
#kpss = kpss.test(count_ts)
#kpss

# part4 - converting to stationary data
diff_data =diff(count_ts)
#retreving count_ts
##diffinv(diff_data,xi=61.910)
#check if the diff_data is staionary or not
adf.test(na.omit(diff_data ),alternative="stationary")

###hold <- window((diff_data), start=1)
###fit_no_holdout<-arima(daily_data$Price,order=c(2,2,3))
##pre<-predict(fit_no_holdout,n.ahead=10)
##pre

fcast_no_holdout <-forecast(arima(daily_data$clean_Price,order=c(2,1,3)),level=10,h=390)
accuracy(fcast_no_holdout)
plot(fcast_no_holdout, main=" ")
fcast_no_holdout



# retreiving the data
###cumsum(diff_data)
###View(data.frame(fcast_no_holdout))
write.csv(data.frame(fcast_no_holdout),file="C:/Users/HP/Downloads/curr_predicted/INR_VND.csv")

