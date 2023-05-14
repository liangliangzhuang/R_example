# 代码解释见推文:https://mp.weixin.qq.com/s/ZjUuFtRT1j3ksaGD-hHnLg
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》

library(rgdal)
library(ggplot2)
library(maptools)
library(mapproj)
library(ggsn)
library(readxl)
library(sf)
show_data <- read_xlsx("测试数据.xlsx","hubei")
shp_data <- st_read("china_shp/CHN_adm2.shp")


shp_data$NL_NAME_2 <- as.character(shp_data$NL_NAME_2)
my_data <- dplyr::left_join(show_data, shp_data,by = c("city" = "NL_NAME_2"))
head(my_data)

ggplot(data = my_data) + geom_sf(aes(fill = as.factor(value), geometry = `geometry`)) + 
  geom_sf_text(aes(label = `city`,geometry = `geometry`), color = 'Black',size=2)+
  xlab("Long (°E)") + ylab("Lat (°N)") + 
  ##更改图形颜色，不加这个语句使用随机配色
  scale_fill_manual(
    "value",
    values = c("#DFD3F2", "#00C2F9", "#FFF7D0"),
    breaks = c("A", "B", "C"),
    labels = c("A", "B", "C")
  )+
  theme(legend.position = "top",panel.background = element_rect(fill = "white",color = "black"),
        panel.grid = element_line(color = "grey"))

## 绘制多个省份
hubei <- read_xlsx("测试数据.xlsx","hubei")
jiangxi <- read_xlsx("测试数据.xlsx","jiangxi")
all_province <- rbind(hubei,jiangxi)

shp_data <- st_read("china_shp/CHN_adm2.shp")
shp_data$NL_NAME_2 <- as.character(shp_data$NL_NAME_2)
data2 <- dplyr::left_join(all_province, shp_data,by = c("city" = "NL_NAME_2"))

ggplot(data = data2) + geom_sf(aes(fill = as.factor(value), geometry = `geometry`)) + 
  geom_sf_text(aes(label = `city`,geometry = `geometry`), color = 'Black',size=2)+
  xlab("Long (°E)") + ylab("Lat (°N)") + 
  ##更改图形颜色，不加这个语句使用随机配色
  scale_fill_manual(
    "value",
    values = c("#DFD3F2", "#00C2F9", "#FFF7D0"),
    breaks = c("A", "B", "C"),
    labels = c("A", "B", "C")
  )+
  theme(legend.position = "top",panel.background = element_rect(fill = "white",color = "black"),
        panel.grid = element_line(color = "grey"))
