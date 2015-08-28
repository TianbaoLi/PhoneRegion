#!/home/turingmac/R-3.2.1/bin/Rscript
library("maptools")
china_map=readShapePoly("/home/turingmac/R-3.2.1/chinamap/china-province-border-data/bou2_4p.shp")	#读取地图空间数据
#plot(china_map, usePolypath = FALSE)
library("mapproj")
library(ggplot2)
#ggplot(china_map,aes(x=long,y=lat,group=group))+geom_polygon(fill="white",colour="grey")+coord_map("polyconic")
china_map@data<- transform(china_map, NAME = iconv(NAME, from = 'GBK'))
x<-china_map@data	#读取行政信息
xs<-data.frame(x,id=seq(0:924)-1)	#含岛屿共925个形状
china_map1<-fortify(china_map)	#转化为数据框
library(plyr)
china_map_data <- join(china_map1, xs, type="full")	#合并两个数据框
mydata<-read.csv("/home/turingmac/PhoneRegion/data.csv")	#读取指标数据，csv格式
china_data<-join(china_map_data, mydata, type="full")	#合并两个数据框
midpos <- function(x) mean(range(x,na.rm=TRUE))
centres <- ddply(china_data,.(NAME),colwise(midpos,.(long,lat)))
province_city <- read.csv("/home/turingmac/R-3.2.1/chinamap/chinaprovincecity.csv")	#读取省会城市坐标
capital<- transform(province_city, province = iconv(province, from = 'UTF-8'))
pinyin<-read.csv("/home/turingmac/PhoneRegion/pinyin.csv")	#读取指标数据，csv格式
capital<-join(capital, pinyin, type="full")	#合并两个数据框
G1=ggplot(china_data,aes(long,lat))+geom_polygon(aes(group=group,fill=USER),colour="grey60")+scale_fill_gradient(low="white",high="steelblue")+coord_map("polyconic")+geom_text(aes(x = jd,y = wd,label = PINYIN), data =capital)+theme(panel.grid = element_blank(),panel.background = element_blank(),axis.text = element_blank(),axis.ticks = element_blank(),axis.title = element_blank())
G1
ggsave(G1, file="/home/turingmac/PhoneRegion/heatmap.pdf",scale=4)
