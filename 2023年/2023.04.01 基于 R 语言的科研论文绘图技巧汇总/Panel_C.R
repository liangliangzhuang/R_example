# Panel C ----
library(ggplot2) 
base_size = 12 
my_theme <-  function() {
  theme(
    aspect.ratio = 1,
    axis.line =element_line(colour = "black"),  
    
    # shift axis text closer to axis bc ticks are facing inwards
    axis.text.x = element_text(size = base_size*0.8, color = "black", 
                               lineheight = 0.9,
                               margin=unit(c(0.3,0.3,0.3,0.3), "cm")), 
    axis.text.y = element_text(size = base_size*0.8, color = "black", 
                               lineheight = 0.9,
                               margin=unit(c(0.3,0.3,0.3,0.3), "cm")),  
    
    axis.ticks = element_line(color = "black", size  =  0.2),  
    axis.title.x = element_text(size = base_size, 
                                color = "black", 
                                margin = margin(t = -5)), 
    # t (top), r (right), b (bottom), l (left)
    axis.title.y = element_text(size = base_size, 
                                color = "black", angle = 90,
                                margin = margin(r = -5)),  
    axis.ticks.length = unit(-0.3, "lines"),  
    legend.background = element_rect(color = NA, 
                                     fill = NA), 
    legend.key = element_rect(color = "black",  
                              fill = "white"),  
    legend.key.size = unit(0.5, "lines"),  
    legend.key.height =NULL,  
    legend.key.width = NULL,      
    legend.text = element_text(size = 0.6*base_size, 
                               color = "black"),  
    legend.title = element_text(size = 0.6*base_size, 
                                face = "bold", 
                                hjust = 0, 
                                color = "black"),  
    legend.text.align = NULL,  
    legend.title.align = NULL,  
    legend.direction = "vertical",  
    legend.box = NULL, 
    panel.background = element_rect(fill = "white", 
                                    color  =  NA),  
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(size = base_size, 
                              color = "black"), 
  ) 
  
  
}

data_Cwt_E8.5  = read.csv( "./data_Cwt_E8.5.csv")
data_Cwt_E9.5  = read.csv( "./data_Cwt_E9.5.csv")
data_Cwt_E10.5 = read.csv("./data_Cwt_E10.5.csv")
data_Cwt_E11.5 = read.csv("./data_Cwt_E11.5.csv")
data_Cmu_E8.5  = read.csv( "./data_Cmu_E8.5.csv")
data_Cmu_E9.5  = read.csv( "./data_Cmu_E9.5.csv")
data_Cmu_E10.5 = read.csv("./data_Cmu_E10.5.csv")
data_Cmu_E11.5 = read.csv("./data_Cmu_E11.5.csv")

head(data_Cwt_E8.5)
# format data to ggplot's liking
data_C = data.frame(
  "type" = c(
    rep(
      "wildtype",
      nrow(data_Cwt_E8.5) +
        nrow(data_Cwt_E9.5) +
        nrow(data_Cwt_E10.5) +
        nrow(data_Cwt_E11.5)
    ),
    rep(
      "mutant",
      nrow(data_Cmu_E8.5) +
        nrow(data_Cmu_E9.5) +
        nrow(data_Cmu_E10.5) +
        nrow(data_Cmu_E11.5)
    )
  ),
  "dev_stage" = c(
    rep("E8.5", nrow(data_Cwt_E8.5)),
    rep("E9.5", nrow(data_Cwt_E9.5)),
    rep("E10.5", nrow(data_Cwt_E10.5)),
    rep("E11.5", nrow(data_Cwt_E11.5)),
    rep("E8.5", nrow(data_Cmu_E8.5)),
    rep("E9.5", nrow(data_Cmu_E9.5)),
    rep("E10.5", nrow(data_Cmu_E10.5)),
    rep("E11.5", nrow(data_Cmu_E11.5))
  ),
  "trachea_length" = c(
    data_Cwt_E8.5[, 1] ,
    data_Cwt_E9.5[, 1] ,
    data_Cwt_E10.5[, 1] ,
    data_Cwt_E11.5[, 1] ,
    data_Cmu_E8.5[, 1] ,
    data_Cmu_E9.5[, 1] ,
    data_Cmu_E10.5[, 1] ,
    data_Cmu_E11.5[, 1]
  )
)

head(data_C)

panel_C <- 
  ggplot(data=data_C,
         aes(x=dev_stage,
             y=trachea_length,
             fill=type))+
  geom_boxplot() + 
  geom_point(position=position_jitterdodge(), # jitter for h-dist, dodge for grouped dists
             pch=21, #圆形
             alpha=0.4) +  # transparency
  scale_x_discrete(limits=c("E8.5","E9.5","E10.5","E11.5")) +
  scale_fill_manual(values=c('#f2a340','#998fc2')) + # custom colors in hex code
  my_theme() +
  theme(legend.position = c(0.18,0.95),
        legend.title = element_blank(),
        legend.key = element_blank()
  ) +
  scale_y_continuous(expand = c(0, 0),
                     breaks=c(seq(20,120,by=20)),
                     limits = c(20,120)
  )+
  xlab("developmental stage (days)") + 
  ylab(expression(paste("tracheal length (",~mu*m,")")))

panel_C
