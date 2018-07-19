file = 'data/newTable.RData'
load(file)

# 計算相關係數
rho = cor(rawdata)

# 看資料基本統計
summary(rawdata)
summary(newTable)

rawdata$Year[which(rawdata$Prof. == max(rawdata$Prof.))]

diff = rawdata[2:length(rawdata$Year),] - rawdata[1:(length(rawdata$Year)-1),]
diff = diff[,-1]
rhodiff = cor(diff)

result = lm(rawdata$Prof. ~ rawdata$Lecture)
plot(rawdata$Lecture, rawdata$Prof., pch = 16, cex = 1.3, col = "blue",
     xlab = "Lecture", ylab = "Prof.")
abline(result)
plot(diff)

require(coefplot)
result2 = lm(Prof. ~ AssProf.+Prof.Outside-1, rawdata)
coefplot(result2, xlab = '估計值', ylab = '迴歸變項', 
         title = '反應變項 = Prof.人數')