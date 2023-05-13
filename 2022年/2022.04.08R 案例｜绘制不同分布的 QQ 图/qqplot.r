# 代码解释见推文：https://mp.weixin.qq.com/s/ncorK41sntA4iBJWBCdVkA
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》
# 参考博客：An Introduction to qqplotr: https://cran.r-project.org/web/packages/qqplotr/vignettes/introduction.html

# 1. 加载包
library(qqplotr)
library(ggplot2)

# 2. 随机产生数据
set.seed(0)
smp <- data.frame(norm = rnorm(100))

# 3. 绘制正态分布的 QQ 图
gg <- ggplot(data = smp, mapping = aes(sample = norm)) +
  stat_qq_band() +
  stat_qq_line() +
  stat_qq_point() +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles")
gg

# 4.拓展
library(viridis)
gg <- ggplot(data = smp, mapping = aes(sample = norm)) +
  geom_qq_band(bandType = "ks", mapping = aes(fill = "KS"), alpha = 0.9) +
  geom_qq_band(bandType = "ts", mapping = aes(fill = "TS"), alpha = 0.9) +
  geom_qq_band(bandType = "pointwise", mapping = aes(fill = "Normal"), alpha = 0.9) +
  geom_qq_band(bandType = "boot", mapping = aes(fill = "Bootstrap"), alpha = 0.9) +
  stat_qq_line() +
  stat_qq_point() +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") +
  scale_fill_viridis(discrete = T,direction = -1)

gg

# 进阶版本

data = data.frame('y' = c(1.339, 1.434, 1.549, 1.574 ,1.589, 1.613, 1.746 ,1.753, 1.764 ,1.807, 1.812, 1.84, 1.852, 1.852, 1.862, 1.864, 1.931, 1.952, 1.974, 2.019, 2.051, 2.055, 2.058 ,2.088, 2.125, 2.162, 2.171, 2.172 ,2.18 ,2.194 ,2.211 ,2.27, 2.272, 2.28, 2.299, 2.308, 2.335 ,2.349 ,2.356 ,2.386, 2.39, 2.41, 2.43, 2.431, 2.458, 2.471, 2.497, 2.514 ,2.558, 2.577, 2.593, 2.601, 2.604, 2.62 ,2.633, 2.67, 2.682, 2.699, 2.705, 2.735, 2.785, 2.785,3.02, 3.042, 3.116, 3.174))

## 绘制指数分布的 QQ 图
dp <- list(rate = 2.2867)
di <- "exp"
p1 = ggplot(data = data, mapping = aes(sample = y)) +
  stat_qq_band(distribution = di, dparams = dp) +
  stat_qq_line(distribution = di, dparams = dp) +
  stat_qq_point(distribution = di, dparams = dp) +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") +
  theme_bw() + 
  theme(panel.grid = element_blank())
p1

## 绘制威布尔分布的 QQ 图
# weibull distribution
di <- "weibull" # exponential distribution
dp <- list(shape=5.4766,scale=2.4113)
p2 = ggplot(data = data, mapping = aes(sample = y)) +
  stat_qq_band(distribution = di, dparams = dp) +
  stat_qq_line(distribution = di, dparams = dp) +
  stat_qq_point(distribution = di, dparams = dp) +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") +
  theme_bw() + 
  theme(panel.grid = element_blank())
p2

## 合并两幅 QQ 图
library(cowplot)
plot_grid(p1, p2, ncol = 2, nrow = 1)





