
# 代码解释见推文：
# 作者：庄亮亮/庄闪闪



# 加载包
library(ggplot2)
library(dplyr)
library(hrbrthemes)

# 创建数据
dim1 = c(30,11) # 第一项x轴，第二项y轴
combinations <- expand.grid(1:dim1[1],1:dim1[2])
dat = cbind(1:dim(combinations)[1],combinations)
colnames(dat) = c("id","value1","value2")

# 拟合点数
dis1 = 10; dis2 = 4
dat$class = 0
for(i in 1:dim1[2]){
  dat$class[((dim1[1]+1)*(i-1) + 1):((dim1[1]+1)*(i-1) + dis1)] = 1
  dat$class[((dim1[1]+1)*(i-1) + dis1 + 1):((dim1[1]+1)*(i-1) + dis1 + dis2 - 1)] = 2
}

# 绘图
ggplot(data = dat,aes(value1,value2)) + 
  geom_segment(data = dat[dat$value1!=dim1[1], ],aes(x=value1, xend=value1+1, y=value2, yend=value2),color="grey",size=1) +
  geom_point(aes(color=as.factor(class)), size=3, shape = 19) + 
  scale_color_manual(values = c("grey","#2F6DA3","#CC9034"),name = "Class",labels = c("Nothing","Window","Forecasting horizon")) +
  scale_y_reverse(breaks = seq(1,12,3)) +
  scale_x_continuous(breaks = c(1,10,20,30)) +
  xlab("Time") + ylab("Window number") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        legend.position = "bottom",
        axis.line = element_line(colour = "black"))
