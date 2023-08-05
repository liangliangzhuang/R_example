# =============== 局部细节放大图 ===============
library(ggplot2)
library(patchwork)
library(tidyverse)
# 1. 生成模拟数据
com_battery = data.frame("Time" = 1:30,"True" = cumsum(abs(rnorm(30,2,0.4))),
                          "Proposed" = cumsum(abs(rnorm(30,2,0.5))),
                          "Linear" = cumsum(abs(rnorm(30,2,0.4))), 
                          "Power" = cumsum(abs(rnorm(30,2,0.1))),
                          "Exp" = cumsum(abs(rnorm(30,2,0.3))))

cols <- c("black","#85BA8F", "#A3C8DC","#349839","#EA5D2D","#EABB77","#F09594")
# 2.基础绘图
p = com_battery %>% pivot_longer(cols = !Time, names_to = "Model", values_to = "Value") %>%
  mutate(Model = factor(Model, levels = c("True", "Proposed", "Linear","Power","Exp"))) %>% 
  ggplot(aes(Time,Value,col = Model,shape = Model)) + 
  geom_line() + geom_point(size=1.5,alpha=0.8) + 
  # scale_color_viridis(discrete = T) +
  scale_color_manual(values = cols) +
  theme_bw() + theme(panel.grid = element_blank()) + #,legend.title=element_text(size=12), legend.text=element_text(size=11) +
  xlab("Time") + ylab("Rate(%)")

## 方法一：ggforce
library(ggforce) 
p + facet_zoom(xlim = c(18, 24),ylim = c(40, 43), zoom.size = 0.4)

## 方法二：patchwork
library(patchwork)
# 绘制放大图
ppp = p + xlim(5,10) + ylim(10,20) + theme(legend.position = 'none') +
  xlab("") + ylab("") 
ppp 
# 添加到原图中
p +   
  geom_rect(aes(xmin = 5, xmax = 10, ymin = 10, ymax = 20),
            fill = "transparent", color = "black", alpha = 0, 
            linetype = "dashed", linewidth =0.2) + #添加选择放大位置的框
  theme(legend.position = c(0.9,.2),legend.background = element_rect(fill = 'white', colour = 'black')) + #修改图例位置
  geom_segment(aes(x = 7, xend = 10, y = 20, yend = 38.3), 
               col = "gray60", linewidth =0.2,linetype = "dashed",
               arrow = arrow(length = unit(0.2, "cm"), type = "closed")) + # 添加指向箭头
  inset_element(ppp, 0.01, 0.6, 0.6, 0.95, on_top = TRUE)







