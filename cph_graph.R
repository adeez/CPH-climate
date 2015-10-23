# graphs

source('./Leapcraft/Rfiles/cph_wu.R')
source("./Leapcraft/Rfiles/cph_app.R")

# PLOTTING

# Type of day plot. can be customized further. 
ggplot(cph_c2, aes(ukweek,wday,fill=col))+geom_tile(colour="white")+
  scale_fill_manual(values = c("deepskyblue2", "darkolivegreen","orange", "red3"),
                    labels = c("Comfortable","Onset of discomfort", "Uncomfortable","Very Uncomfortable" ))+
  guides(fill = guide_legend(title = NULL, keywidth = 3, override.aes = list(colour = NULL) ))+
  facet_wrap(~year, ncol = 3) + theme_grey(base_size = 12) + labs(x = "Week", y = "Day") +
  scale_x_discrete(expand = c(0, 0),breaks= seq(1,52,by=3))+
  scale_y_discrete(expand = c(0, 0), limits=c("Sun","Sat","Fri","Thurs","Wed","Tues","Mon")) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 30, hjust = 1, colour = "grey50"),
        strip.background = element_blank(), panel.background = element_blank())

# cloud cover plot
ggplot(cph_c2, aes(ukweek,wday,fill=clouds))+geom_tile(colour="white")+
  scale_fill_manual(values = c("yellow","goldenrod1","lightgoldenrod","darkseagreen2","lightsteelblue3", "gray77","gray62", "gray30"),
                    labels = c("1","2", "3","4","5","6","7","8" ))+
  guides(fill = guide_legend(title = NULL, keywidth = 3, override.aes = list(colour = NULL) ))+
  facet_wrap(~year, ncol = 3) + theme_grey(base_size = 12) + labs(x = "Week", y = "Day") +
  scale_x_discrete(expand = c(0, 0),breaks= seq(1,52,by=3))+
  scale_y_discrete(expand = c(0, 0), limits=c("Sun","Sat","Fri","Thurs","Wed","Tues","Mon")) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 30, hjust = 1, colour = "grey50"),
        strip.background = element_blank(), panel.background = element_blank())

# temperature plot for each day . can add a different colorscheme and alpha to each season to differentiate
ggplot() + geom_tile(data = seasonWinter, aes(ukweek,wday, fill=factors), colour="white", alpha=0.70)+
  geom_tile(data = seasonSpring, aes(ukweek,wday, fill=factors), colour="white", alpha=0.80)+
  geom_tile(data = seasonSummer, aes(ukweek,wday, fill=factors), colour="white", alpha=0.95)+
  geom_tile(data = seasonAutumn, aes(ukweek,wday, fill=factors), colour="white", alpha=0.80)+
  scale_fill_manual(values = c("deepskyblue2", "gold","orangered"),
                    labels = c("Cooler","Typical","Warmer"))+
  guides(fill = guide_legend(title = NULL, keywidth = 3, override.aes = list(colour = NULL) ))+
  facet_wrap(~year, ncol = 3) + theme_grey(base_size = 12) + labs(x = "Week", y = "Day") +
  scale_x_discrete(expand = c(0, 0),breaks= seq(1,52,by=3))+
  scale_y_discrete(expand = c(0, 0), limits=c("Sun","Sat","Fri","Thurs","Wed","Tues","Mon")) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 30, hjust = 1, colour = "grey50"),
        strip.background = element_blank(), panel.background = element_blank())


# rain plot seperated by seasons with event lines customize the colours. 
#rects <- data.frame(xstart = seq(1,40,13), xend = seq(14,53,13), col =c(1,2,3,4))
rects <- data.frame(xstart = c(0,13,21,35,48), xend=c(13,21,35,48,53), col =c(1,2,3,4,5))
ggplot()+   # add some alpha to make it look better?
  geom_rect(data = rects, aes(xmin = xstart, xmax = xend, ymin = -Inf, ymax = Inf, fill = col), 
            alpha = c(1,0.4,0.65,0.4,1) )+
  scale_fill_gradientn(colours = c("honeydew3", "greenyellow","yellow", "orange", "honeydew3"),
                       guide = "legend")+
  geom_point(data= rain,aes(week,year, size= size, colour = size))+
  scale_size_manual(values = c(1,2,3.5,7,10), labels= c("< 1mm","1-20mm ", "21-50mm","51-90mm", "> 90mm" ), 
                    guide="legend")+
  scale_color_manual(values = c("deepskyblue","deepskyblue2","dodgerblue1", "dodgerblue4","darkblue"),
                     labels= c("< 1mm","1-20mm ", "21-50mm","51-90mm", "> 90mm" ),
                     guide ="legend" )+
  guides(fill = FALSE,  
         colour = guide_legend("Rain", title.position = "left"),
         size = guide_legend("Rain", title.position = "left"))+
  labs(x = "Week", y = "Year") + 
  scale_x_discrete(breaks= seq(1,53, by = 1)) +
  scale_y_reverse(breaks = seq(1997,2014, by=1))+
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 30, hjust = 0, colour = "grey50"),
        panel.background = element_blank())+
  geom_vline(xintercept= 14, colour= "firebrick", alpha=0.65)+
  geom_vline(xintercept= 41, colour= "firebrick", alpha=0.65)+
  annotate("text", x = 41.5, y = 2010, label = "School autumn break", colour= "red", angle=90, alpha=0.65)+
  annotate("text", x = 14.5, y = 2006, label = "Easter week", colour= "red", angle=90, alpha=0.65)

# dygraphs  *** very important to hide the dates
# Plotting dygraphs
# average values for each day of each month 
daily_date <- as.POSIXct(seq(as.Date("2016-1-1"),as.Date("2016-12-31"), by=1)) # dummy dates
dailymax <-as.xts(x=dailymean$Max_TemperatureC, order.by = daily_date, frequency = 7)
dailymin <-as.xts(x=dailymean$Min_TemperatureC, order.by = daily_date, frequency = 7)
dailyws <-as.xts(x=dailymean$Mean_Wind_SpeedKm_h, order.by = daily_date, frequency = 7)
dailyweather <- cbind(dailymax,dailymin,dailyws)
names(dailyweather) <- c("max","min","wind speed")

dygraph(dailyweather) %>%
  dySeries("wind speed", axis='y2')

# wind direction bar plot/ with coord_polar. *** change the breaks to exact 45 values 
ggplot(windHistoryArranged, aes(x=factors, fill= Speedcut))+geom_bar()+coord_polar()+
  scale_fill_manual(values = c("deepskyblue3","gold","darkolivegreen4", "darkorange2","firebrick"),
                     labels= c("0-13 km/h","13-24 km/hr ", "24-34km/hr","34-45km/hr", "45+ km/hr" ),
                     guide ="legend" )+
  guides(fill = guide_legend("Wind Speed", title.position = "top"))+
  labs(x = NULL, y = "% of values") +
  
  scale_x_discrete(breaks=c("ENE-A","ESE-D","WSW-B","NNW-A") ,labels= c("45","135","225","315")) +
  scale_y_discrete(breaks = c("200","400", "600"), labels = c("3%", "6%","9%"))+
  theme(legend.position = "right", 
        axis.text.x = element_text(size = 11 *0.8, angle = 30, hjust = 0, colour = "grey50"))
  

# plot using rcharts
nPlot(n ~ year, group = "type", data = extremedays1, 
      type = 'multiBarChart')
mPlot(x = "date", y = c("Max_TemperatureC", "Min_TemperatureC"), type = "Line", data = dailymean)

