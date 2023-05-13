# 代码解释见推文：https://mp.weixin.qq.com/s/Dbx9J_flkTtyi7LtRAdRPQ
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》

# 构建模拟数据
library(ggplot2)
library(grid)
mydf <- data.frame(letter = factor(rep(c("A", "B", "C", "D"), each = 20)), x = rnorm(80), y = rnorm(80))
head(mydf)

# 基本绘图
ggplot(mydf, aes(x = x, y = y)) + 
  geom_smooth(method = "lm") + 
  geom_point() + 
  facet_wrap(~ letter)

# 设置表达式标签
f_names <- list('A' = expression(paste(alpha[2])), 'B' = expression(Gamma(3,4)), 'C' = expression(paste(y = beta[0] + beta[1]*x[1])), 'D' = expression(delta))
f_labeller <- function(variable, value){return(f_names[value])}
ggplot(mydf, aes(x = x, y = y)) + 
  geom_smooth(method = "lm") + 
  geom_point() + 
  facet_wrap(~ letter, labeller = f_labeller)


# 修改主题
ggplot(mydf, aes(x = x, y = y)) + 
  geom_smooth(method = "lm",color = "#e99e9c",fill = "#98c0d7") + 
  geom_point(color = "gray60") + 
  facet_wrap(~ letter, labeller = f_labeller,scales = "free") +
  theme_bw() + ylab("Value") + xlab("Time") + #主题设置
  theme(panel.grid = element_blank(), 
        strip.background = element_blank()) 


# 添加中文标签

f_names <- list('A' = "庄闪闪", 'B' = "庄亮亮", 
                'C' = "庄晶晶", 'D' = "庄暗暗") # 设置标签

library(showtext)
showtext.auto()

f_labeller <- function(variable, value){return(f_names[value])}
ggplot(mydf, aes(x = x, y = y)) + 
  geom_smooth(method = "lm",color = "#e99e9c",fill = "#98c0d7") + 
  geom_point(color = "gray60") + 
  facet_wrap(~ letter, labeller = f_labeller,scales = "free") +
  theme_bw() + ylab("Value") + xlab("Time") + #主题设置
  theme(panel.grid = element_blank(), 
        strip.background = element_blank()) 
