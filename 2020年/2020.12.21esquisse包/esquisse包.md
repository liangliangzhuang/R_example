
## 简介

最近学习可视化时发现了一个好用的包，可以直接使用“拖拽”的方式生成绘图，**不需要写任何代码！** 
这个包是esquisse，具体介绍可以见[对应的github](https://github.com/dreamRs/esquisse "esquisse包")。这是建立在[ggplot2包](https://github.com/tidyverse/ggplot2 "ggplot2包")基础上设计的。 你可以通过生成ggplot2图表以交互方式探索esquisse环境中的数据。入门门槛极低，有点类似tableau的感觉。


## 安装
可以通过CRAN直接下载，也可以通过github中下载，然后将其进行加载即可。

```
# From CRAN
install.packages("esquisse")
# remotes::install_github("dreamRs/esquisse")
#Load the package in R
library(esquisse)
```

## 使用方式

使用方式由以下两种，推荐使用窗口操作，因为不用记住代码，也很好找到。

### 1. 输入以下代码
```
esquisse::esquisser() #helps in launching the add-in
```
![代码打开界面](https://imgkr2.cn-bj.ufileos.com/96e53f2f-a5cb-45a5-b674-19b07e840e7a.gif?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=dd6c5rVWW8v17z%252BdHGvcGZLF4xw%253D&Expires=1608642502)

### 2. 窗口操作

通过RStudio菜单启动插件（推荐）

>**注意**：如果您的环境中没有data.frame，则可以使用ggplot2中的数据集。推荐还是自己前面已经导入数据了，界面才会有显示可以使用的数据。

- 加载该包之后，在窗口的左上方有个Addins，点击打开找到对应包的函数点击即可。
    
![打开方式1](https://imgkr2.cn-bj.ufileos.com/46e23df4-76a5-422f-aa6f-56c0b7965fe6.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=Io88OxOXooyRyqfjqKFDl%252Bo%252BdL8%253D&Expires=1608642673)


    
    
## 窗口详细说明

导入自己的数据，就可以对其进行分析了！这里咱们对`iris`数据作为例子。窗口都是互动形式的，你可以根据自己所需进行绘制对应的图形，不需要输入代码。我们给出操作图，如下所示。之后对界面下面的四个小窗口进行详细介绍。

![具体操作](https://imgkr2.cn-bj.ufileos.com/31b82c98-1553-4a8f-9848-80c9f0e182c6.gif?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=h%252FoeHlvI%252F1S6VbTLI6Cm0RNZWkc%253D&Expires=1608646813)



### Lables&Title

![添加各种标签题目](https://imgkr2.cn-bj.ufileos.com/771f7c69-927e-4ca8-b008-a86c33c3a336.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=gr0ZI5D53%252BqEXYxkNkJQFGsvJg0%253D&Expires=1608644653)


### Plot options

可以设计geom_xxx中的各种参数（颜色，尺寸），legend摆放的位置，主题形式等等；

![设计各种参数](https://imgkr2.cn-bj.ufileos.com/d23c37df-10fd-49f9-9aa0-cceb3d26b255.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=u8pdjVoXk0IW3v3qrd%252FEX2Jt%252B44%253D&Expires=1608643705)

### Data


![改变输入数据的范围](https://imgkr2.cn-bj.ufileos.com/56bb4d45-fb81-4f95-be79-fc99c9d6cf5d.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=9mBnHsMSJhSjGVJoEYDIlJ%252B5fkQ%253D&Expires=1608644852)

### Export&code

这可以显示操作后图对应的ggplot的代码！（非常管用！）你可以按( Insert code in script )将自动导入你的代码中。

![代码、图片导出](https://imgkr2.cn-bj.ufileos.com/24149f1d-b729-4508-8061-38f5851a0311.jpg?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=s6mAPWoNrQhhTJvVS0bC%252BZ2r2%252F0%253D&Expires=1608643830)

当然可以导出pptx或者png格式，操作如下所示：

![导出pptx格式，在线修改图片](https://imgkr2.cn-bj.ufileos.com/b83417e0-9749-473d-9fd5-44e220f057a5.gif?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=hu3nMbXOCx2Qg%252FyF77XOGsn2r%252Bs%253D&Expires=1608644529)


> **注意**：导出pptx可能还需要两个包（`rvg , officer`），你可以先安装，在使用界面操作导出pptx格式。 pptx格式可以修改图片内部的任何地方，非常方便。

## 小编有话说

- 这个包对想学习ggplot语法的读者来说，也非常合适。可以直接导出你做图的代码，根据代码反过来学习对应语法，从实践中学习也是不错的选择。

- 小编最近在准备毕业的开题答辩，书籍翻译和论文撰写，所以更新的比较慢。不过可视化系列一直在逐步推进，已经准备几期了初稿了，但是感觉不够系统，所以还打算打磨下再发出来。[上次里的flag](https://mp.weixin.qq.com/s?__biz=MzI1NjUwMjQxMQ==&mid=2247487940&idx=1&sn=02e087fdb8c7ec192ea3297dadda702d&chksm=ea24ee20dd536736997620b3a7b6d008475503a8997476d97941e71cc5d6adab9549a8f3b9a5&token=1926271128&lang=zh_CN#rd)也会继续下去的，尽情期待。也欢迎加小编微信一起沟通交流，也感谢各位博士大大们对小编的建议和厚爱❤。




