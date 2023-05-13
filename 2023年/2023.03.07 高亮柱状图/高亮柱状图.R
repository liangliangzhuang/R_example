# 代码细节解释见推文：https://mp.weixin.qq.com/s/Rml11BcLE5_fLKckfob9Wg
# 作者：庄亮亮/庄闪闪


# 导入 ggplot2 和 reshape2 包
library(ggplot2)
library(reshape2)

# 创建数据框
data <- data.frame(
  Method = c("A", "B", "C", "D"),
  RMSE = c(1.5, 2.3, 1.9, 2.1),
  RB = c(0.8, 1.2, 1.5, 0.7)
)
head(data)

## ggplot2版本 ===========

# 使用ggplot2创建柱状图
h1 <- c("red", "grey", "grey", "grey")
p1 = ggplot(data, aes(x = Method, y = RMSE, fill = Method)) +
  geom_col() + 
  scale_fill_manual(values = h1)  

h2 <- c("grey", "grey", "grey","red")
p2 = ggplot(data, aes(x = Method, y = RB, fill = Method)) +
  geom_col() + 
  scale_fill_manual(values = h2)  

library(cowplot)
plot_grid(p1,p2)

# ==============================================================================
## ggcharts 包

library(ggcharts)
library(dplyr)
data("biomedicalrevenue")
revenue2018 <- biomedicalrevenue %>%
  filter(year == 2018)
head(revenue2018)

ggcharts_set_theme("theme_ggcharts")
bar_chart(
  revenue2018,
  company,
  revenue,
  top_n = 10,
  highlight = "Roche"
)


ggcharts_set_theme("theme_ng")
bar_chart(
  revenue2018,
  company,
  revenue,
  top_n = 10,
  highlight = "Roche"
)

ggcharts_set_theme("theme_ggcharts")
biomedicalrevenue %>%
  filter(year %in% c(2012, 2014, 2016, 2018)) %>%
  bar_chart(
    company,
    revenue,
    facet = year,
    top_n = 12,
    highlight = "Bayer"
  )
head(biomedicalrevenue)



## ==========
data_long <- tidyr::gather(data, Metric, Value, -Method)
head(data_long)
data_long %>%
  bar_chart(
    Method,
    Value,
    facet = as.factor(Metric),
    top_n = 12,
    highlight = "A",
    horizontal = T
  )







