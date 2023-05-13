# Panel F ----
library(ggplot2) 
library(vi)
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

data_F = read.csv("./data_F.csv")
head(data_F)
panel_F <- ggplot(data=data_F,
                  aes(x=K,y=n,
                      size=amplitude,
                      fill=duration))+
  geom_point(pch=21) +
  my_theme() + 
  scale_x_continuous(expand = c(0, 0),
                     trans = 'log10',
                     labels=c(1,10,100),
                     breaks=c(1,10,100),
                     limits = c(1,100)) +
  scale_y_continuous(expand = c(0, 0),
                     breaks=c(seq(0,4,by=0.5)),
                     limits = c(0,4)) +   
  xlab(expression(paste("dissociation constant",~~italic("K")," (M)"))) +
  ylab("Hill coefficient n") +
  annotation_logticks(sides='b') +
  scale_size(range = c(1, 3)) +
  scale_fill_viridis(option="D") + # a color palette from the viridis package
  theme(legend.position = c(0.9,0.35)) +
  coord_cartesian(clip = "off")

panel_F
