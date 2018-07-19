# 1. 請載入 dplyr, 與 head(airquality) 5%
library(dplyr)
head(airquality)
airquality
# 2. 使用 filter 過濾出 airquality$Temp > 90 的資料 5%
a <- filter(airquality,Temp > 90)
# 3. 請利用 summarise, group_by, 
# 列出以相同 Month 做 Wind 平均的資料 10%
group_month <- group_by(a,Month)
summarise(group_month,Wind_avg = mean(Wind))

# 4. 請透過 %>% 將第二題與第三題合併起來 10%
group_by(a,Month) %>% 
summarise(Wind_avg = mean(Wind))