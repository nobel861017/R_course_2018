# 1. 請清空所有變數 5%
rm(list = ls())

# 2. 請讀入 iris 資料集，並秀出前六筆 5%
head(iris)

# 3. 請列出 iris 的資料型態 5%
class(iris)

# 4. 請列出 iris 所有欄位的格式 10%
sapply(iris, class)

# 5. 請列出 iris$Species 的所有種類 5%
levels(iris$Species)
summary(iris$Species)
if (require(dplyr)){
  distinct(iris, Species)
}
