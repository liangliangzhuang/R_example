## 简介

- 使用R Markdown可以将一组相关的数据可视化发布为仪表板。

- 支持多种组件，包括htmlwidgets; 基本，晶格和网格图形；表格数据 量表和值箱；和文字注释。

- 灵活且易于指定基于行和列的布局。可以智能地调整组件的大小以填充浏览器并适合在移动设备上显示。

- 演示图板布局，用于呈现可视化效果序列和相关评论。

- 使用Shiny动态驱动可视化。

去年师兄用这个包做了一个不错的应用（企业可靠性统计方向的项目）。今天正好需要学习下数据可视化仪表盘的制作。尝试了下，还不错，比Tableau还要优秀。最近出一期入门，有机会可以把自己的例子介绍一下。

下载方式如下：
```
install.packages("flexdashboard")
```

## 官网案例分享

今天分享下官网的一些[小案例](https://rmarkdown.rstudio.com/flexdashboard/examples.html "小案例")。主要是截图呈现，当然你可以把他的[github](https://github.com/rstudio/flexdashboard "github")克隆到本地，有个文件夹专门放例子的代码，尝试修改代码，应用到自己实际项目中。

### 2008年NBA运动员得分情况



![](https://imgkr2.cn-bj.ufileos.com/20176c63-2213-4ead-b45c-fa378b217eef.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=w%252FdtpUnaHBk1BklxKe6%252BPq1ry70%253D&Expires=1605537297)


### 各种散点图

![](https://imgkr2.cn-bj.ufileos.com/bde1939f-1930-49c4-bb44-81d716a09ce1.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=jLDVKbiSgrpJXlKfSDVTeK7sClo%253D&Expires=1605537248)


![](https://imgkr2.cn-bj.ufileos.com/42b53872-fcfe-4603-ba3c-9ee6b775ca96.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=Z7jj50JIv3HzDzImGtaiUVT2szk%253D&Expires=1605537256)

### 其他例子


![](https://imgkr2.cn-bj.ufileos.com/6f819551-f375-4cb5-8d5b-b4a5a03a551a.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=zQoPXU9PUkadIF6hYSYn2KXFb5U%253D&Expires=1605537340)


![](https://imgkr2.cn-bj.ufileos.com/ff9d45a7-a1ab-4d93-9a09-427b4eaf29e6.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=ig0Bp6ORQ8cXVxHXOUpE2ZY7rbw%253D&Expires=1605537186)


![](https://imgkr2.cn-bj.ufileos.com/2e94d2a6-85f7-4bab-8402-929a47d70de0.png?UCloudPublicKey=TOKEN_8d8b72be-579a-4e83-bfd0-5f6ce1546f13&Signature=ICP%252FysUWGCUXKEhwXpUmYtLwZW0%253D&Expires=1605537355)

当然这些都是可以交互的。大家可以去上面的网站访问下。

