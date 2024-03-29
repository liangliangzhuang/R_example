# 代码解释见推文：https://mp.weixin.qq.com/s/alyuUumkwqC08RJilXmfeA
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》



# install.packages("readxl")
library(readxl)
library(ggplot2)
library(tidyverse)
library(cowplot)
library(viridis)
library(showtext)
showtext_auto()


### 绘制不同方法的区域图===========
dat = read_excel("test.xlsx",sheet=1,na="NA")
colnames(dat) = c("Id",paste("X",1:6,sep=''))
head(dat)


dat %>% select(c(Id,X1,X4)) %>% rename("随机森林"=X1, "XGBoost"=X4) %>% 
  pivot_longer(
             cols = c("随机森林","XGBoost"),
             names_to = "method",
             names_transform = list(method = as.character),
             values_to = "Acc") -> dat1
head(dat1)
cols <- c("#85BA8F", "#A3C8DC","#349839","#EA5D2D","#EABB77","#F09594")
p1 = ggplot(dat1) + 
  geom_area(aes(Id,Acc),fill = cols[1]) + 
  facet_wrap(vars(method),nrow = 2,strip.position = "top") +
  theme_bw() + 
  ylab("精确率") + 
  xlab("叶类") + #主题设置
  theme(panel.grid = element_blank()) 
p1

#==
dat %>% select(c(Id,X2,X5)) %>% rename("随机森林"=X2, "XGBoost"=X5) %>% 
  pivot_longer(
    cols = c("随机森林","XGBoost"),
    names_to = "method",
    names_transform = list(method = as.character),
    values_to = "Acc") -> dat2


p2 = ggplot(dat2) + geom_area(aes(Id,Acc),fill = cols[2]) + facet_wrap(vars(method),nrow = 2,strip.position = "top") +
  theme_bw() + ylab("召回率") + xlab("叶类") + #主题设置
  theme(panel.grid = element_blank())
p2

#==
dat %>% select(c(Id,X3,X6)) %>% rename("随机森林"=X3, "XGBoost"=X6) %>% 
  pivot_longer(
    cols = c("随机森林","XGBoost"),
    names_to = "method",
    # names_transform = list(method = as.factor),
    values_to = "Acc") -> dat3

p3 = ggplot(dat3) + 
  geom_area(aes(Id,Acc),fill = cols[4]) + 
  facet_wrap(vars(method),nrow = 2,strip.position = "top") +
  theme_bw() + 
  ylab("F1得分") + 
  xlab("叶类") + #主题设置
  theme(panel.grid = element_blank())
p3

plot_grid(p1,p2,p3,ncol = 3)


#==========================

dat_all = read_excel("test.xlsx",sheet=2,na="NA")
head(dat_all)

dat_all %>%
  pivot_longer(
    cols = `准确率`:`F1得分`,
    names_to = "method",
    names_transform = list(method = as.character),
    values_to = "value") -> dat_all_new

dat_all_new$method = fct_relevel(dat_all_new$method, "准确率", "精确率", "召回率","F1得分")
dat_all_new %>% ggplot(aes(method ,
                           value,fill=模型)) +
  geom_col(position = "dodge")+
  facet_wrap(vars(文本向量化方法)) +
  theme_bw() + ylab("数值") + xlab("评价指标") + #主题设置
  # scale_fill_viridis(discrete = T) +
  # geom_hline(aes(yintercept = 0.75),color = "gray") +
  scale_fill_manual(values =cols[c(1,2,4)]) +
  theme(panel.grid = element_blank())


# =========

dat_3_new$模型 = fct_relevel(dat_3_new$模型, 
     "官方结果","朴素贝叶斯","支持向量机","决策树","随机森林","XGBoost")


dat3 = read_excel("test.xlsx",sheet=3,na="NA")
head(dat3)
dat3 %>%
  pivot_longer(
    cols = `官方结果`:`XGBoost`,
    names_to = "模型",
    names_transform = list(模型 = as.character),
    values_to = "value") -> dat_3_new
dat_3_new$模型 = factor(dat_3_new$模型,levels = c("官方结果","朴素贝叶斯"))
dummy2 <- data.frame(叶类名称 = dat3$叶类名称, Z = dat3$官方结果)
dat_3_new %>% ggplot(aes(`模型`,value,fill = `模型`)) + 
  geom_col() +
  facet_wrap(vars(`叶类名称`)) +
  geom_hline(data = dummy2,aes(yintercept = Z)) +
  scale_fill_manual(values = cols[1:6]) +
  theme_bw() + ylab("准确度") + xlab("") + #主题设置
  # scale_fill_viridis(discrete = T) +
  theme(panel.grid = element_blank(),
        legend.position = 'bottom',
        legend.direction = "horizontal",
       axis.text.x = element_blank(),
       axis.ticks.x = element_blank())
  


