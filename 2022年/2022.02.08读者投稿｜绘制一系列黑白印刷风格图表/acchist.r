# 本篇推文由西南财经大学经济学院杜云晗投稿，由闪闪排版整理。以下是正文内容：
# 代码解释见推文：https://mp.weixin.qq.com/s/f47_ujT2diu5CO0yUxKTbw
# 公众号：《庄闪闪的R语言手册》

# 2.1 安装说明
rm(list = ls())
if (is.element("chip", installed.packages()[, 1]) == FALSE) {
  if (is.element("devtools", installed.packages()[, 1]) == FALSE) {
    install.packages("devtools")
    library(devtools)
  } else if (is.element("devtools", installed.packages()[, 1]) == TRUE) {
    library(devtools)
  }
  install_github("youngyaoguai/Rdraw/chip0.1/chip")
  library(chip)
} else if (is.element("chip", installed.packages()[, 1]) == TRUE) {
  library(chip)
}

## 2.2 堆积柱状图黑白印刷风格绘制
help(acchist)  #查看函数说明
data("acchist_test_data",package = "chip")  #加载包内置数据集
View(acchist_test_data)  #查看内置数据集结构
axis.x.title <- c("region")   #x轴标题
axis.y.title <- c("ratio")    #y轴标题
individual.name <- c("B","C","D","E","F")  #区域名称
fill.name <- c("academic","vocational","college","high","further","primary")  #要填充的名称
bar_width <- 0.3   #柱子宽度
axis.title.size <- 30  #坐标轴标题大小
axis.text.x.size <- 30  #x轴的文本显示大小
axis.text.y.size <- 30  #y轴的文本显示大小
legend.text.size <- 30  #图例的文本显示大小
legend.title.size <- 30  #图例标题大小
#调用绘图函数
acchist(acchist_test_data,acchist_test_data$region,acchist_test_data$edu,acchist_test_data$ratio)


# 2.3 棒棒图黑白印刷风格绘制
help(bonbon)  #查看函数说明
data("bonbon_test_data",package = "chip")  #load integration sample data  #载入内置数据集
View(bonbon_test_data) #查看数据结构
#要着重显示的个体（如果没有要着重显示的个体，请设置为outstanding <- c(“ ”)）
outstanding <- c("wholesaleretail","Leasing and business services","realestate") 
outstanding.label <- c("24.75%","28.51%","5.16%") #要着重显示的个体的数据标签，需要和outstanding一并调整
outstanding.label.size <- 7  #要着重显示的个体的数据标签大小
outstanding.size <- 4    #要着重显示的个体的棒状物大小
not.outstanding.size <- 2.3  #不需要着重显示的个体的棒状物大小
outstanding.head.size <- 7  #要着重显示的个体的棒状物圆头大小
not.outstanding.head.size <- 5   #不需要重显示的个体的棒状物圆头大小
axis.title.x.size <- 30     #x轴标题大小
axis.text.y.size <- 30     #y轴的文本大小
value.max <- 100   #样本最大值
value.break <- c(0,value.max%/%3,78,100)   #要在x轴上显示的样本数值点
xlab.name <- c("ratio of service industry(%)")  #x轴标题
#所有个体名称排序，会按照从左往右的顺序绘制，绘制结果为从下到上
individual.name <- c("Leasing and business services","wholesaleretail","scientificresearch","Accommodation and Catering","Informationtransmission","culture","socialwork","publicfacilities","residentsservice","financial","education","transportation","publicmanagement","realestate")
bonbon(bonbon_test_data,bonbon_test_data$industry,bonbon_test_data$index)

# 2.4 箱线图黑白印刷风格绘制
help(boxeasy)  #查看绘图函数说明
data("box_test_data",package = "chip")  #载入内置数据集
View((box_test_data)) #查看数据结构
ylab.name <- c("index")       #y轴标题
xlab.name <- c("year")  #x轴标题
axis.title.x.size <- 15  #x轴标题大小
axis.title.y.size <- 15  #y轴标题大小
axis.text.x.size <- 15  #x轴文本大小
axis.text.y.size <- 15  #y轴文本大小
#调用函数
boxeasy(box_test_data,box_test_data$year,box_test_data$index)


