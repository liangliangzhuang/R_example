## 简介
[ggvis](http://ggvis.rstudio.com "ggvis github")是R的一个数据可视化包，它可以：

- 使用与ggplot2类似的语法描述数据图形；

- 创建丰富的交互式图形，在本地Rstudio或浏览器中使用这些图形；

- 利用shiny的基础结构发布交互式图形。

**ggvis 与 ggplot2主要区别**：

- 基本命名转换：

|ggplot|ggvis|
|-|-|
|geom|layer function|
|stat|compute function|
|aes|props|
|+|%>%|

- ggvis目前不支持分面；

- 使用ggvis而不添加任何层类似于qplot

> 更详细的区别可见：<http://ggvis.rstudio.com/ggplot2.html>

这里先对包进行加载（可以直接使用instll.packages("")下载）
```{r message=FALSE, warning=FALSE}
library(ggvis)
library(dplyr)
```

## 静态图

### 1 散点图

使用`layer_points()`绘制，其中内部参数都用默认值。注意这里`ggvis(~wt, ~mpg) `比ggplot多了一个波浪线。
```{r}
mtcars %>% 
  ggvis(~wt, ~mpg) %>% 
  layer_points()
```
![](https://imgkr2.cn-bj.ufileos.com/e05e6ea6-945d-49eb-bf21-eb530501cb53.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=LXs5vhSIWoeH%252BPk02VPMmv3o4us%253D&Expires=1609416269)



如果要加拟合线，和ggplot语法很类似，再加一层`layer_smooths()`。
```{r}
mtcars %>% 
  ggvis(~wt, ~mpg) %>%
  layer_points() %>%
  layer_smooths()
```

![](https://imgkr2.cn-bj.ufileos.com/a63e61ca-6a9c-4799-9d42-79dfc8eed04b.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=7HcrOMNKMPjazM9ggUWg0x7w8hI%253D&Expires=1609416281)




内部参数也很类似（`se = TRUE`加入拟合区间），拟合方式使用"lm"方法。
```{r}
mtcars %>% 
  ggvis(~wt, ~mpg) %>%
  layer_points() %>%
  layer_model_predictions(model = "lm", se = TRUE)
```
![](https://imgkr2.cn-bj.ufileos.com/2c4cf0e9-942d-40d2-badc-62badaa1cfe3.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=RTssV26FflgDOGONU21qxGqIk%252BM%253D&Expires=1609416292)


### 2 分组的散点图

如果想要使用分组说明散点图，可以加入`fill = ~factor(cyl)`或者`group_by(cyl)`进行分布。
```{r}
mtcars %>% 
  ggvis(~wt, ~mpg) %>% 
  layer_points(fill = ~factor(cyl))
```
![](https://imgkr2.cn-bj.ufileos.com/6c6425a9-1eab-4807-8c42-252c0e230820.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=fs0d49JC85yxV8PF3rfmpE0ghmw%253D&Expires=1609415742)

如果想要预测每组数据拟合情况，可以使用`ayer_model_predictions()`。
```{r}
mtcars %>% 
  ggvis(~wt, ~mpg, fill = ~factor(cyl)) %>% 
  layer_points() %>% 
  group_by(cyl) %>% 
  layer_model_predictions(model = "lm")
```

![](https://imgkr2.cn-bj.ufileos.com/736edb8b-4921-40e7-a29b-81e9f7b738bf.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=pLrTlICigwIqryUu%252F8g4rT7sqI8%253D&Expires=1609415748)

### 3 柱状图

柱状图是使用`layer_bars()`函数，内部参数包括width（设置柱子宽度）等。

```{r}
head(pressure)

pressure %>% 
  ggvis(~temperature, ~pressure) %>%
  layer_bars(fill := "#ff8080")
```
![](https://imgkr2.cn-bj.ufileos.com/9be6d335-8709-416c-8f15-bfd60895602e.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=sOXRDgS2IAgJRChrA%252FQunzIBaNg%253D&Expires=1609415753)
```{r}
pressure %>% 
  ggvis(~temperature, ~pressure) %>%
  layer_bars(width = 15,fill := "#ff8080")
```
![](https://imgkr2.cn-bj.ufileos.com/ea13652f-f47f-420b-9290-b26f6acfc6d9.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=zs%252BCjmsAMfs6y8J6SiXRrQvdNHg%253D&Expires=1609415758)
### 4 曲线图

使用`layer_lines()`绘制曲线图，当然你可以和散点图合并，效果更好。
```{r}
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()
```
![](https://imgkr2.cn-bj.ufileos.com/618bc22c-12d7-4d3a-be90-3369f086c589.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=gC7M9I7zFB5mlE2DtswbIWI1pFM%253D&Expires=1609415765)


```{r}
pressure %>% ggvis(~temperature, ~pressure) %>%
  layer_points(size := 50) %>% 
  layer_lines()
```
![](https://imgkr2.cn-bj.ufileos.com/07d3bb9d-8610-45e7-a1e4-33cb85ec3349.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=wWoV7E%252F8mLO%252F6MP0bynE3nTRglY%253D&Expires=1609415771)



### 5 直方图
使用`layer_histograms()`绘制直方图，内部参数包括width（柱子宽度），boundary（两个箱子之间的边界），center（柱子中央为中心）等。

```{r}
head(faithful)

faithful %>% ggvis(~eruptions, fill := "#ff8080") %>%
  layer_histograms(width=0.25, boundary=0) %>% 
  add_axis("x", title = "month") %>%
  add_axis("y", title = "count")

```

![](https://imgkr2.cn-bj.ufileos.com/9d792a91-74c5-4b68-9488-a5ed9821a5b6.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=LIfmPNVBe0FVYDGuU%252FvyK%252BmUiUA%253D&Expires=1609415818)



```{r}
faithful %>% ggvis(~eruptions, fill := "#90bff9") %>%
  layer_histograms(width=0.25, center=0) %>% 
  add_axis("x", title = "month") %>%
  add_axis("y", title = "count")
```

![](https://imgkr2.cn-bj.ufileos.com/09cb5684-f255-43fc-91ac-c5171157e4a2.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=HkPrRKYfaZWYtRUnisPymCIEsFQ%253D&Expires=1609415823)


> add_axis()可以设置坐标轴的名称等其他参数。

### 6 箱型图

使用`layer_boxplots()`绘制箱型图，具体内部参数再次不做具体陈述。

```{r}
mtcars %>% 
  ggvis(~factor(cyl), ~mpg) %>% 
  layer_boxplots(fill := "#90bff9") 
```

![](https://imgkr2.cn-bj.ufileos.com/35f114a1-6a53-4b5d-a8d8-8086b891d524.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=v9oowcqbxPwcZ3i%252FKA%252BnY0cXj%252FE%253D&Expires=1609415827)


## 小编有话说

本篇推送参考[ggvis cookbook](http://ggvis.rstudio.com/cookbook.html "ggvis cookbook")，小编也只是一个搬运工。这篇主要是对该包中的常见图形进行静态展示，但是其实这个包更强大的功能在于交互式。鉴于本文内容较多，将在下次对这个包的交互使用进行详细解释。


