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

data_D1 = read.csv("./data_D1.csv")
data_D2 = read.csv("./data_D2.csv")
# format data to ggplot's liking
data_D = data.frame("width"=c(data_D1$width,data_D2$width),
                    "unit"=c(rep("shear_stress",nrow(data_D1)),
                             rep("velocity",nrow(data_D2))),
                    "value"=c(data_D1$shear_stress,data_D2$velocity)
)
head(data_D)
curve_D1 = data.frame(width=data_D1$width,
                      shear_stress=33.28/(pi*18*data_D1$width^2))
curve_D1

panel_D1 <- ggplot(data=data_D1, 
                   aes(x=width,
                       y=shear_stress)) + 
  geom_point(fill="red",
             size=3,
             pch=22) +
  geom_line(data=curve_D1) +
  scale_x_log10(expand=c(0,0), # prevent gap between origin and first tick
                breaks=c(0.5,1,2,5,10,20,50),
                labels=c(0.5,1,2,5,10,20,50), 
                limits=c(0.5,50)) +
  scale_y_log10( expand = c(0, 0),
                 # using trans_format from the scales package, but one can also use expressions
                 labels = trans_format('log10', math_format(10^.x)), 
                 breaks=c(0.001,0.01,0.1,1),
                 limits = c(0.001,1)
  ) +
  annotation_logticks(sides = "l") +
  theme_void()+
  theme(
    line = element_blank(),
    # exclude everything outside axes bc it messes with positioning of grob in panel_D
    text = element_blank(),
    title = element_blank(),
    axis.line.y = element_line(colour = "black")
  ) +
  ylab("shear stress (Pa)")

panel_D1

panel_D <- 
  ggplot(data=data_D2, 
         aes(x=width,
             y=velocity))+ 
  # add plot of first dataset as grob as a trick to introduce two y-axes with different scalings
  geom_point(fill="blue",
             size=3,
             pch=21) +
  annotation_custom(ggplotGrob(panel_D1)) + 
  scale_y_continuous(expand = c(0,0),
                     breaks = seq(0,1,0.1),
                     limits = c(0,1), 
                     # putting the y axis of the second plot to the right
                     position = "right", 
                     # now the secondary axis becomes the left axis
                     # we need the axis text+title for panel_D1
                     # They were excluded in panel_D1 bc they were messing with the positioning
                     sec.axis = sec_axis(~., 
                                         name = "shear stress (Pa)",
                                         # rescale breaks bc sec_axis inherits scale from primary y axis
                                         breaks=rescale(c(-3,-2,-1,0), 
                                                        to = c(0,1)),
                                         labels = c(expression("10"^"-3",
                                                               "10"^"-2",
                                                               "10"^"-1",
                                                               "10"^"0")))
                     
  ) +
  scale_x_log10(expand=c(0,0),
                breaks=c(0.5,1,2,5,10,20,50),
                labels=c(0.5,1,2,5,10,20,50), 
                limits=c(0.5,50)) + 
  annotation_logticks(sides = "b") + 
  my_theme() + 
  geom_line(color="blue") +
  geom_vline(xintercept = 1.1,
             linetype="dashed") +
  geom_hline(yintercept = 0.9,
             linetype="dashed") +
  theme(
    plot.margin = unit(c(0.1,0,0,0.5), "cm"), # to match other panels
    axis.title.y = element_text(margin = margin(r=1)), 
    axis.text.y = element_text(margin = margin(r=6)),
    axis.text.y.right = element_text(margin = margin(l=7)),
    axis.title.y.right = element_text(angle = 90)
  ) +
  xlab(expression(lumen~width~(mu*m))) +
  ylab("relative flow velocity") + 
  annotate(geom = "text",x =6 ,y =0.85 ,label = "tau == 0.5~Pa",parse=T) +
  annotate(geom = "text",x =1.4 ,y =0.4 ,label = "b == 1.1*mu*m",parse=T,angle=90) +
  annotate(geom = "text",x =5.6 ,y =0.6 ,label = "tau == frac(4*mu*Q,pi*a*b^2)",parse=T) 

panel_D 

