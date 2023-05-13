# 代码解释见推文：https://mp.weixin.qq.com/s/bQ_aefTxk32x30Avfzv5kw
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》



# =====绘制混合密度函数图以及添加分位数线=====

# 加载包
library(ggplot2)
library(ggridges)

# 产生数据集
item <- 10000
inds <- rbinom(1, item, 0.5)
x <- c(rnorm(inds, 1, 1), rnorm(item - inds, 8, 1))
data <- data.frame("value" = x, "class" = rep(1, length(x)))

# 绘制密度函数图并添加分位数线

# 绘图
p1 <- ggplot(data, aes(x = value, y = class, fill = factor(stat(quantile)))) +
  stat_density_ridges(
    geom = "density_ridges_gradient",
    calc_ecdf = TRUE,
    quantiles = c(0.025, 0.975) #添加分为数线
  ) +
  scale_fill_manual(
    name = "Probability", values = c("#E2EAF6", "#436FB0", "#E2EAF6")
  ) +
  theme_bw() +
  theme(legend.position = "none", panel.grid = element_blank()) +
  labs(x = "x", y = "Density")
p1


p2 <- ggplot(data, aes(x = value, y = class, fill = factor(stat(quantile)))) +
  stat_density_ridges(
    geom = "density_ridges_gradient",
    calc_ecdf = TRUE,
    quantiles = c(0.005, 0.495, 0.51, 0.99)
  ) +
  scale_fill_manual(
    name = "Probability", values = c("#E2EAF6", "#436FB0", "#E2EAF6", "#436FB0", "#E2EAF6"),
  ) +
  theme_bw() +
  theme(legend.position = "none", panel.grid = element_blank()) +
  labs(x = "x", y = "Density")

p2


# 合并两图
library(cowplot)
# pdf("plot_cow.pdf", width = 8, height = 4)
plot_grid(p1, p2, ncol = 1, nrow = 2)
# dev.off()
