# 代码解释见推文:https://mp.weixin.qq.com/s/fzcGJugs0VxJpM6nb25hLA
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》

# 生成数据

# 导入包
library(ggplot2)

set.seed(1)
dat = data.frame("time" = rep(2013:2019,6),
                 "method" = rep(LETTERS[1:6],each = 7),
                 "value" = rnorm(7*6,5,1),
                 "upper" = rnorm(7*6,5,1) + abs(rnorm(7*6,2,0.1)),
                 "lower" = rnorm(7*6,5,1) - abs(rnorm(7*6,2,0.1))
)
head(dat)

# 基础版本绘图
cols <- c("#85BA8F", "#A3C8DC","#349839","#EA5D2D","#EABB77","#F09594") #设置颜色

p = ggplot(dat,aes(x = time, y = value,fill = method)) +                                                       
  geom_line(aes(color = method)) + #添加线
  geom_point(aes(color = method)) + #添加散点
  geom_ribbon(aes(ymin=lower, ymax=upper), alpha=0.3) + #添加区间
  scale_x_continuous(breaks = 2013:2019) +
  facet_wrap(vars(method),nrow = 4) + 
  theme_bw() + ylab("Value") + xlab("Time") + #主题设置
  theme(panel.grid = element_blank())
p

# 刻度尺修改
## x
p + facet_wrap(vars(method),nrow = 4,scales = "free_x")
## y 
p + facet_wrap(vars(method),nrow = 4,scales = "free_y")
## 双轴
p + facet_wrap(vars(method),nrow = 4,scales = "free")

## 标题框调整
p + facet_wrap(vars(method),nrow = 3,strip.position = "left")

## 去除标题框背景
p + theme(
  strip.background = element_blank() #去除标题框背景
)

## 修改标题框背景颜色
p + theme(strip.background=element_rect(colour="black",
                                        fill="#2072A8"))

## 修改标题框文字颜色
p +  theme(strip.text.x=element_text(colour="white"))


## 删除标题框
p +  theme(strip.text.x = element_blank())


