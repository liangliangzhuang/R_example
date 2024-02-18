# ggplot 绘制分面条形图并标记数字 ====
# 来自公众号《庄闪闪的R语言手册》——庄闪闪
# 数据导入
library(tidyverse)
library(viridis)
data = read.csv("demo_dat.csv")
head(data) 

# 数据处理
toselect <- c("ananas","rongdianer","rainie.tian", "vivakatt","nya", "liangliang","nannan", "joly","lizlu")
data2 <- as_tibble(data)  %>% filter(NAME %in% toselect) %>%
  arrange(match(NAME, toselect)) %>% 
  pivot_longer(-NAME, names_to = "centrality" , values_to = "value") %>% 
  group_by(centrality) %>% 
  arrange(desc(value)) %>% 
  mutate(order = row_number()) %>% 
  ungroup %>% mutate(NAME = factor(NAME, levels = toselect)) %>% 
  mutate(centrality = factor(centrality, levels = c("A" , "B", "C" , "D")))

# 绘图
data2 %>%
  ggplot(aes(factor(NAME,levels = toselect), value, fill = NAME)) + 
  geom_bar(stat = "identity") + 
  facet_wrap(vars(centrality), scales = "free" ,nrow = 1) + 
  coord_flip() + 
  geom_label(aes(label = order), colour = "white", size = 3) + 
  scale_x_discrete(limits = rev(levels(data2$NAME))) + 
  scale_fill_viridis(discrete = TRUE) +
  theme_bw() +
  theme(plot.title = element_blank(),
        panel.grid = element_blank(),
        axis.title.x = element_blank(), 
        axis.title.y = element_blank(), 
        panel.spacing.x = unit(4, "mm"), 
        legend.position = "none")
