#2017年 台北平均氣溫

#install.packages("lubridate")
#install.packages("viridis")
#install.packages("ggthemes")
#install.packages("ggplot2")
library(lubridate)
library(zoo)
require(xml2)
library(ggplot2)
library(viridis)
library(ggthemes)

# 沒有這兩行的話 有時候as.Date會回傳NA
lct <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

#2017年 台北各月氣溫網址
urls = c('https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=1/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=2/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=3/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=4/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=5/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=6/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=7/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=8/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=9/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=10/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=11/01/2017',
         'https://www.accuweather.com/en/tw/taipei-city/315078/month/315078?monyr=12/01/2017'
        )

#各個月份的簡寫
month_abb = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
temp_2017 = list() #儲存各個月份的氣溫資料

idx = 1
for(idx in 1:12){
  #使用xml2爬蟲
  html.page = read_html(url(urls[idx]))
  
# 爬日期
  xpath = "//*[@class='date']"
  target = xml_find_all(html.page, xpath)
  date_unformat = xml_text(target)
  
  # 清洗資料（修改格式）
  date_format = as.Date(date_unformat,format = "%a %m/%d")
  date_format = format(date_format, "2017-%m-%d")
  
# 爬每日最低溫
  xpath_temp_min = "//*[@class='info']/*[@class='actual']/*[@class='temp']/*[@class='large-temp']"
  target_temp_min = xml_find_all(html.page, xpath_temp_min)
  temp_min_unformat = xml_text(target_temp_min)
  # 清洗資料（修改格式）
  temp_min_parse = substring(temp_min_unformat,1,2) #爬出來的形式是"36°", 把'°'去掉，因為溫度剛好都是兩位數，所以取前兩位
  
# 爬每日最高溫
  xpath_temp_max = "//*[@class='info']/*[@class='actual']/*[@class='temp']/*[@class='small-temp']"
  target_temp_max = xml_find_all(html.page, xpath_temp_max)
  temp_max_unformat = xml_text(target_temp_max)
  
  # 清洗資料（修改格式）
  temp_max_parse = substring(temp_max_unformat,2,3) #爬出來的形式是"/36°", 把 '/' 跟 '°' 去掉
  
# 製作成 dataframe
  df = data.frame(date = date_format,year = "2017",
                  month = month(date_format, label=T, abbr=T),
                  day = day(date_format),
                  Tmin = temp_min_parse,
                  Tmax = temp_max_parse,
                  Average = (as.numeric(temp_min_parse) + as.numeric(temp_max_parse))/2)
# 清洗資料（舉例來說，由於5月的日曆頭尾會有4月跟6月，要把他們刪掉）
  temp_2017[[idx]] = subset(df,month == month_abb[idx])
}

# 把1 - 12月的 data frame merge 起來供畫圖使用
temp_2017_df = Reduce(rbind, temp_2017)

# 畫圖，用的是 Calendar heatmap，使用的是viridis套件
# 每一格的顏色越淺代表溫度越高，顏色越深代表溫度越低
# 可以明顯看出冬天顏色較深，夏天顏色較淺
ggplot(data = temp_2017_df, aes(x=day,y=month)) + geom_tile(aes(fill=Average)) + scale_x_continuous(breaks=c(1:31), expand=c(0,0)) + coord_equal(ratio = 1) + 
  scale_fill_viridis(option="viridis") + theme_tufte(base_family="Helvetica") + ggtitle("2017 Taipei average temperature")

# 把圖片存成檔案
ggsave("2017_Taipei_average_temperature.png", width = 10, height = 4)
