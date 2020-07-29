require(magick)
require(ggplot2)
require(ggplotify)
require(shadowtext)
require(ggimage)
windows()
x = image_read("C:/Users/DELL/Desktop/bing/3.jpg")
p = as.ggplot(x)
#图上嵌图
smu = "http://www.wzu.edu.cn/dfiles/9987/template/default/newzhuzhan/wenda/images/logo.jpg"
#smu = "C:/Users/DELL/Desktop/bing/2.jpg"

p <- p + geom_rect(xmin=.2, xmax=.8, ymin=.4,
              ymax=.6, fill='steelblue', alpha=.5) +
	geom_image(x=.5, y=.5, image=smu, size=.4)
#寄语
msg = "填志愿一定要遵从本心\n第一眼看到哪个，就报哪个！"

p  + geom_shadowtext(
          x=.5, y=.8, label=msg,
          size=10, color='firebrick')

#参考https://mp.weixin.qq.com/s?__biz=MzI5NjUyNzkxMg==&mid=2247489599&idx=1&sn=e689331bc5500222ec7d0c1c61942362&chksm=ec43a978db34206ed932e7e086db00f707e5cb9f9aa4e38254e40c3ef642dee5693a03532994&mpshare=1&scene=1&srcid=07293Jcp2dA2gLL6If2GGh8s&sharer_sharetime=1596004011941&sharer_shareid=ee38888b33e1d0070e96aeb454518587&key=6614a0a10b7b6719e9a2b6aaf9b5a70639efbf3c7c8e8e92b20a32c4badbf01c713092a60b32600156388a8c91a282772e89bcfe2a7eb0236746b8e10cee021cae0a3722f18222f708988e462583107f&ascene=1&uin=OTk1MTUyNzI2&devicetype=Windows+10+x64&version=62090529&lang=zh_CN&exportkey=A%2FUKJTXVcz2E27Ve0FcZuIk%3D&pass_ticket=GHX0j6fsfiEATjqcMrcVQQYSihtF3L6yDim2tm78a1XP0v2qucpofrFRF8%2Bz4zjt



