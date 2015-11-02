# graphs

source('./Leapcraft/Rfiles/cph_wu.R')
source("./Leapcraft/Rfiles/cph_app.R")

# PLOTTING

# Type of day plot. can be customized further. 

ggplot(cph_c2, aes(ukweek,wday,fill=col))+geom_tile(colour="white", alpha=0.65)+
  scale_fill_manual(values = c("deepskyblue2", "darkolivegreen","orange", "red3"),
                    labels = c("Comfortable","Onset of discomfort", "Uncomfortable","Very Uncomfortable" ))+
  guides(fill = guide_legend(title = NULL, keywidth = 3, override.aes = list(colour = NULL) ))+
  facet_wrap(~year, ncol = 3,scales = "free_x") + theme_grey(base_size = 12) + labs(x = "Week", y = "Day") +
  scale_x_discrete(expand = c(0, 0),breaks= seq(1,52,by=3))+ labs(x=NULL,y=NULL)+
  scale_y_discrete(expand = c(0, 0), limits=c("Sun","Sat","Fri","Thurs","Wed","Tues","Mon")) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(face="plain",size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text( size = 11),
        strip.background = element_blank(), panel.background = element_blank())

# cloud cover plot
ggplot(cph_c2, aes(ukweek,wday,fill=clouds))+geom_tile(colour="white")+
  scale_fill_manual(values = c("yellow","goldenrod1","lightgoldenrod","darkseagreen2","lightsteelblue3", "gray77","gray62", "gray30"),
                    labels = c("1","2", "3","4","5","6","7","8" ))+
  guides(fill = guide_legend(title = NULL, keywidth = 3, override.aes = list(colour = NULL) ))+
  facet_wrap(~year, ncol = 3, scales = "free_x") + theme_grey(base_size = 12) + labs(x = "Week", y = "Day") +
  scale_x_discrete(expand = c(0, 0),breaks= seq(1,52,by=3))+ labs(x=NULL,y=NULL)+
  scale_y_discrete(expand = c(0, 0), limits=c("Sun","Sat","Fri","Thurs","Wed","Tues","Mon")) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background = element_blank())

# temperature plot for each day . can add a different colorscheme and alpha to each season to differentiate
ggplot() + geom_tile(data = seasonWinter, aes(ukweek,wday, fill=factors), colour="white", alpha=0.60)+
  geom_tile(data = seasonSpring, aes(ukweek,wday, fill=factors), colour="white", alpha=0.75)+
  geom_tile(data = seasonSummer, aes(ukweek,wday, fill=factors), colour="white", alpha=1)+
  geom_tile(data = seasonAutumn, aes(ukweek,wday, fill=factors), colour="white", alpha=0.80)+
  scale_fill_manual(values = c("deepskyblue2", "gold","orangered"),
                    labels = c("Cooler","Typical","Warmer"))+
  guides(fill = guide_legend(title = NULL, keywidth = 3, override.aes = list(colour = NULL) ))+
  facet_wrap(~year, ncol = 3, scales = "free_x") + theme_grey(base_size = 12) + labs(x = "Week", y = "Day") +
  scale_x_discrete(expand = c(0, 0),breaks= seq(1,52,by=3))+ labs(x=NULL,y=NULL)+
  scale_y_discrete(expand = c(0, 0), limits=c("Sun","Sat","Fri","Thurs","Wed","Tues","Mon")) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text( size = 11),
        strip.background = element_blank(), panel.background = element_blank())


