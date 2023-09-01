# ======== 使用分面展示不同组别的双 Y 轴图形 =======
# 出自：庄闪闪
# 参考资料：https://community.rstudio.com/t/add-secondary-axis-on-ggplot/138671/7
library(tidyverse)

# 加载数据=====
df = read_csv("df.csv")
head(df)
# 双轴绘制 ======
p1 = df %>% 
  filter(type == "Adult") %>%
  group_by(station) %>% 
  mutate(Percent = 100 * number/sum(number),
         station=factor(station)) %>%
  ggplot(aes(station, fill = species)) + 
  geom_bar(aes(y = Percent), position = "stack", stat = "identity") +
  geom_line(aes(y = depth /4, group = 1)) +
  scale_y_continuous(sec.axis = sec_axis(~ . * 4, name = "Depth")) 
p1 
# 双轴 + 分面
library(viridis)
p1 + theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        panel.grid = element_blank()) +
  # scale_fill_viridis(discrete = T) +
  #scale_fill_manual(name = "Species", values=PZ) + 
  facet_grid(~factor(zone,levels = c("A1","A2","A3")), scale = "free_x", space = "free_x") 



