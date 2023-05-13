## 数据处理|数据按从小到大分成n类

最近做项目遇到了一个实际数据清洗的问题，如何将连续数据按从大到小分成n类？刚开始我是打算用tidyverse包的，但是找不到合适的函数。只能通过较为笨拙的方法进行了。
![](https://imgkr2.cn-bj.ufileos.com/dde70a2c-d9fa-4076-8b52-ae17d0aa96b3.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=xb9feNgbDRAYJbQM8t67howdNmo%253D&Expires=1606120382)

之后通过[stackoverflow网站](https://stackoverflow.com/questions/4126326/how-to-quickly-form-groups-quartiles-deciles-etc-by-ordering-columns-in-a?noredirect=1 "How to quickly form groups ")进行查询才发现原来有这么好用的**窗口函数**。

![](https://imgkr2.cn-bj.ufileos.com/c02dd36a-b258-4dc6-9350-3569d9980b3f.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=SAb7a4hlRpv3l43MWN6b%252Bi6ciaY%253D&Expires=1606121218)


## 较为笨拙的方法

使用Rbase包中的数据框操作进行，首先随机产生一个数据框作为模拟数据。
```{r}
temp <- data.frame(name=letters[1:12], value=rnorm(12), q=rep(NA, 12))
head(temp)
#    name       value quartile
# 1     a  2.55118169       NA
# 2     b  0.79755259       NA
# 3     c  0.16918905       NA
# 4     d  1.73359245       NA
# 5     e  0.41027113       NA
# 6     f  0.73012966       NA
```
```{r}
temp.sorted <- temp[order(temp$value), ]
temp.sorted$q <- rep(1:4, each=12/4)
temp <- temp.sorted[order(as.numeric(rownames(temp.sorted))), ]
head(temp)
#    name       value        q
# 1     a  2.55118169        4
# 2     b  0.79755259        3
# 3     c  0.16918905        2
# 4     d  1.73359245        4
# 5     e  0.41027113        2
# 6     f  0.73012966        3
```

## 使用dplyr包中的ntile()


首先构建一个数据框，包含a，b变量。以该数据框进行演示：

```{r}
foo <- data.frame(a = 1:100,
                  b = runif(100, 50, 200),
                  stringsAsFactors = FALSE)
```

载入[tidyverse包](https://www.tidyverse.org/ "tidyverse包")，内部包含了[dplyr包](https://dplyr.tidyverse.org/ "dplyr包")。然后使用管道函数，利用函数`ntile()`构建新的列，列名为q。或者不用通道函数，直接加载`dplyr`包也可以。
```{r}
library(tidyverse)
foo %>%
    mutate(q = ntile(b, 10))

#  a         b        q
#1 1  93.94754        2
#2 2 172.51323        8
#3 3  99.79261        3
#4 4  81.55288        2
#5 5 116.59942        5
#6 6 128.75947        6
```





