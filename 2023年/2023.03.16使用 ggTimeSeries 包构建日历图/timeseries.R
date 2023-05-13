
# 代码解释见推文：https://mp.weixin.qq.com/s/rAlPbNh2bYuNkqyT9dxosQ
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》

# 构建数据
set.seed(20230309)
library(tidyverse)
dtData <- tibble(
  DateCol = seq(
    as.Date("1/01/2020", "%d/%m/%Y"),
    as.Date("31/12/2022", "%d/%m/%Y"), "days"
  ),
  ValueCol = sample(
    c('a', 'b', 'c', 'd', 'e'),
    1096,
    prob = c(0.7, 0.1, 0.1, 0.05, 0.05),
    replace = TRUE
  )
)

head(dtData)

library(ggTimeSeries)
library(ggplot2)

p = ggplot_calendar_heatmap(
  dtData, dayBorderSize = 1,
  monthBorderSize = 1,dayBorderColour = "white",
  'DateCol',monthBorderColour = "white",
  'ValueCol'
)

# adding some formatting
col <- c("#EBEDF0", "#CBE491", "#89C876", "#459944", "#2C602C")
p + 
  scale_fill_manual(values = col) + 
  facet_wrap(~Year, ncol = 1,strip.position = "right") +
  theme( panel.background = element_blank(),
         legend.text = element_blank(),
         panel.border = element_rect(colour="grey60",fill=NA),
         strip.background = element_blank(),
         strip.text = element_text(size=13,face="plain",color="black"),
         axis.line=element_line(colour="black",size=0.25),
         axis.title=element_text(size=10,face="plain",color="black"),
         axis.text = element_text(size=10,face="plain",color="black")) +
  xlab('') + 
  ylab('') +  
  labs(fill = "Freq") 

