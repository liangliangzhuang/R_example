#========================================================================
#============================= Task =====================================
#========================================================================

setwd("C:/Users/DELL/Desktop/wechat/2020.07.15World_map")

# 世界疫情图==========
library(maps)
library(ggplot2)
library(RColorBrewer)
library(plyr)
colormap<-c(rev(brewer.pal(9,"Greens")[c(4,6)]), brewer.pal(9,"YlOrRd")[c(3,4,5,6,7,8,9)])
mydata1<-read.csv("Country_Data.csv",stringsAsFactors=FALSE)#这个是全球数据
names(mydata1)=c("Country","Scale") #重新命名
mydata2 =  read.csv("world_data.csv",header=TRUE)  #我们的数据（疫情）
head(mydata2)
#将两个表格匹配
mydata <- join(mydata1, mydata2, type="full") 
head(mydata)
#把ratio参数设置成分类型，以便于好绘制
mydata$fan<-cut(mydata$ratio,
breaks=c(min(mydata$million,na.rm=TRUE),
0,1000,5000,10000,50000,200000,500000,2000000,
max(mydata$ratio,na.rm=TRUE)),
labels=c(" <=0","0~1000","1000~5000","5000~10000","10000~50000","50000~200000",
"200000~500000","500000~2000000"," >=2000000"),
order=TRUE)
#定义地图用全球的
world_map <- map_data("world")
#绘图
ggplot()+
geom_map(data=mydata,aes(map_id=Country,fill=fan),map=world_map)+
geom_path(data=world_map,aes(x=long,y=lat,group=group),colour="black",size=.2)+
scale_y_continuous(breaks=(-3:3)*30) +
scale_x_continuous(breaks=(-6:6)*30) +
scale_fill_manual(name="Ratio",values= colormap,na.value="grey75")+
guides(fill=guide_legend(reverse=TRUE)) +
theme_minimal()

