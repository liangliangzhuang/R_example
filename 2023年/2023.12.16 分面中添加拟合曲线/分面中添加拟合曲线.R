library(ggplot2)
library(tidyverse)
library(viridis)
time2 = seq(3,20,3) #希望展示的数据点（离散）
load("true_data.RData")
cal_data
load("data_fit.RData")
data_fit

boxplot.path.fit = function(data_fit = data_fit, cal_data = cal_data, leg.pos = "none"){
  
  merged_df2 <- bind_rows(data_fit, .id = "Unit") #合并数据
  merged_df2$Unit = rep(c("Low","Mean","Up"),each = length(0:m))
  mer_dat = merged_df2 %>% pivot_longer(cols = !c(Time,Unit), names_to = "PC", values_to = "Value")
  # 数据筛选，用于画直线
  mer_dat1 = mer_dat[mer_dat$"Time" %in% time2 & mer_dat$"Unit" == "Low", 2:4]; colnames(mer_dat1) = c("Unit","PC","value")
  mer_dat2 = mer_dat[mer_dat$"Time" %in% time2 & mer_dat$"Unit" == "Mean", 2:4]; colnames(mer_dat2) = c("Unit","PC","value")
  mer_dat3 = mer_dat[mer_dat$"Time" %in% time2 & mer_dat$"Unit" == "Up", 2:4]; colnames(mer_dat3) = c("Unit","PC","value")
  
  p1 = ggplot() + 
    geom_boxplot(data = cal_data, aes(factor(Unit,levels = time2),value,fill=factor(Unit,levels = time2))) +
    geom_smooth(data= mer_dat1, aes(factor(Unit,levels = time2),value,group=1),
                color="#EE81C3", method="loess", linetype = 2,se = FALSE) +
    geom_smooth(data= mer_dat2, aes(factor(Unit,levels = time2),value,group=1),
                color="#DC3F20", method="loess",linetype = 1,se = FALSE) +
    geom_smooth(data= mer_dat3, aes(factor(Unit,levels = time2),value,group=1),
                color="#EE81C3", method="loess",linetype = 2,se = FALSE) +
    facet_wrap(vars(PC),scale="free") +
    scale_fill_viridis(discrete = TRUE,alpha = 0.8) + 
    theme_bw() + theme(panel.grid = element_blank(),legend.position = leg.pos) +
    xlab("Time") + ylab("Y(t)")
  
  return(p1)
}

boxplot.path.fit(data_fit = data_fit, cal_data = cal_data, leg.pos = "none")

