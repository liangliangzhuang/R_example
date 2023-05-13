#===============================================================
#======================== 温州市地图绘制 =======================
#===============================================================


library(leafletCN)
library(dplyr)
library(leaflet)
#demomap("温州")


#主函数——geojsonmap：地图标色函数  
data = read.csv("各区县经营效率平均值.csv",header=T)
data$mean = apply(data[,2:13],1,mean)
colnames(data) = c('region',as.character(2009:2020),"mean")
dim(data)
region = regionNames("温州市")
dat = data.frame(region,runif(length(region)))
data1 = full_join(dat,data[,c(1,8)])
data2 = data1[,-2]
map = leafletGeo("温州市", data2)

#涂色环节heat.colors(6,rev = T)
# c("#FFFF00FF","#FF0000FF","#00FF00FF","#00FFFFFF","#FF00FFFF","#0000FFFF")
pal <- colorNumeric(
palette = c("purple","blue","lightblue","green","yellow","orange",'red'),
domain = map$value)

#载入高德地图amap
leaflet(map) %>% amap() %>%
#加入框边界及颜色
    addPolygons(stroke = TRUE,
                smoothFactor = 1,
                fillOpacity = 1,
                weight = 1,
                color = ~pal(value),
                popup = ~htmltools::htmlEscape(popup)
    ) %>%
    #加入右下角边框
    addLegend("bottomright", pal = pal, values = ~value,
              title = "效率值",
              labFormat = leaflet::labelFormat(prefix = ""),
              opacity = 2) 




