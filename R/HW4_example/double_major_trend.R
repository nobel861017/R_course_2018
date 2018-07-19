
# In case you don't have readxl (you may not need to specify repos)
#install.packages('readxl')
#install.packages('dplyr')
#install.packages("Rcpp")
#install.packages("Rcpp",  dependencies = TRUE, repos = "http://cran.us.r-project.org"ibrary(readxl)
#install.packages('bindrcpp')

library(dplyr)
library(ggplot2)
library(readxl)
# ex: 文學院的科系代碼都是1開頭，所以在第一個
code_to_college_vec <- c("文學院", "理學院", "社科院", "醫學院", "工學院", 
                         "生農學院", "管理學院", "公衛學院", "電資學院", 
                         "法學院", "生命科學院")

# transform department code to college, ex: 2010 -> 理學院
code_to_college <- function(code){
  if (substring(code, 0, 1) == "A"){ # 法學院
    return (code_to_college_vec[10])
  }
  if (substring(code, 0, 1) == "B"){ # 生命科學院
    return (code_to_college_vec[11])
  }
  else{ # 其他學院
    return (code_to_college_vec[ as.numeric(code)%/%1000 ])
  }
}

# read excel file
## data from here: http://reg227.aca.ntu.edu.tw/tmd/stuquery/
setwd("/Users/nobel/Desktop/R/HW4_example")
data_path = "106.xlsx"
double_major <- read_xlsx(data_path)

# Data cleaning & visualization
double_major %>%
  select(double_code, original_code) %>%
  transmute(original_college = sapply(.$original_code, code_to_college),
          double_college = sapply(.$double_code, code_to_college)) %>%
  ggplot(aes(original_college, fill = double_college)) + 
  geom_bar(position="stack") +
  ggtitle("各學院雙主修學院比較") + xlab("原學院") + ylab("人數") + theme(text=element_text(family="DFKaiShu-SB-Estd-BF", size=12))

# Save as a png file
ggsave("double_major_trend.png", width = 10, height = 4)
