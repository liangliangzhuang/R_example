# 有趣的图=====

# 1.画爱心蛋糕======
require(grid)
require(gridExtra)
require(yyplot)
library(devtools)
#install_github("GuangchuangYu/yyplot")
require(ggplot2)

t <- seq(0,2*pi, by=0.2)
x <- 16*sin(t)^3
y <- 13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t)
d <- data.frame(x=x, y=y)

ggplot(d, aes(x, y)) + geom_cake(size=0.1)


# 2.构建自己的二维码，只要输入链接即可==========
require(ggplot2)
require(ggimage)
require(yyplot)

ggqrcode("https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzI1NjUwMjQxMQ==&scene=124#wechat_redirect") #自己公众号


#表白用=======
ggqrcode('I miss you!')

d <- data.frame(x=1, y=1,
    img="C:/Users/DELL/Desktop/avatar.jpg")
p <- ggplot(d, aes(x,y)) + geom_image(aes(image=img), size=Inf) + theme_void()


p2 <- ggqrcode("http://mp.weixin.qq.com/s/oLgpTGdQgcka-OD757_3lA", "blue", alpha=.8)
p + geom_subview(p2, width=Inf, height=Inf, x=1, y=1)



pg <- ggqrcode("https://mp.weixin.qq.com/s/tposUJYrPuRnptXyNX03mA")
d <- data.frame(x=15, y=15,
    img="C:/Users/DELL/Desktop/avatar.jpg")
pg + geom_image(aes(x,y, image=img), data=d, size=.2)


geom_emoji("heart_eyes" )
ggplot() + geom_emoji("duck") + theme_void()

require(ggplot2)
require(magick)
require(purrr)

x <- search_emoji("heart")

plot_heart=function(x) {
 p = ggplot() + geom_emoji(x)
 o = paste0(x, ".png")
 ggsave(o, p, width=5, height=5)
 o
 }

x %>% map(plot_heart) %>% 
map(image_read) %>% 
image_join() %>% 
image_animate(fps=1) %>% 
image_write("heart.gif")

