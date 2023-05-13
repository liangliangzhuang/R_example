# 等高线图

# 等高线图（contour map）是可视化二维空间标量场的基本方法，可以将三维数据使用二维的方
# 法可视化，同时用颜色视觉特征表示第三维数据，如地图上的等高线、天气预报中的等压线和等温
# 线等。假设f(x, y)是在点(x, y)处的数值，等值线是在二维数据场中满足f(x, y)=c 的空间点集按一定的
# 顺序连接而成的线。数值为c 的等值线可以将二维空间标量场分为两部分：如果f(x, y)<c，则该点在
# 等值线内；如果f(x, y)>c，则该点在等值线外。
# 图4-3-1(a)为热力分布图，只是将三维数据(x, y, z)中(x, y)表示位置信息，z 映射到颜色。图4-3-1(b)
# 是在图4-3-1(a)的基础上添加等高线，同一轮廓上的数值相同。图4-3-1(c)是在图4-3-1(b)的基础上添
# 加等高线的具体数值，从而不需要颜色映射的图例，同一轮廓上的数值相同。在二维屏幕上，等高
# 线可以有效地表达相同数值的区域，揭示走势和陡峭程度及两者之间的关系，寻找坡、峰、谷等
# 形状。


library(directlabels)
library(reshape2)
library(ggplot2)
library(grDevices)

rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
colormap <- colorRampPalette(rev(brewer.pal(11,'Spectral')))(32)
# 数据
z <- as.matrix(read.table("等高线.txt",header=TRUE))
colnames(z) <- seq(1,ncol(z),by=1) #列名设置
head(z)
dim(z)
max_z <- max(z)
min_z <- min(z)
breaks_lines <- seq(min(z),max(z),by=(max_z-min_z)/10)
map <- melt(z) #这个函数来自reshape2（处理数据的包）介绍一下这个函数，以及相关函数
dim(map)
colnames(map)<-c("Var1","Var2","value")
head(map)
Contour <- ggplot(map,aes(x=Var1,y=Var2,z=value))+
	geom_tile(aes(fill=value))+#根据高度填充
	scale_fill_gradientn(colours=colormap)+
	geom_contour(aes(colour= ..level..),breaks=breaks_lines,color="black")+#
	labs(x="X-Axis",y="Y-Axis",fill="Z-Value")+
	theme(
		axis.title = element_text(size=15,face="plain",color="black"),
		axis.text = element_text(size=13,face="plain",color="black"),
		legend.title = element_text(size=13,face="plain",color="black"),
		legend.text = element_text(size=11,face="plain",color="black"),
		legend.background = element_blank(),
		legend.position = c(0.15,0.2)
	)
Contour

## 加维度
direct.label(Contour, list("bottom.pieces", cex=0.8, #"far.from.others.borders",
													 fontface="plain", fontfamily="serif", colour='black'))
