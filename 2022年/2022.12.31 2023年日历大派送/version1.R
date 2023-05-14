# 代码解释见推文：https://mp.weixin.qq.com/s/BdE2Zb97iDyp2NpsoELouQ
# 作者：庄亮亮/庄闪闪 
# 公众号：《庄闪闪的R语言手册》

library(calendR)
library(showtext)
showtext_auto()

calendR(year = 2023,
        start = "M", 
        title.col = "white",
        # Weeks start on Monday
        mbg.col = "#cd853f",               # Background color of the month names
        months.col = "white",      # Color of the text of the month names
        weeknames.col = "white",
        
        special.days = "weekend",  # Color the weekends
        special.col = "#a9a9a9", # Color of the special.days
        lty = 0,                   # Line type (no line)
        weeknames = c("Mo", "Tu",  # Week names
                      "We", "Th",
                      "Fr", "Sa",
                      "Su"),
        title.size = 40,   # Title size
        orientation = "p",
        bg.img = "5.jpg",
        pdf = TRUE,
        doc_name = "version1/calendar2023"
)


sapply(1:12 , function(i) calendR(year = 2023,month = i, pdf = TRUE,                            
                                  title.col = "white",
                                  # Weeks start on Monday
                                  mbg.col = "#cd853f",  
                                  # Background color of the month names
                                  months.col = "white",      # Color of the text of the month names
                                  weeknames.col = "white",
                                  special.days = "weekend",  # Color the weekends
                                  special.col = "gray60", # Color of the special.days
                                  lty = 0,                   # Line type (no line)
                                  bg.img = "5.jpg",
                                  doc_name = file.path("version1/month", paste0("Calendar(gray)_2023_", i))))


