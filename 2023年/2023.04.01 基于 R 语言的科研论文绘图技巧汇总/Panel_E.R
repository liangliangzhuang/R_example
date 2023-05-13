# Panel E ----
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

data_Ea = read.csv("./data_Ea.csv")
data_Eb = read.csv("./data_Eb.csv")
data_Ec = read.csv("./data_Ec.csv")
data_E = data.frame("gene"=c(rep("gene a",nrow(data_Ea)),
                             rep("gene b",nrow(data_Eb)),
                             rep("gene c",nrow(data_Ec))),
                    "t"=c(data_Ea$t,data_Eb$t,data_Ec$t),
                    "C"=c(data_Ea$C,data_Eb$C,data_Ec$C),
                    "pos_err"=c(data_Ea$err,data_Eb$pos_err,data_Ec$pos_err_C),
                    "neg_err"=c(data_Ea$err,data_Eb$neg_err,data_Ec$neg_err_C),
                    "pos_err_t"=c(rep(NA, nrow(data_Ea)),rep(NA, nrow(data_Eb)),data_Ec$pos_err_t),
                    "neg_err_t"=c(rep(NA, nrow(data_Ea)),rep(NA, nrow(data_Eb)),data_Ec$neg_err_t)
)

head(data_E)

f1 = function(t) 0.2*exp(-t/48)
f2 = function(t) 0.3*exp(-t/60)
f3 = function(t) 0.4*exp(-t/72)
t = seq(0,96,1)

ribbon = data.frame(
  "f2" = 0.3*exp(-t/60),
  "t" = t
)
head(ribbon)

manual_pch =c(15,16,17) # available pch: type ?pch 

panel_E <- ggplot(data=data_E) +
  geom_point(aes(x=t,y=C,pch=factor(gene)),size=2) +
  geom_ribbon(data=ribbon, aes(x=t,ymin=0.85*f2,ymax=1.15*f2),
              fill="black",alpha=0.1) +
  stat_function(fun=f1, geom="line",linetype="dashed") +
  stat_function(fun=f2, geom="line") +
  stat_function(fun=f3, geom="line",linetype="dotted") +
  geom_errorbar(aes(x=t,ymin=C-neg_err, ymax=C+pos_err), 
                width=2) +
  geom_errorbarh(aes(y=C,xmin=t-neg_err_t,xmax=t+pos_err_t))+
  scale_shape_manual(values=manual_pch) +
  my_theme() + theme(legend.title=element_blank())+
  theme(legend.position = c(0.9,0.95)) +
  scale_x_continuous(expand = c(0, 0), 
                     breaks = c(seq(0,96,12)),
                     limits = c(0,96)
  ) +
  scale_y_continuous(expand = c(0, 0),
                     breaks = c(seq(0,0.4,0.05)),
                     limits = c(0,0.4)
  ) +
  theme(
    panel.grid.major = element_line("gray95", size = 0.1),
    # putting label closer to axis bc exponent makes it bigger 
    axis.title.y = element_text(margin = margin(r = -9)) 
  ) +
  xlab("time (h)") +
  ylab(expression(paste("concentration (mmol",~cm^-3,")"))) +  
  coord_cartesian(clip = "off") # to allow for plotting outside axes

panel_E
