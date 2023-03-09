# 基于ggdensity包的等高线绘制

library(ggdensity)
library(ggblanket)
library(ggsci)

head(iris)
## ggplot 直接版本
ggplot(iris,aes(x = Sepal.Width, y = Sepal.Length, fill = Species)) +
  ggdensity::geom_hdr() + 
  scale_fill_aaas() +
  facet_wrap(vars(Species)) 

## 添加其他geom
ggplot(iris,aes(x = Sepal.Width, y = Sepal.Length, fill = Species)) +
  ggdensity::geom_hdr() + 
  geom_point(shape = 21) +
  scale_fill_aaas() +
  facet_wrap(vars(Species)) 

ggplot(iris,aes(x = Sepal.Width, y = Sepal.Length, color = Species)) +
  ggdensity::geom_hdr_lines() +
  geom_point() +
  scale_color_aaas() +
  facet_wrap(vars(Species)) 

ggplot(iris,aes(x = Sepal.Width, y = Sepal.Length, fill = Species)) +
  ggdensity::geom_hdr() + 
  geom_point(shape = 21) +
  scale_fill_aaas() +
  facet_wrap(vars(Species)) +
  geom_hdr_rug()

## ggblanket 版本
iris |>
  gg_blank(
    x = Sepal.Width,
    y = Sepal.Length,
    col = Species,
    facet = Species,
    col_legend_place = "r") +
  ggdensity::geom_hdr(colour = NA) +
  labs(alpha = "Probs") +
  theme(legend.title = element_text(margin = margin(t = 5)))

# mutate(Species = stringr::str_to_sentence(Species)) |> 

### 细节处理
## 修改x轴标签大小写问题：
# 使用stringr::str_to_sentene()修改Species列中的文本。并在col_labels中设置为：stringr::str_to_sentence

iris |>
  mutate(Species = stringr::str_to_sentence(Species)) |> 
  gg_blank(
    x = Sepal.Width,
    y = Sepal.Length,
    col = Species,
    facet = Species,
    col_legend_place = "r",
    col_labels = stringr::str_to_sentence) +
  ggdensity::geom_hdr(colour = NA) +
  labs(alpha = "Probs") +
  theme(legend.title = element_text(margin = margin(t = 5)))

