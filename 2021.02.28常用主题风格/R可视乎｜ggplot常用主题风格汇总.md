

借助`theme()`函数，可以自定义ggplot2图表的任何部分。 幸运的是，可以使用大量的预构建主题，仅用一行代码即可获得良好的样式。小编汇总了常用几个包的主题风格以供参考，以后可以根据论文的风格选择内置的一些主题。

## 1.具体操作

这里使用iris数据集，给出绘制散点图的例子，这里没有对主题风格进行设置，使用了默认主题。
```r
library(ggplot2)
ggplot(iris,aes(x = Sepal.Length,y = Sepal.Width,col = Species,shape = Species)) +
  geom_point()
```

如果你想更换主题，可以直接在之后加入对应参数即可，例如

```r
library(ggplot2)
ggplot(iris,aes(x = Sepal.Length,y = Sepal.Width,col = Species,shape = Species)) +
  geom_point() +
  theme_bw()
```

接下来，我们对常用的主题风格进行汇总。

## 2.ggplot2包

ggplot2包内部就有一些内置主题样式。

### default

![](https://static01.imgkr.com/temp/12bc9ce4738f4eb58f4f3b92063247fd.png)

### theme_bw()

![](https://static01.imgkr.com/temp/5e6e4b3ea8f74a4c9d1d9f3c48b176ad.png)

### theme_minimal()

![](https://imgkr2.cn-bj.ufileos.com/d60b293c-7cb7-4870-a561-9518455d60ed.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=f66%252FptGu2ii4wKaNV5VZpUzZZQg%253D&Expires=1614591717)

### theme_classic()

![](https://imgkr2.cn-bj.ufileos.com/875f9127-458a-42b1-891e-f0785391ec9a.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=z3ioiQ2RqTsicIp6SsyfbF7KapY%253D&Expires=1614591721)

### theme_gray()

![](https://static01.imgkr.com/temp/6f0dc53f3d7c461f8fd2b2de356d6b60.png)

## ggthemes包

> **注**： 使用该包内部的函数，记得提前安装和加载该包

>该包的github网站为：https://github.com/jrnold/ggthemes。jornld给出了很多主题风格的例子可见：https://github.com/BTJ01/ggthemes/tree/master/inst/examples

这个包算是ggplot拓展包最热门的包之一了，这里罗列一些常用的主题风格函数。想继续研究的伙伴可以看上面的两个网站。

### theme_excel()


![](https://imgkr2.cn-bj.ufileos.com/5941f66a-2826-4907-bce2-0010cf8f9860.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=XFmfeDCgWixVtXlPqWGMrzkdnAE%253D&Expires=1614591989)


### theme_economist()


![](https://imgkr2.cn-bj.ufileos.com/6be40e75-3fe1-45b7-8e93-3c04ca7f3be5.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=Ry4tY9ZvkGm3PHzqlIGYRPAEEDk%253D&Expires=1614592030)


### theme_fivethirtyeight()

![](https://static01.imgkr.com/temp/3b6e7b6132594662a98c1a84512efc54.png)




### theme_tufte()

![](https://static01.imgkr.com/temp/67078048f3564990a5272b8302ede352.png)

### theme_geocs()
![](https://static01.imgkr.com/temp/5092ca26a5794278adc171720929baee.png)

### theme_wsj()
![](https://imgkr2.cn-bj.ufileos.com/cdc7ed4a-7e76-4558-8e79-b87c245a1362.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=gRzvU1c1NwNWIzRWLp%252FamMUsgys%253D&Expires=1614592045)

### theme_calc()
![](https://imgkr2.cn-bj.ufileos.com/032dbaa9-594d-4e51-8dbb-2be49b3ed8d8.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=Uq7K0LZE1I3DDXxPtVo%252BDSsgp1o%253D&Expires=1614592045)

### theme_hc()

![](https://imgkr2.cn-bj.ufileos.com/6eb78ba2-414a-431f-8be1-7550ad33a7be.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=pf8zkArhfXq0RdKZ00C4PIhSAPM%253D&Expires=1614592067)

## 其他包

### egg包中的theme_article()

![](https://static01.imgkr.com/temp/f6256958de4c4e97806944ec73815898.png)

### ggpubr包中的theme_pubr() 


![](https://static01.imgkr.com/temp/7076cb88f033425cb96d406ae0bc97f6.png)









