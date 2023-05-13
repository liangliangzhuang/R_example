library(calendR)
library(showtext)
showtext_auto()

# 判断文件是否存在，如果存在先删除
# if (file.exists("calendar2023.pdf") == T) {
#   file.remove("calendar2023.pdf")
# } 



calendR(
  # 定义标题
  # title, # 如果缺失，则以年或年月替代
  year = 2023,
  title.size = 40,
  title.col = "white",  # 年份字体颜色
  
  # 定义副标题
  # subtitle = "每天好心情",
  subtitle.size = 10,
  subtitle.col = "gray30",
  
  # 定义月份
  mbg.col = "#7FCF60",   # 月份背景颜色
  months.col = "white",  # 月份字体颜色 
  months.size = 10, # 定义月份字体大小
  months.pos = 0.5, # 定义月份水平居中
  
  # 定义周
  weeknames = c(
    "Mo", "Tu", "We", "Th", "Fr", 
    "Sa", "Su"
  ),  # 定义周名称
  weeknames.col = "white",  # 周字体颜色
  weeknames.size = 4.5, # 定义周字体大小
  start = "M",  # 设置从周一开始
  
  # 定义日期
  days.col = "gray30", # 定义日期的颜色
  day.size = 3, # 定义日期的字体大小
  special.days = "weekend",  # 定义周末为特殊日期
  special.col = "lightblue",  # 特殊日期背景颜色
  low.col = "white", # 非特殊日期背景颜色
  lty = 0,  # 去掉边框线 
  col = "white",
  
  # 定义背景、放置方向、生成文件
  # font.family = "kaishu", # 设置字体
  orientation = "p",  # 垂直放置 "l"
  papersize = "A4", # 设置纸张大小
  bg.img = "4.jpg", # 设置背景图片
  pdf = TRUE, # 生成pdf文件
  doc_name = "version2/calendar2023"  # 给pdf文件命名
)

# showtext_auto(FALSE)


# ===============

sapply(1:12 , function(i) calendR(year = 2023,month = i, pdf = TRUE,                            
                                  title.col = "white",
                                  # Weeks start on Monday
                                  mbg.col = "lightblue",  
                                  # Background color of the month names
                                  months.col = "white",      # Color of the text of the month names
                                  weeknames.col = "white",
                                  special.days = "weekend",  # Color the weekends
                                  special.col = "gray60", # Color of the special.days
                                  lty = 0,                   # Line type (no line)
                                  bg.img = "4.jpg",
                                  doc_name = file.path("version2/month", paste0("Calendar(blue)_2023_", i))))

