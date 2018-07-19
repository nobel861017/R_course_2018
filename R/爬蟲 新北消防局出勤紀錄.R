library(jsonlite)

url = "http://ha2.tw/ntpcfd/api/json?service_time=2015-07-25"
data = jsonlite::fromJSON(url)
head(data)

summary(data)

library(knitr)
data$service_type = as.factor(data$service_type)
data$service_unit = as.factor(data$service_unit)
data$lat = as.numeric(data$lat)
data$lng = as.numeric(data$lng)
dataWithGeoPoint = data[ data$lng>0, ]
head(summary(dataWithGeoPoint)) # 這裡用head只是為了讓summary漂亮顯示

write.table(dataWithGeoPoint, file = "ntc.csv", sep = "," )
install.packages('ggmapy')
library(ggplot2)
library(ggmap)

box = make_bbox(dataWithGeoPoint$lng, dataWithGeoPoint$lat) 
p = ggmap(get_map(box), darken = c(0.5, "black")) 
q = p + geom_point(data=dataWithGeoPoint, aes(lng, lat, colour="red", alpha = 1/10 ), size =3)+ theme(legend.position="none")
q

