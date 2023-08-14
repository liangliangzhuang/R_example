library(ggplot2)
library(viridis)
## 创建图形
plot1 <- ggplot(data = mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point(size=1.7) + scale_color_viridis(discrete = T) + 
  theme_bw() + theme(panel.grid = element_blank())  
  
plot2 <- ggplot(data = mpg, aes(x = cty, y = hwy, color = class)) +
  geom_point(size=1.7) + scale_color_viridis(discrete = T) +
  theme_bw() + theme(panel.grid = element_blank())

ggarrange(plot1, plot2)


# 合并图形并共享图例
## 方法一
library(ggpubr)
ggarrange(plot1, plot2, common.legend = TRUE, legend="top")
## 方法二
library(cowplot)
combined_plot <- plot_grid(plot1 + theme(legend.position = 'none'), plot2 + theme(legend.position = 'none'), ncol = 2)
# 将图例添加到合并后的图形中
plot_grid(combined_plot, get_legend(plot1),
          rel_widths = c(4, 1))
## 方法三
library(patchwork)
plot1 + plot2 + plot_layout(guides = "collect") &
  theme(legend.position='bottom')

