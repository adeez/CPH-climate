# import weather data from WU using package(weatherData)

#checkDataAvailabilityForDateRange("CPH", "1997-01-01", "2014-12-31",station_type = "airportCode")
#cph99wu <-getSummarizedWeather("CPH", "1999-01-01", end_date = "2000-12-31",station_type = "airportCode",  opt_all_columns = T)
#cph.wu <- rbind(cph97wu[1:365,],cph98wu[1:365,],cph99wu[1:365,],cph00wu[1:269,],cph01wu[1:365,],cph02wu[1:365,],cph03wu[1:365,]) 
#write.csv(cph.wu, file="cph97.csv");read.csv("cph97.csv");read.csv("cph.csv");write.csv(cph, file="cphclean.csv");
#cph_c2 <-read.csv("cph_c2.csv"); cph_c2 <- cph_c2[,-1]; cph_c2$AccPre <- cph_dmi[,5]

# seperate the date using lubridate
#cph$year <- year(cph$date);#cph$month <- month(cph$date);#cph$day <- day(cph$date);#cph$wday <- wday(cph$date, label = T)

source("./Leapcraft/Rfiles/cph_app.R")
# cut breaks the data into 10 groups by windspeed [5km/h] and then converts it into factors 
temp2 <- factor(cut(cph_c2$Mean_Wind_SpeedKm_h, breaks=3))
temp3 <- factor(cut(cph_c2$Precipitationmm, breaks=3))
temp <- factor(interaction(temp2,temp3))
col1 <- cut(cph_c2$Mean_Wind_SpeedKm_h, breaks = c(2.95,18,57)) 
col2 <- cut (cph_c2$AccPre, breaks = c(-0.236, 3, 137))
col <- factor(interaction(col1, col2))
size <- factor(cut(rain$precipitation, breaks=c(-0.236,3,10,50,100,180) ))
#Levels just reorders the factors and gives them those numbers (1-10)
levels(temp) <- seq_along(levels(temp))
levels(col) <- seq_along(levels(col))
levels(size) <- seq_along(levels(size))
table(temp) # Can see the number of values in each cut (group)
rain$size <- size
cph_c2$color <- col

# creating rain data frame
rain <- aggregate(cph_c2[,16], list(year=cph_c2$year,week=cph_c2$week), sum)
names(rain) <- c("year","week","precipitation")
aggregate(rain$precipitation, list(rain$year), sum)

# wind direction, windspeed and cloud cover
windHistory <- data.frame(cbind(cph_c2$WindDirDegrees, cph_c2$Mean_Wind_SpeedKm_h))
names(windHistory) <- c("WindDir","WindMeanSpeed")
windHistory$Dircut <- cut(windHistory$WindDir, breaks=8)
windHistory$Speedcut <- cut(windHistory$WindMeanSpeed, breaks=5)
windHistory$Interaction <- interaction(windHistory$Dircut,windHistory$Speedcut)
windHistory$factors <- factor(windHistory$Interaction)
levels(windHistory$factors) <- c("NNE-A","NNE-B","NNE-C","NNE-D","ENE-A","ENE-B","ENE-C","ENE-D",
                                 "ESE-A","ESE-B","ESE-C","ESE-D","SSE-A","SSE-B","SSE-C","SSE-D","SSE-E",
                                 "SSW-A","SSW-B","SSW-C","SSW-D","WSW-A","WSW-B","WSW-C","WSW-D","WSW-E",
                                 "WNW-A","WNW-B","WNW-C","WNW-D","WNW-E","NNW-A","NNW-B","NNW-C","NNW-D","NNW-E",
                                 "NNE-E","ENE-E","ESE-E","SSW-E")

clouds <- factor(cut(cph_c2$CloudCover, breaks = 8))
levels(clouds) <- seq_along(levels(clouds))
cph_c2$cloudLevels <- clouds

# finding the extreme cold, hot, windy days
# find the range for each feature and then compare the month's values 
# values upto 5% off the extremes are considered 
maxtemp_range <- aggregate(cph[,2], list(Month=cph$month), min)
maxtemp_range <- cbind(maxtemp_range, aggregate(cph[,2], list(Month=cph$month), max))
mintemp_range <- aggregate(cph[,4], list(Month=cph$month), min)
mintemp_range <- cbind(mintemp_range, aggregate(cph[,4], list(Month=cph$month), max))