# rain plot seperated by seasons with event lines customize the colours. 
#rects <- data.frame(xstart = seq(1,40,13), xend = seq(14,53,13), col =c(1,2,3,4))
rects <- data.frame(xstart = c(0,13,21,35,48), xend=c(13,21,35,48,54), col =c(1,2,3,4,5))
ggplot()+   # add some alpha to make it look better?
  geom_rect(data = rects, aes(xmin = xstart, xmax = xend, ymin = -Inf, ymax = Inf, fill = col), 
            alpha = c(0.35,0.25,0.25,0.2,0.35) )+
  scale_fill_gradientn(colours = c("honeydew3", "greenyellow","yellow", "orange", "honeydew3"),
                       guide = "legend")+
  scale_fill_gradientn(colours = c("powderblue", "palegreen3","orange", "orangered", "powderblue"),
                       guide = "legend")+
  geom_point(data= rain,aes(week,year, size= size, colour = size))+
  scale_size_manual(values = c(1,2,3.5,7,10), labels= c("< 1mm","1-20mm ", "21-50mm","51-90mm", "> 90mm" ), 
                    guide="legend")+
  scale_color_manual(values = c("deepskyblue","deepskyblue2","dodgerblue1", "dodgerblue4","royalblue4"),
                     labels= c("< 1mm","1-20mm ", "21-50mm","51-90mm", "> 90mm" ),
                     guide ="legend" )+
  scale_alpha_manual(values =  c(1,1,1,0.8,0.40))+
  guides(fill = FALSE,  
         colour = guide_legend("Rain", title.position = "left"),
         size = guide_legend("Rain", title.position = "left"))+
  labs(x = "Week", y = "Year") + 
  scale_x_discrete(breaks= seq(1,53, by = 1)) + labs(x=NULL,y=NULL)+
  scale_y_reverse(breaks = seq(1997,2014, by=1))+
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 0, colour = "grey40"),
        axis.text.y = element_text(size = 11*0.8),
        text= element_text(size = 11),
        panel.background = element_blank(), 
        panel.grid.major= element_line(colour = "gray87")
        )+
  geom_vline(xintercept= 14, colour= "rosybrown4", alpha=0.30, linetype=5)+
  geom_vline(xintercept= 41, colour= "rosybrown4", alpha=0.40, linetype=5)+
  geom_vline(xintercept= 52, colour= "rosybrown4", alpha=0.40, linetype=5)+
  geom_vline(xintercept= 25, colour= "rosybrown4", alpha=0.30, linetype=5)+
  geom_vline(xintercept= 22, colour= "rosybrown4", alpha=0.30, linetype=5)+
  geom_vline(xintercept= 17, colour= "rosybrown4", alpha=0.30, linetype=5)+
  annotate("text",family= "DIN" , x = 41.5, y = 2010, label = "School autumn break", 
           colour= "gray75", angle=90, alpha=1)+
  annotate("text",family= "DIN" ,x = 14.5, y = 2006, label = "Easter week", colour= "gray75", 
           angle=90, alpha=1)+
  annotate("text",family= "DIN" ,x = 52.5, y = 2006, label = "Christmas", colour= "gray75", 
           angle=90, alpha=1)+
  annotate("text",family= "DIN" ,x = 25.5, y = 2008, label = "St.John's Eve", colour= "gray75", 
         angle=90, alpha=1)+
  annotate("text",family= "DIN" ,x = 22.5, y = 2012, label = "Constitution Day", colour= "gray75", 
           angle=90, alpha=1)+
  annotate("text",family= "DIN" ,x = 17.5, y = 2001, label = "May 1st", colour= "gray75", 
           angle=90, alpha=1)

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

ggplot()+ geom_line(data = dailymean, aes(x=seq, y=Max_TemperatureC),colour="red")+
  geom_line(data = dailymean, aes(x=seq, y=Min_TemperatureC),colour="dodgerblue2")+ 
  geom_line(data = dailymean, aes(x=seq, y=Mean_Wind_SpeedKm_h),colour="darkolivegreen4")


# wind direction bar plot/ with coord_polar. *** change the breaks to exact 45 values 
ggplot(windHistoryArranged, aes(x=factors, fill=Speedcut))+geom_bar()+ 
  coord_polar()+
  scale_fill_manual(values = c("deepskyblue3","goldenrod1","darkolivegreen4", "darkorange2","firebrick"),
                     labels= c("0-13 km/h","13-24 km/hr ", "24-34km/hr","34-45km/hr", "45+ km/hr" ),
                     guide ="legend" )+
  guides(fill = guide_legend("Wind Speed", title.position = "top"))+
  labs(x = NULL, y = NULL ) +
  
  scale_x_discrete(labels= c("0","5","15","25","35","45","55","65","75","85")) +
  #scale_y_discrete(breaks = c("200","400", "600"), labels = c("3%", "6%","9%"))+
  theme(legend.position = "right", 
        axis.text.x = element_text(family="DIN",size = 11 *0.8, angle = 30, colour = "gray30"),
        panel.grid.major.x= element_line(colour = "gray20",linetype =3 ),
        panel.grid.major.y= element_line(colour = "gray20", linetype = 3),
        panel.background = element_blank(),
        text=element_text(size=11))

