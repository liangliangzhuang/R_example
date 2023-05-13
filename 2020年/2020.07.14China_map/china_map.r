#9.1中国疫情图============
#（https://my.oschina.net/u/2306127/blog/473842）
library(mapdata)
library(maptools)
library(ggplot2)
library(plyr)
china_map = readShapePoly("bou2_4p.shp")#导入shp格式的中国地图
x<-china_map@data
xs<-data.frame(x,id=seq(0:924)-1)#地图中共计有925个地域信息
china_map1<-fortify(china_map)  #转化为数据框
china_map_data<-join(china_map1,xs,type="full")#基于id进行连接
a = data.frame(unique(china_map@data$NAME))
#准备数据
mydata<-read.csv("data_dt.csv",header=T,as.is=T)
china_data <- join(china_map_data, mydata, type="full")#基于NAME字段进行连接，NAME字段来自于地图文件中

#3、绘制地图

## 版本一(无省份名称的当日各省确认人数)
ggplot(china_data, aes(x = long, y = lat, group = group, fill = people)) +    
    geom_polygon(colour="grey40") +
    scale_fill_gradient(low="white",high="steelblue") +#指定渐变填充色，可使用RGB
    theme( #清除不需要的元素
        panel.grid = element_blank(),
        panel.background = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        legend.position = c(0.2,0.3)
      )    

## 版本二（有省份名称的当日各省确认人数）
midpos <- function(x) mean(range(x,na.rm=TRUE)) #取形状内的平均坐标
centres <- ddply(china_data,.(NAME),colwise(midpos,.(long,lat)))

ggplot(china_data,aes(long,lat))+      #此处语法与前面不同，参考ggplot2一书P85
    geom_polygon(aes(group=group,fill=people),colour="black")+
    scale_fill_gradient(low="white",high="steelblue") +
    geom_text(aes(label=NAME),data=centres) +
    theme(
         panel.grid = element_blank(),
        panel.background = element_blank(),
         axis.text = element_blank(),
         axis.ticks = element_blank(),
         axis.title = element_blank()
        )


