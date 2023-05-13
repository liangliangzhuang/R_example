library(geojsonsf)
library(sf)
library(ggplot2)
library(RColorBrewer)
library(ggspatial)
library(cowplot)

API_pre = "http://xzqh.mca.gov.cn/data/"

China = st_read(dsn = paste0(API_pre, "quanguo.json"), 
                stringsAsFactors=FALSE) 
st_crs(China) = 4326

# 2.国境线
China_line = st_read(dsn = paste0(API_pre, "quanguo_Line.geojson"), 
                     stringsAsFactors=FALSE) 
st_crs(China_line) = 4326

gjx <- China_line[China_line$QUHUADAIMA == "guojiexian",]


province <- read.csv("province.csv")

fig1 <-  ggplot()+
  # 绘制主图
  geom_sf(data = CHINA,fill='NA') +
  # 绘制国界线及十段线
  geom_sf(data = gjx)+
  ##添加省份名称
  geom_text(data = province,aes(x=dili_Jd,y=dili_Wd,label=省市),position = "identity",size=3,check_overlap = TRUE) +
  labs(title="中国地图")+
  theme(plot.title = element_text(color="black", size=16, face="bold",vjust = 0.1,hjust = 0.5),
        legend.title=element_blank(),
        legend.position = c(0.2,0.2),
        panel.grid=element_blank(),
        panel.background=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank()
  )+
  ##添加指北针，“style”参数可以更改样式
  annotation_north_arrow(location='tl', which_north='false',
                         style=north_arrow_orienteering())
fig1


# 读入数据
nine_lines = read_sf('南海.geojson') 

# 绘制九段线小图
fig2 = ggplot() +
  geom_sf(data = CHINA,fill='NA', size=0.5) + 
  geom_sf(data = nine_lines,color='black',size=0.5)+
  ##去掉主图的部分区域
  coord_sf(ylim = c(-4028017,-1877844),xlim = c(117131.4,2115095),crs="+proj=laea +lat_0=40 +lon_0=104")+
  theme(
    aspect.ratio = 1.25, #调节长宽比
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    panel.border = element_rect(fill=NA,color="grey10",linetype=1,size=0.5),
    plot.margin=unit(c(0,0,0,0),"mm"))
fig2

fig = ggdraw() +
  draw_plot(fig1) +
  draw_plot(fig2, x = 0.8, y = 0, width = 0.13, height = 0.39)
fig


colour <- read.csv("colour.csv")
head(colour)

colour$QUHUADAIMA <- as.character(colour$QUHUADAIMA)
CHINA <- dplyr::left_join(China,colour,by= "QUHUADAIMA")

fig1 <-  ggplot() +
  geom_sf(
    data = CHINA,
    aes(fill = factor(colour))) +
  ## 填色
  scale_fill_manual(
    "class",
    values = c("#9CEED3", "#79CBC2", "#5EA9AC", "#4B8793", "#3C6777"),
    breaks = c("0~200", "200~400", "400~600", "600~1000", "1000+"),
    labels = c("0~200", "200~400", "400~600", "600~1000", "1000+")
  ) +
  geom_sf(data = gjx) +
  geom_text(
    data = province,
    aes(x = dili_Jd, y = dili_Wd, label = 省市),
    position = "identity",
    size = 3,
    check_overlap = TRUE
  ) +
  labs(title = "中国地图") +
  theme(
    plot.title = element_text(
      color = "black",
      size = 16,
      face = "bold",
      vjust = 0.1,
      hjust = 0.5
    ),
    legend.title = element_blank(),
    legend.position = c(0.2, 0.2),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank()
  ) +
  annotation_north_arrow(
    location = 'tl',
    which_north = 'false',
    style = north_arrow_orienteering()
  )


# 读入九段线数据
nine_lines = read_sf('南海.geojson') 

# 绘制九段线小图
nine_map = ggplot() +
  geom_sf(data = CHINA,fill='NA', size=0.5) + 
  geom_sf(data = nine_lines,color='black',size=0.5)+
  coord_sf(ylim = c(-4028017,-1877844),xlim = c(117131.4,2115095),crs="+proj=laea +lat_0=40 +lon_0=104")+
  theme(
    aspect.ratio = 1.25, #调节长宽比
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    panel.border = element_rect(fill=NA,color="grey10",linetype=1,size=0.5),
    plot.margin=unit(c(0,0,0,0),"mm"))

# 使用cowplot包将大图小图拼在一起
fig = ggdraw() +
  draw_plot(fig1) +
  draw_plot(nine_map, x = 0.8, y = 0, width = 0.13, height = 0.39)
fig


colour$new_colour <- rep(0,nrow(colour))
##给目标省份赋予不同的数值
colour$new_colour[which(colour$shengfen=="重庆")] <- 1
colour$new_colour[which(colour$shengfen=="山西")] <- 2
colour$new_colour[which(colour$shengfen=="新疆")] <- 3
colour$new_colour[which(colour$shengfen=="内蒙古")] <- 4
CHINA <- dplyr::left_join(China,colour,by= "QUHUADAIMA")

fig1 <-  ggplot() +
  geom_sf(
    data = CHINA,
    aes(fill = factor(new_colour))) +
  scale_fill_manual(
    "class",
    values = c("#FFFFFF", "#79CBC2", "#5EA9AC", "#4B8793", "#3C6777"),
    breaks = c("0", "1", "2", "3", "4"),
    labels = c("0", "1", "2", "3", "4")
  )+
  geom_sf(data = gjx) +
  geom_text(
    data = province,
    aes(x = dili_Jd, y = dili_Wd, label = 省市),
    position = "identity",
    size = 3,
    check_overlap = TRUE
  ) +
  labs(title = "中国地图") +
  theme(
    plot.title = element_text(
      color = "black",
      size = 16,
      face = "bold",
      vjust = 0.1,
      hjust = 0.5
    ),
    legend.title = element_blank(),
    legend.position = c(0.2, 0.2),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank()
  ) +
  annotation_north_arrow(
    location = 'tl',
    which_north = 'false',
    style = north_arrow_orienteering()
  )


fig = ggdraw() +
  draw_plot(fig1) +
  draw_plot(nine_map, x = 0.8, y = 0, width = 0.13, height = 0.39)
fig

