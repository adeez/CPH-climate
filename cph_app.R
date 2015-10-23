# load packages
require(dplyr); require(zoo); require(lubridate); require(lattice); require(ggplot2);require(xts)
require(devtools); require(rCharts); require(plyr); require(reshape2); require(ggthemes)

# read the files
cph <-read.csv("cph.csv", sep = ","); cph_dmi <- read.csv("cphdmi.csv", sep = ",")
cph_c2 <-read.csv("cph_c2.csv"); cph_c2 <- cph_c2[,-1]; cph_c2$AccPre <- cph_dmi[,5]
extremedays <- read.csv("extremedays.csv", sep = ",")
extremedays <- extremedays[,-1]; extremedays$year <- year(extremedays$date)
extremedays1 <- tally(group_by(tbl_df(extremedays), tpye, year))
cph <- cph[,-1]
cph$isoweek <- isoweek(cph$date)
cph_c2$isoweek <- isoweek(cph_c2$date)
# this calculates the mean values for each day of each month from the last 50 years
dailymean <- round(arrange(aggregate(cph[,2:8], list(Month = cph$month, Day = cph$day), mean), Month), digits = 1)

# this calculates the abs min and max temperatures for each month 
absmonthly <- aggregate(cph[,2], list(Month=cph$month), max); absmonthly1 <- aggregate(cph[,2], list(Month=cph$month), min)
absmonthly1 <- absmonthly1[,-1]; absmonthly <-cbind(absmonthly,absmonthly1); names(absmonthly) <- c("Month", "AbsMax", "AbsMin")
absmax_year <- arrange(aggregate(cph[,2], list(Year=cph$year, Month=cph$month), max ), Year) # for each year
absmin_year <- arrange(aggregate(cph[,4], list(Year=cph$year, Month=cph$month), min ), Year) # for each year
absrain_year <- arrange(aggregate(cph_dmi[,4], list(Year=year(cph_dmi$y50a), Month=month(cph_dmi$y50a)), sum ), Year) # for each year

# good weekends with no rain and windspeed < 5m/s adjust with cloudcover
good<- filter(cph, (cph$wday=="Sat" | cph$wday=="Sun") & (cph$Mean_Wind_SpeedKm_h <= 18) & (cph$Precipitationmm== 0) & (cph$CloudCover <=4))

annualrain <- aggregate(rain[,3], list(year=rain$year), sum)

# Plotting dygraphs
# recorded values between 1997-2014
dates <- as.POSIXct(cph$date) # for wu data
dates2 <- as.POSIXct(cph_dmi$y50a) # for dmi data
max <- as.xts(x= cph$Max_TemperatureC, order.by = dates, frequency = 7)
min <- as.xts(x= cph$Min_TemperatureC, order.by = dates, frequency = 7)
rain <- as.xts(x= cph_dmi$AccPre, order.by = dates2, frequency = 7)
wind <- as.xts(x=cph$Mean_Wind_SpeedKm_h, order.by = dates, frequency = 7)
weather <- cbind(rain,wind)
names(weather) <- c("precipitation","wind speed")
temperature <- cbind(max, min)
names(temperature) <- c("max","min")

# average values for each day of each month 
daily_date <- as.POSIXct(seq(as.Date("2016-1-1"),as.Date("2016-12-31"), by=1)) # dummy dates
dailymax <-as.xts(x=dailymean$Max_TemperatureC, order.by = daily_date, frequency = 7)
dailymin <-as.xts(x=dailymean$Min_TemperatureC, order.by = daily_date, frequency = 7)
dailyws <-as.xts(x=dailymean$Mean_Wind_SpeedKm_h, order.by = daily_date, frequency = 7)
dailyweather <- cbind(dailymax,dailymin,dailyws)
names(dailyweather) <- c("max","min","wind speed")

# plot to indicate number of hot or cold days (can this be made interactive?)
plot <- ggplot(data = extremedays, aes(x=year(date)))+ geom_bar(stat = "bin", binwidth=0.3, aes(fill=type), position = "dodge") + facet_wrap(~wday)



