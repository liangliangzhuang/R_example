# 代码解释见推文：https://mp.weixin.qq.com/s/V8H-U719PjCgsn1lVY_PFg
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》


# 数据产生
set.seed(1) #确保不同机子产生的随机数相同
mu = c(2,5)
std = c(1,1)
num = 1000
r1 = rnorm(num,mu[1],std[1]) #正态分布
r2 = rnorm(num,mu[2],std[2]) #正态分布
data = data.frame('value' = c(r1,rep(NA,num),r2,rep(NA,5*num)),
                  'class' = factor(rep(c(1:8),each= num)))
knitr::kable(head(data))

# 定义主题
theme_manual = function(){ 
  theme(panel.grid = element_blank(),
        panel.border = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position="none") 
}

# 画图

ggplot(data, aes(x = value, y = class,fill = factor(stat(quantile)))) + 
  # 添加密度函数图
  stat_density_ridges(
    geom = "density_ridges_gradient",
    calc_ecdf = TRUE,rel_min_height = 0.02,
    quantiles = c(0.025, 0.975),
    alpha = 1,scale = 0.6,bandwidth = 1
  ) +
  scale_fill_manual(
    name = "Probability", values = c("#FF0000A0", "white", "#FF0000A0"),
    labels = c("(0, 0.025]", "(0.025, 0.975]", "(0.975, 1]")
  ) + 
  # 手动一条条添加各种线段，文字
  annotate("segment", x = mu[1], xend = mu[1], y = 1, yend = 7,colour = "black") +
  annotate("segment", x = mu[2]-1, xend = mu[2]-1, y = 1, yend = 7,colour = "#0000FFA0",lty = "dashed") +
  annotate("segment", x = mu[1]-2.15, xend = mu[1]-2, y = 1, yend = 7,colour = "#0000FFA0",lty = "dashed") +
  annotate("segment", x = mu[2], xend = mu[2], y = 3-0.02, yend = 4.18,colour = "black") +
  annotate("segment", x = 0, xend = 10, y = 3, yend = 3,colour = "black") +
  annotate("segment", x = -3, xend = 7, y = 1, yend = 1,colour = "black") +
  annotate("text", x = mu[1], y = 0.7, label = expression(mu[T])) +
  annotate("text", x = mu[1]-2.15, y = 0.7, label = expression(alpha[1])) + 
  annotate("text", x = mu[1]+2, y = 0.7, label = expression(alpha[2])) +
  annotate("text", x = mu[2], y = 2.8, label = expression(mu[T])) +
  annotate("text", x = 0.5, y = 3.9, label = expression(beta)) + 
  annotate(geom = "line",x = c(0.8, 3.1),
           y = c(3.8, 3.2),
           arrow = arrow(angle = 20, length = unit(4, "mm"))) + # 添加线段并且包含箭头
  annotate("text", x = mu[1], y = 7.3, label = "CL") +
  annotate("text", x = mu[2]-1, y = 7.4, label = "LCL") +
  annotate("text", x = mu[1]-2, y = 7.4, label = "UCL") +
  annotate("text", x = -1.3, y = 2.3, label = expression(alpha[1] + alpha[2] == alpha)) +
  coord_flip() + # 转换横纵坐标
  theme_bw() + # 主题设置
  theme_manual() + xlab('') + ylab('')

