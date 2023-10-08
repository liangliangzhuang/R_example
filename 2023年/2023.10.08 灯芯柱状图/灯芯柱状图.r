# 代码来源于https://github.com/z3tt/TidyTuesday/blob/main/R/2021_27_AnimalRescues.Rmd
# 与源代码有所改动，数据读取代码进行了改动。
library(tidyverse)
library(ggtext)
library(ggrepel)
library(patchwork)
library(systemfonts)


# 主题设置 ====== 
theme_set(theme_minimal(base_size = 19))

theme_update(
  text = element_text(color = "grey12"),
  axis.title = element_blank(),
  axis.text.x = element_text(),
  axis.text.y = element_blank(),
  panel.grid.major.y = element_blank(),
  panel.grid.minor = element_blank(),
  plot.margin = margin(20, 5, 10, 10),
  plot.subtitle = element_textbox_simple(size = 14,
                                         lineheight = 1.6),
  plot.title.position = "plot",
  plot.caption = element_text( color = "#b40059", hjust = .5,
                              size = 10, margin = margin(35, 0, 0, 0))
)

# 数据读取+处理 ========
df_animals <- readr::read_csv('animal_rescues.txt')

df_animals_agg <-
  df_animals %>% 
  mutate(
    animal_group_aggregated = case_when(
      str_detect(animal_group_parent, "Domestic|Livestock|Farm|Horse|Cow|Sheep|Goat|Lamb|Bull") ~ "Other Domestic Animals",
      animal_group_parent %in% c("Cat", "cat") ~ "Cats",
      animal_group_parent %in% c("Bird", "Budgie") ~ "Birds",
      animal_group_parent == "Dog" ~ "Dogs",
      animal_group_parent == "Fox" ~ "Foxes",
      TRUE ~ "Other Wild Animals"
    )
  ) %>% 
  count(cal_year, animal_group_aggregated) %>% 
  group_by(animal_group_aggregated) %>% 
  mutate(
    total = sum(n),
    current = n[which(cal_year == 2021)]
  ) %>% 
  ungroup() %>% 
  mutate(
    animal_group_aggregated = fct_reorder(animal_group_aggregated, total),
    animal_group_aggregated = fct_relevel(animal_group_aggregated, "Other Domestic Animals", after = 0),
    animal_group_aggregated = fct_relevel(animal_group_aggregated, "Other Wild Animals", after = 0)
  )

df_animals_labs <-
  df_animals_agg %>% 
  filter(cal_year == 2016) %>% 
  group_by(animal_group_aggregated) %>% 
  mutate(n = case_when(
    animal_group_aggregated == "Cats" ~ 320,
    animal_group_aggregated %in% c("Birds", "Dogs") ~ 135,
    TRUE ~ 55
  ))

df_animals_annotate <-
  df_animals_agg %>% 
  mutate(label = "\n\n← Number of Rescues in 2021 so far.") %>% 
  filter(cal_year == 2021 & animal_group_aggregated == "Cats")

df_animals_sum <-
  df_animals_agg %>% 
  filter(cal_year < 2021) %>% 
  group_by(cal_year) %>% 
  summarize(n = sum(n))

# write_csv(df_animals_sum,"df_animals_sum.csv")
# df_animals_sum = read.csv("df_animals_sum.csv")
## 绘图 ==============

  df_animals_sum %>% 
  ggplot(aes(cal_year, n)) +
  geom_col(aes(fill = factor(cal_year)), width = .85) +
  geom_col(
    data = df_animals_agg %>% filter(animal_group_aggregated == "Cats" & cal_year < 2021),
    aes(alpha = cal_year == 2020), # 这里有细节！
    fill = "white", width = .5 # 宽度和透明度设置
  ) +
  geom_text( #这里的数据处理：添加文本+加入rescues
    data = df_animals_sum %>% 
      mutate(n_lab = if_else(cal_year %in% c(2009, 2020), paste0(n, "\nRescues"), as.character(n))),
    aes(label = n_lab), size = 4.3, lineheight = .8, 
    nudge_y = 12, vjust = 0, color = "grey12", fontface = "bold"
  ) +
  geom_text( #添加文本+加入cats
    data = df_animals_agg %>% filter(animal_group_aggregated == "Cats" & cal_year < 2021) %>% 
      mutate(n_lab = if_else(cal_year %in% c(2009, 2020), paste0(n, "\nCats"), as.character(n))), 
    aes(label = n_lab), 
    color = "white", lineheight = .8, size = 4.3, 
    nudge_y = 12, vjust = 0, fontface = "bold"
  ) +
  geom_text( # 手动添加年份标签
    data = df_animals_agg %>% filter(animal_group_aggregated == "Cats" & cal_year < 2021),
    aes(y = -15, label = cal_year, color = factor(cal_year)), 
    size = 6, hjust = .5, vjust = 1
  ) +
  coord_cartesian(clip = "off") +#这想干嘛？
  scale_y_continuous(limits = c(-15, NA)) +
  scale_color_manual(values = c(rep("grey30", 11), "#b40059"), guide = "none") +
  scale_fill_manual(values = c(rep("grey30", 11), "#b40059"), guide = "none") +
  scale_alpha_manual(values = c(.25, .4), guide = "none") +
  theme(
    # plot.title = element_markdown(size = 28, margin = margin(5, 35, 25, 35), color = "black"),
    # plot.subtitle = element_textbox_simple(margin = margin(5, 35, 15, 35)),
    panel.grid.major = element_blank(),
    axis.text.x = element_blank()
  )



