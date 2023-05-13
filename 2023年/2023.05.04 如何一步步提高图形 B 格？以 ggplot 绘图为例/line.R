
# 代码解释见推文：https://mp.weixin.qq.com/s/k5VgsK7e4d9RDrTkctJP6g
# 作者：庄亮亮/庄闪闪
## 主要参考书籍《THE HITCHHIKER’S GUIDE TO GGPLOT2》

library(ggplot2) 
library(ggthemes) 
library(dplyr) 
library(readr)

chilean.exports = "year,product,export,percentage
                  2006,copper,4335009500,81 
                  2006,others,1016726518,19 
                  2007,copper,9005361914,86 
                  2007,others,1523085299,14 
                  2008,copper,6907056354,80 
                  2008,others,1762684216,20 
                  2009,copper,10529811075,81 
                  2009,others,2464094241,19 
                  2010,copper,14828284450,85 
                  2010,others,2543015596,15 
                  2011,copper,15291679086,82 
                  2011,others,3447972354,18 
                  2012,copper,14630686732,80 
                  2012,others,3583968218,20 
                  2013,copper,15244038840,79 
                  2013,others,4051281128,21 
                  2014,copper,14703374241,78 
                  2014,others,4251484600,22 
                  2015,copper,13155922363,78 
                  2015,others,3667286912,22
"

charts.data = read_csv(chilean.exports)

p1 = ggplot(aes(y = export, x = year, colour = product), data = charts.data) + 
  geom_line() 
p1

p1 = ggplot(aes(y = export, x = year, colour = product), data = charts.data) + 
  geom_line(linewidth = 1.5) 
p1


p1 = p1 + scale_x_continuous(breaks = seq(2006,2015,1))
p1


p1 = p1 +
  labs(title = "Composition of Exports to China ($)", subtitle = "Source: The Observatory of Economic Complexity") +
  labs(x = "Year", y = "USD million")
p1

colour = c("#5F9EA0", "#E1B378") 
p1 = p1 + scale_colour_manual(values = colour) 
p1

library(viridis)
p1 = p1 + scale_color_viridis(discrete=T) 


p1 + theme_bw() + 
  theme(panel.grid = element_blank(),
        legend.position = "bottom",
        legend.direction = "horizontal")

library(ggthemes)
p1 + geom_point(size = 3) +
  theme_economist() + 
  scale_colour_economist() +
  theme(panel.grid = element_blank(),
        legend.position = "bottom",
        legend.direction = "horizontal")

library(showtext)


font_add("ZSS","SanJiLuRongTi-2.ttf")
font_add("ZSS2","No.019-Sounso-Quality-2.ttf")