#daily temperatures for the anomalies
p1 <- ggplot()+
  geom_bar(data=dailytemperature[1:365,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8,stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[1:365,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "1997")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background=element_blank())


p2<- ggplot()+  
  geom_bar(data=dailytemperature[366:730,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[366:730,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "1998")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p3<- ggplot()+  
  geom_bar(data=dailytemperature[731:1095,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[731:1095,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "1999")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p4<- ggplot()+  
  geom_bar(data=dailytemperature[1096:1461,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[1096:1461,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2000")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p5<- ggplot()+  
  geom_bar(data=dailytemperature[1462:1826,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[1462:1826,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2001")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p6<- ggplot()+  
  geom_bar(data=dailytemperature[1827:2191,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[1827:2191,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2002")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p7<- ggplot()+  
  geom_bar(data=dailytemperature[2192:2556,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[2192:2556,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2003")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p8<- ggplot()+  
  geom_bar(data=dailytemperature[2557:2922,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[2557:2992,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2004")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p9<- ggplot()+  
  geom_bar(data=dailytemperature[2923:3287,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[2923:3287,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2005")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p10<- ggplot()+  
  geom_bar(data=dailytemperature[3288:3652,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[3288:3652,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2006")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p11<- ggplot()+  
  geom_bar(data=dailytemperature[3653:4017,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[3653:4017,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2007")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())
 
p12<- ggplot()+  
  geom_bar(data=dailytemperature[4018:4383,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[4018:4383,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2008")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p13<- ggplot()+  
  geom_bar(data=dailytemperature[4384:4748,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[4384:4748,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2009")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())
 
p14<- ggplot()+  
  geom_bar(data=dailytemperature[4749:5113,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[4749:5113,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2010")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p15<- ggplot()+  
  geom_bar(data=dailytemperature[5114:5478,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[5114:5478,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2011")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p16<- ggplot()+  
  geom_bar(data=dailytemperature[5479:5844,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[5479:5844,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2012")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p17<- ggplot()+  
  geom_bar(data=dailytemperature[5845:6209,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[5845:6209,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2013")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())

p18<- ggplot()+  
  geom_bar(data=dailytemperature[6210:6574,],aes(x=xaxis,y=Max_TemperatureC),fill="orangered",colour="orangered",alpha=0.8, stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="yellow",colour="yellow",alpha=0.7, stat = "identity")+
  geom_bar(data=dailytemperature[6210:6574,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="deepskyblue2", stat = "identity")+
  geom_bar(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="darkseagreen2",alpha=0.7, stat = "identity")+
  ggtitle(label = "2014")+
  scale_x_discrete(expand = c(0, 0),breaks= c(1,31,59,90,120,151,181,212,243,273,304,334,365))+ labs(x="Days",y="Temperature")+
  scale_y_continuous(  breaks=c(-30,-27,-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24,27,30,33)) +
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 1, colour = "grey40"),
        axis.text.y = element_text(size = 11 *0.8, angle = 0), 
        text= element_text(size = 11),
        strip.background = element_blank(), panel.background= element_blank())


grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,ncol=3)


##Wind history plots attempts
#monthly
ggplot()+geom_bar(data=dailyweektemp,aes(x=week,y=x),colour="orangered", stat = "identity")

# anomalies
p1 <- ggplot(data=extremes[1:2,], aes(x=seq, y=n,fill=type) )+geom_bar(stat = "identity",position = "dodge")+
  facet_wrap(~year, ncol = 3)+scale_y_continuous(breaks= seq(1,30, by = 1), limits=c(0,30))+
  coord_polar(theta = "y")+ scale_fill_manual(values=c("deepskyblue2","orangered"),
                                              labels=c("Colder","Hotter"))+
  guides(fill=guide_legend(title = NULL))+labs(x=NULL,y=NULL)+
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        axis.text.y = element_text(size = 11 *0.8, angle = 0,colour = "gray5"), 
        strip.background = element_blank(), panel.background = element_blank(),
        panel.grid.major.x= element_line(colour = "gray10",linetype =1,size = 1 )
        
  )

p2 <- ggplot(data=extremes[3:4,], aes(x=seq, y=n,fill=type) )+geom_bar(stat = "identity",position = "dodge")+
  facet_wrap(~year, ncol = 3)+scale_y_continuous(breaks= seq(1,30, by = 1),limits=c(0,30))+ 
  coord_polar(theta = "y")+ scale_fill_manual(values=c("deepskyblue2","orangered"),
                                              labels=c("Colder","Hotter"))+
  guides(fill=guide_legend(title = NULL))+labs(x=NULL,y=NULL)+
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        axis.text.y = element_text(size = 11 *0.8, angle = 0,colour = "gray5"), 
        strip.background = element_blank(), panel.background = element_blank(),
        panel.grid.major.x= element_line(colour = "gray10",linetype =1,size = 1 ),
        panel.grid.minor.x= element_line(colour = "gray10",linetype =1,size = 1 ),
        panel.grid.major.y= element_line(colour = "gray10", linetype = 1,size = 2))

grid.arrange(p1,p2,nrow=1,ncol=2)

# attempt 2
ggplot(data = extremedays[1:138,], aes(x = year,y=temperature, colour=type, size=3))+
  scale_color_manual(values=c("deepskyblue2","orangered"))+
  geom_jitter(position = position_jitter(w = 0.5, h = 0.25))+
  scale_x_continuous(breaks=seq(1997,2014,by=1))+scale_y_continuous(breaks=seq(-18,34,by=3))+
  guides(size=FALSE)+
  theme(legend.position = "bottom", axis.ticks = element_blank(),
        axis.text.x = element_text(size = 11 *0.8, angle = 0, hjust = 0, colour = "grey40"),
        axis.text.y = element_text(size = 11*0.8),
        text= element_text(size = 11),
        panel.background = element_blank(), 
        panel.grid.minor= element_line(colour = "gray87"))


#attempt 3
ggplot()+geom_line(data = yearlyTemp, aes(x=(year),y=x))+
  geom_point(data = extremedays, aes(x = as.integer(year),y=temperature, colour=type, size=3),
             position = position_jitter(w = 0.2, h = 0.1))+
  
  scale_x_continuous(breaks=seq(1997,2014,by=1))+scale_y_discrete(breaks=seq(-12,42,by=3))

#attempt4
ggplot()+geom_area(data = dailymean, aes(y=Max_TemperatureC, x=Day), colour="orangered", stat = "iden")+
  geom_line(data = dailymean, aes(y=Min_TemperatureC, x=Day), colour="deepskyblue2")+
  geom_line(data = cph_c2[1:365,], aes(y=Max_TemperatureC, x=day), colour="darkolivegreen4")+
  facet_wrap(~Month, ncol = 3)+facet_wrap(~month, ncol=3)

#interactive chart for the anomalies
nPlot(n ~ year, group = "type", data = extremes, type = 'multiBarChart')
rPlot(temperature ~ year, data = extremedays, type = "point", color = "type")
##
ggplot+geom_point(data= rain,aes(x=week))+coord_polar()


ggplot()+  
  geom_area(data=dailytemperature[366:730,],aes(x=xaxis,y=Max_TemperatureC),fill="yellow",colour="white", stat = "identity")+
  geom_area(data=dailytemperature[366:730,],aes(x=xaxis,y=Min_TemperatureC),fill="deepskyblue2",colour="white", stat = "identity")+
  geom_area(data=dailymeanTemperature,aes(x=seq,y=Max_TemperatureC),fill="orangered", colour="white",alpha=0.6,stat = "identity")+
  geom_area(data=dailymeanTemperature,aes(x=seq,y=Min_TemperatureC),fill="darkseagreen2",colour="white",alpha=0.9, stat = "identity")
