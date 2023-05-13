
# 代码解释见推文：https://mp.weixin.qq.com/s/JdfKl9vEqkE0rcEfz6lBBg
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》

dat3 = read_excel("test.xlsx",sheet=3,na="NA")
head(dat3)
dat3 %>%
  pivot_longer(
    cols = `官方结果`:`XGBoost`,
    names_to = "模型",
    names_transform = list(模型 = as.character),
    values_to = "value") -> dat_3_new

dat_3_new$ 模型 = fct_relevel(dat_3_new$ 模型, 
                           "官方结果","朴素贝叶斯","支持向量机","决策树","随机森林","XGBoost")

head(dat_3_new)

dummy2 <- data.frame(叶类名称 = dat3$ 叶类名称, Z = dat3$ 官方结果)
dat_3_new %>% ggplot(aes(`模型`,value,fill = `模型`)) + 
  geom_col() +
  facet_wrap(vars(`叶类名称`)) +
  geom_hline(data = dummy2,aes(yintercept = Z)) +
  # scale_fill_manual(values = cols[1:6]) +
  theme_bw() + ylab("准确度") + xlab("") + #主题设置
  scale_fill_viridis(discrete = T,option = "D") +
  theme(panel.grid = element_blank(),
        legend.position = 'bottom',
        legend.direction = "horizontal",
       axis.text.x = element_blank(),
       axis.ticks.x = element_blank())