# 2.5 简单折线图黑白印刷风格绘制
help(easyline)  #查看函数说明
data("easyline_test_data",package = "chip")  #载入内置数据集
View(easyline_test_data) #查看数据结构
ylab.name <- "population" #y轴标题
xlab.name <- "age" #x轴标题
axis.title.x.size <- 25 #x轴标题大小
axis.title.y.size <- 25#y轴标题大小
axis.line.x.thickness <- 0.5 #x轴粗细
axis.line.y.thickness <- 0.5 #y轴粗细
axis.text.x.size <- 20  #x轴文本大小
axis.text.y.size <- 20 #y轴文本大小
x.start <- 0  #x轴开始数值
x.end <- 100 #x轴结束数值
x.interval <- 10 #x轴数值间隔
y.start <- 0 #y轴开始数值
y.end <- 21571 #y轴结束数值
y.interval <- 5000 #y轴数值间隔
#调用函数
easyline(easyline_test_data,easyline_test_data$population,easyline_test_data$age)

# 2.6 核密度图黑白印刷风格绘制

help(densline)  #查看说明
data("densline_test_data",package = "chip")  #载入内置数据集
View(densline_test_data)  #查看数据结构
yscope <- c()  #第一次使用无法知道具体的范围，填空
xscope <- c() #第一次使用无法知道具体的范围，填空
#根据数据集从左往右填写
legend.name <- c("line1","line2","line3","line4","line5")
#调用函数
densline(test_data)
#根据图示大概知道数值范围，进行微调
yscope <- c(0.0004,0.00155) 
xscope <- c(0,1000)  
legend.name <- c("line1","line2","line3","line4","line5")
densline(densline_test_data)


# 2.7 柱状图黑白印刷风格绘制
help(histeasy)  # 查看帮助
data("hist_test_data ",package = "chip")  #载入内置数据集
View(hist_test_data)   #查看数据结构
x.size <- 2  #x轴文本大小
y.size <- 2  #y轴文本大小
lab.size <- 2  #坐标轴标题大小
legend.x <- 30   #图例水平位置
legend.y <- 0.3   #图例垂直位置
legend.x.distance <- 0.1  #图例中图片和文本的距离
axisname.x <- c("region")  #x轴标题
axisname.y <- c("ratio")  #y轴标题
type.name = c("0-14","15-64","65+","immortality")  #不同类别
individual.name=c("A","B","C","D","E")   #不同个体
histeasy(hist_test_data,hist_test_data$region,hist_test_data$age,hist_test_data$ratio)


# 2.8 加点折线图黑白印刷风格绘制
help(linepoint)
data("line_test_data",package = "chip")  
View(line_test_data)  #查看内置数据集数据结构
start <- 2009  #x轴开始数值
end <- 2019  #x轴结束数值
interval <- 2  #x轴数值间隔
axis.text.x.size <- 30  #x轴文本大小
axis.text.y.size <- 30  #y轴文本大小
legend.title.size <- 30  #图例标题大小
legend.text.size <- 30   #图例文本大小
axis.title.x.size <- 30  #x轴标题大小
axis.title.y.size <- 30  #y轴标题大小
axis.line.x.size <- 0.5  #x轴粗细
axis.line.y.size <- 0.5  #y轴粗细
geom.point.size <- 7  #折线点大小
ylab.name <- c("index")  #y轴标题
xlab.name <- c("year")  #x轴标题
individual.name <- c("A","B","C","D","E")  #个体名称
legend.name <- c("region")  #图例标题
linepoint(line_test_data,line_test_data$region,line_test_data$index,line_test_data$year)

# 2.9 金字塔图黑白印刷风格绘制

help(pyramid)
View(pyramid_test_data)  #查看内置数据集数据结构
data("pyramid_test_data",package = "chip")  #load integration sample data
v_max <- 4400  #样本中的最大数值
middle.size <- 6.6  #中间文本大小
left.axis.title.x.size <- 30  #左边x轴标题大小
left.axis.text.x.size <- 30  #左边x轴文本大小
right.axis.title.x.size <- 30  #右边x轴标题大小
right.axis.text.x.size <- 30  #右边x轴文本大小
right.title <- c("女")  #右边x轴标题
left.title <- c("male")  #左边x轴标题
pyramid(pyramid_test_data,pyramid_test_data$male,pyramid_test_data$female,pyramid_test_data$group,pyramid_test_data$group_name)


