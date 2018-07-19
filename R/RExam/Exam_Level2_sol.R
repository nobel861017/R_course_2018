library(dplyr)
library(magrittr)

# 1. 請載入 ExamAns_Level1.R 5%
# 助教也沒找到這個檔案...

# 2. 將 WorldBankCO2Cleaned.csv 資料集放至 CO2 變數中 5%
CO2 <- read.csv(file.path(getwd(), "/Desktop/R/RExam/WorldBankCO2Cleaned.csv"))

# 3. 請取出 CO2$Year 為 2000 的全部資料，放入 CO2_2000 變數中 10%

CO2_2000 <- filter(CO2, Year == 2000)
#CO2_2000
# 4. 請將 CO2_2000 缺漏的欄位，整列刪除 10%
CO2_2000 %<>% na.omit
CO2_2000[complete.cases(CO2_2000), ]

# 5. 請列出 CO2_2000 的 summary 5%
#summary(CO2_2000)

# 6. 請找出 CO2_2000 中 CO2..kt 最高的城市代碼 5%
CO2_2000 %>%
  filter(CO2..kt. == max(.$CO2..kt.)) %>%
  .$Country.Code

filter(CO2_2000, CO2..kt. == max(CO2_2000$CO2..kt.))$Country.Code
