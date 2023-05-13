# 代码解释见推文:https://mp.weixin.qq.com/s/qCNTvFCgaNBH_HJQ_U7uPg
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》

# 绘制浙江省地图 ===========
library(leaflet)
library(leafletCN)
region = regionNames("浙江")
dem_data = c(30,52,20,27,16,37,38,42,39,76,45) # 这里转换成自己的数据
dat = data.frame(region,dem_data)
map = leafletGeo("浙江", dat)

#涂色环节
pal <- colorNumeric(
  palette = "Greens",
  domain = map$value)

#载入高德地图amap
leaflet(map) %>% amap() %>%
  #加入框边界及颜色
  addPolygons(stroke = TRUE,
              smoothFactor = 2,
              fillOpacity = 1.7,
              weight = 4,
              color = ~pal(value),
              popup = ~htmltools::htmlEscape(popup)
  ) %>%
  #加入右下角边框
  addLegend("bottomright", pal = pal, values = ~value,
            title = "legendTitle",
            labFormat = leaflet::labelFormat(prefix = ""),
            opacity = 1)
