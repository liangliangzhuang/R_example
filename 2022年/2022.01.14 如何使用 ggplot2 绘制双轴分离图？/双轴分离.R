# 代码解释见推文：https://mp.weixin.qq.com/s/QiMHA10X8nGtK5iOH4armQ
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》

library(ggplot2)
library(dplyr)
library(ggthemes)
library(viridis)
# Build the demo data set.
df1 <- data.frame(
  term = paste0('term', 1:4),
  p.val = runif(4, 1, 5)
)
df2 <- data.frame(x = c(0,2,4,6), y = df1$term)
# （初级版本）============
ggplot(df1, aes(p.val, term)) +
  geom_col(width = 0.6) +
  labs(x = '-log(BH p value)', 
       y = 'Terms')
# （高级版本）============
ggplot(df1, aes(p.val, term)) +
  geom_col(aes(fill = term), width = 0.6) +
  geom_rangeframe(data = df2, aes(x = x, y = y), sides = 'bl') +
  scale_fill_viridis(discrete = T)+
  theme_tufte() +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.text = element_text(size = rel(1.1))
  ) +
  labs(x = '-log(BH p value)', 
       y = 'Terms')
#================

df1 <- data.frame(
  term = paste0('term', 1:8),
  p.val = runif(8, 1, 5),
  score = rnorm(8, 0, 1)
)
df2 <- data.frame(x = c(0:6,6), y = df1$term)

ggplot(df1, aes(p.val, term)) +
  geom_col(aes(fill = score), width = 0.6) +
  geom_rangeframe(data = df2, aes(x = x, y = y), sides = 'bl') +
  scale_fill_gradient2(
    low = 'cyan',
    mid = '#fbffff',
    high = 'chocolate1',
    midpoint = 0)+
  theme_tufte() +
  theme(
    legend.position = c(0.9,0.75),
    panel.grid = element_blank(),
    axis.text = element_text(size = rel(1.1))
  ) +
  labs(x = '-log(BH p value)', 
       y = 'Terms')
