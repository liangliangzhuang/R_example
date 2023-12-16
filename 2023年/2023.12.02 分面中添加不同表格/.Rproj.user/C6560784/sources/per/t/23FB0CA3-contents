# https://stackoverflow.com/questions/25554548/adding-sub-tables-on-each-panel-of-a-facet-ggplot-in-r/58464596#58464596?newreg=9fc3d38711e945d1b5d37847f0f5d0af
# library(ggpmisc)
library(ggpp)
library(dplyr)
library(tibble)

myData <- filter(mpg, manufacturer == "audi" | manufacturer == "chevrolet")
head(myData)

gg <- ggplot(myData, aes(x=hwy, y=cty, colour=model)) + 
  facet_wrap(~ manufacturer) + 
  geom_point(size = 3) +
  geom_smooth(stat="identity")

tb <- myData %>%
  group_by(manufacturer, model) %>%
  summarize(var1 = round(mean(displ)), var2 = round(mean(cyl))) %>%
  ungroup() 

tbs <- lapply(split(tb, tb$manufacturer), "[", -1)
df <- tibble(x = rep(-Inf, length(tbs)), 
             y = rep(Inf, length(tbs)), 
             manufacturer = levels(as.factor(tb$manufacturer)), 
             tbl = tbs)

gg + geom_table(data = df, aes(x = x, y = y, label = tbl),
                hjust = -0.2, vjust = 1.2) 

library(viridis)
gg + geom_table(data = df, aes(x = x, y = y, label = tbl),
                hjust = -0.2, vjust = 1.2,
                table.theme = ttheme_gtstripes) + 
  scale_color_viridis(discrete = TRUE) + theme_bw() +
  theme(panel.grid = element_blank(),
        legend.position = "bottom",
        legend.direction = "horizontal") +
  guides(color=guide_legend(nrow=1))
  


