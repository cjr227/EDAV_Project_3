AL<-read.csv("data/annualLoad.csv",skip=12)
Site_location<-read.csv("data/Site_attribute.csv",skip=10)
#combind data with site attribution
Full_data<-merge(AL, Site_location)
Full_data1<-Full_data[,c(1,3,9,14,15)]
#get each nutrients
nitrate_nitrite<-subset(Full_data1, CONSTIT=="NO3_NO2")
total_nitrogen<-subset(Full_data1, CONSTIT=="TN")
total_phosphorus<-subset(Full_data1, CONSTIT=="TP")
ssc<-subset(Full_data1, CONSTIT=="SSC")
#Create SSC shingle for xyplot
tmp1<-c(0,60,120,180,max(ssc$FWC))
SSC<-shingle(ssc$FWC, intervals=cbind( tmp1[-5], tmp1[-1] ) ) 
#Create shingle for TP
tmp2<-c(0,0.025,0.05,0.1,max(total_phosphorus$FWC))
Total_Phosphorus<-shingle(total_phosphorus$FWC, intervals=cbind( tmp2[-5], tmp2[-1] ) ) 
#Create shingle for TN
tmp3<-c(0,0.8,2,10,max(total_nitrogen$FWC))
Total_Nitrogen<-shingle(total_nitrogen$FWC,interval=cbind( tmp3[-5],tmp3[-1]))
#Create shingle for NO3_NO2
tmp4<-c(0,1,2.5,5,10,15)
Nitrate_Nitrite<-shingle(nitrate_nitrite$FWC,cbind ( tmp4[-6],tmp4[-1])) 
library(lattice)
library(grid)
library(maps)
#Trellis plot for SSC
 
MyText1 <-c("0 mg/L<SSC<60 mg/L","60 mg/L<SSC<120 mg/L","120 mg/L<SSC<180 mg/L","SSC>180 mg/L")
xyplot(LATITUDE~LONGITUDE | SSC, data = ssc, xlab="Longitude", ylim=c(25,55),
       xlim=c(-135,-60),
       ylab = "Latitude", pch=16,cex=1,col="darkorange3",
       main="Suspended Sediment Concentration",
       panel=function(x, y,...) {
         panel.polygon(mymap$x,mymap$y,fill=TRUE,col="lightblue1")
         panel.xyplot(x,y,...)
         grid.text(MyText1[panel.number()], unit(0.5, 'npc'), unit(0.9, 'npc'))
       })
#Trellis plot for TP
MyText2<-c("0 mg/L<TP<0.025 mg/L","0.025 mg/L<TP<0.05 mg/L","0.05 mg/L<TP<0.1 mg/L","TP>0.1 mg/L")
xyplot(LATITUDE~LONGITUDE | Total_Phosphorus, data = total_phosphorus, xlab="Longitude", ylim=c(25,55),
       xlim=c(-135,-60),
       ylab = "Latitude", pch=16,cex=1,col="darkorange3",
       main="Total Phosphorus",
       panel=function(x, y,...) {
         panel.polygon(mymap$x,mymap$y,fill=TRUE,col="lightblue1")
         panel.xyplot(x,y,...)
         grid.text(MyText2[panel.number()], unit(0.5, 'npc'), unit(0.9, 'npc'))
       })
#Trellis plot for TN
MyText3<-c("0 mg/L<TN<0.8 mg/L","0.8 mg/L<TN<2 mg/L","2 mg/L<TN<10 mg/L","TN>10 mg/L")
xyplot(LATITUDE~LONGITUDE | Total_Nitrogen, data = total_nitrogen, xlab="Longitude", ylim=c(25,55),
       xlim=c(-135,-60),
       ylab = "Latitude", pch=16,cex=1,col="darkorange3",
       main="Total Nitrogen",
       panel=function(x, y,...) {
         panel.polygon(mymap$x,mymap$y,fill=TRUE,col="lightblue1")
         panel.xyplot(x,y,...)
         grid.text(MyText3[panel.number()], unit(0.5, 'npc'), unit(0.9, 'npc'))
       })
#Trellis plot for NO3_NO2
MyText4<-c("0 mg/L<NN<1 mg/L","1 mg/L<NN<2.5 mg/L","2.5 mg/L<NN<5 mg/L","5 mg/L<NN<10 mg/L","NN>10 mg/L")
xyplot(LATITUDE~LONGITUDE | Nitrate_Nitrite , data = nitrate_nitrite, xlab="Longitude", ylim=c(25,55),
       xlim=c(-135,-60),
       ylab = "Latitude", pch=16,cex=1,col="darkorange3",
       main="Nitrate & Nitrite",
       panel=function(x, y,...) {
         panel.polygon(mymap$x,mymap$y,fill=TRUE,col="lightblue1")
         panel.xyplot(x,y,...)
         grid.text(MyText4[panel.number()], unit(0.5, 'npc'), unit(0.9, 'npc'))
       })


