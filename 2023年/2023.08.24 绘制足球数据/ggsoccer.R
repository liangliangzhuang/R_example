library(ggsoccer)

# 最基础 ====
ggplot() +
  annotate_pitch() +
  theme_pitch() 

# 投射路线
pass_data <- data.frame(x = c(24, 18, 64, 78, 53),
                        y = c(43, 55, 88, 18, 44),
                        x2 = c(34, 44, 81, 85, 64),
                        y2 = c(40, 62, 89, 44, 28))

## 版本一
ggplot(pass_data) +
  annotate_pitch(colour = "white",
                 fill = "#3ab54a") +
  geom_segment(aes(x = x, y = y, xend = x2, yend = y2),
               arrow = arrow(length = unit(0.25, "cm"),
                             type = "closed")) +
  theme_pitch() +
  direction_label() #+
  # ggtitle("Simple passmap", 
  #         "ggsoccer example")


## 版本二（半场）
ggplot(pass_data) +
  annotate_pitch(colour = "white",
                 fill = "#3ab54a") +
  geom_segment(aes(x = x, y = y, xend = x2, yend = y2),
               arrow = arrow(length = unit(0.25, "cm"),
                             type = "closed")) +
  theme_pitch() +
  # direction_label() +
  # ggtitle("Simple passmap", 
  # "ggsoccer example") +
  coord_flip(xlim = c(49, 101)) +
  scale_y_reverse() 


# 投射情况 =======
df <- data.frame(x = rnorm(20, 80, 10), 
                 y = rnorm(20, 50, 20),
                 Shot = sample(c("In", "Out"),
                               40, replace = TRUE))

library(viridis)
ggplot(df) +
  annotate_pitch(colour = "white",
                 fill = "#3ab54a") +
  geom_point(aes(x = x, y = y, fill = Shot),
             shape = 21,
             size = 4) +
  coord_cartesian(xlim = c(45, 105))+ 
  scale_fill_viridis(discrete=T) +
  theme_pitch() +
  theme(panel.background = element_rect(fill = "#3ab54a")) 


# ggplot 版本复现=======

ggplot()+
  geom_rect(aes(xmin = -10, xmax = 100, ymin= -10, ymax = 130), fill = "#3ab54a", colour = "#FFFFFF", size = 0.5)+ ### Background outline
  geom_rect(aes(xmin = 0, xmax = 90, ymin= 0, ymax = 120), fill = "#3ab54a", colour = "#FFFFFF", size = 0.5)+ ###Sideline, Endline
  geom_rect(aes(xmin = 0, xmax = 90, ymin= 0, ymax = 60), fill = NA , colour = "#FFFFFF", size = 0.5)+ #Halfway
  geom_rect(aes(xmin = 24.85, xmax = 65.15, ymin= 0, ymax = 16.5), fill = "#3ab54a", colour = "#FFFFFF", size = 0.5)+ #lower 18 yard box
  geom_rect(aes(xmin = 35.85, xmax = 54.15, ymin= 0, ymax = 5.5), fill = "#3ab54a", colour = "#FFFFFF", size = 0.5)+ # Lower 5 yard box
  geom_rect(aes(xmin = 24.85, xmax = 65.15, ymin= 103.5, ymax = 120), fill = "#3ab54a", colour = "#FFFFFF", size = 0.5)+ #upper 18 yard box
  geom_rect(aes(xmin = 35.85, xmax = 54.15, ymin= 114.5, ymax = 120), fill = "#3ab54a", colour = "#FFFFFF", size = 0.5)+ #upper 5 yard box
  geom_curve(aes(x = 35.85, y = 16.5, xend = 54.15, yend = 16.5), curvature = -0.6, colour = "#FFFFFF")+ #lower D
  geom_curve(aes(x = 35.85, y = 103.5, xend = 54.15, yend = 103.5), curvature = .6, colour = "#FFFFFF")+ #upper D
  ggforce::geom_circle(aes(x0=45, y0=60, r= 9.15), colour = "#FFFFFF")+ ##Halfway circle 
  # coord_flip(xlim = c(49, 101)) +
  coord_flip() +
  scale_y_reverse() +
  theme(rect = element_blank(),
        line = element_blank(),
        text = element_blank())
