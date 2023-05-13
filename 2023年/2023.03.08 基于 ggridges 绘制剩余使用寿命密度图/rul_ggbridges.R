
# 代码解释见推文：https://mp.weixin.qq.com/s/ECquLeoHaJ2byWgrRpqftw
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》


## 基于ggridges的剩余使用寿命密度图
library(tidyverse)
library(ggridges)
library(viridis)

mean1 = seq(21,1,length.out =5) # 刻画不同时间对应密度函数的均值
std1 = seq(5,3,length.out =5) # 刻画不同时间对应密度函数的标准差
len = 10000 #分布中离散数据的个数
y <- c(1,6,11,16,21) # 未来时间
z = matrix(NA,len,5) # 存储抽样得到的后验
for(i in 1:length(mean1)){
  z[,i] = rnorm(len,mean1[i],std1[i])
}
# 合并数据
dat = as.data.frame(cbind(y,z))
colnames(dat) = c("Cur_time",paste("z",1:5,sep = ""))
head(dat)

dat %>% pivot_longer(`z1`:`z5`,
                     names_to = "Class",
                     values_to = "Value"
                     ) -> new_dat
head(new_dat)


##============================== 绘图 ==============================
### 初级版本
ggplot(new_dat, aes(x = Value, y = Class, fill = Class)) +
  geom_density_ridges()

### 进阶版本
ggplot(new_dat, aes(x = Value, y = Class, fill = Class)) +
  geom_density_ridges() +
  scale_fill_viridis(discrete = T) +
  scale_y_discrete(labels = paste("Day",mean1 = seq(1,21,length.out =5) ,seq='')) +
  theme_bw() + 
  theme(legend.position = "none",
        panel.grid = element_blank()) 


# 添加均值1
ggplot(new_dat, aes(x = Value, y = Class, fill = Class)) +
  geom_density_ridges() +
  geom_density_ridges(quantile_lines=TRUE,
                      quantile_fun=function(x,...)mean(x))+ 
  scale_fill_viridis(discrete = T) +
  scale_y_discrete(labels = paste("Day",mean1 = seq(1,21,length.out =5) ,seq='')) +
  theme_bw() + 
  theme(legend.position = "none",
        panel.grid = element_blank()) 

# 添加均值2
ggplot(new_dat, aes(x = Value, y = Class, fill = Class)) +
  geom_density_ridges() +
  stat_summary(fun = "mean", geom = "point", shape = 21, size = 2,fill = "red",color = 'red') +
  scale_fill_viridis(discrete = T) +
  scale_y_discrete(labels = paste("Day",mean1 = seq(1,21,length.out =5) ,seq='')) +
  theme_bw() + 
  theme(legend.position = "none",
                     panel.grid = element_blank()) 

# 添加分位数
ggplot(new_dat, aes(x = Value, y = Class, fill = factor(after_stat(quantile)))) +
  stat_density_ridges(
    geom = "density_ridges_gradient", 
    calc_ecdf = TRUE,
    quantiles = c(0.025, 0.975)) +
  scale_fill_manual(
    name = "Probability", values = c("#FF0000A0", "#A0A0A0A0", "#0000FFA0"),
    labels = c("(0, 0.025]", "(0.025, 0.975]", "(0.975, 1]")
  ) +
  theme_bw() + 
  theme(panel.grid = element_blank())















