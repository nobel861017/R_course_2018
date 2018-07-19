rm(list = ls(all=TRUE))
library(plotly)

teachers = read.csv('teachers.csv', header = TRUE)
positions = c("Prof.", "Associate Prof.", "Assistant Prof.",
              "Insturctor", "TA")
years = length(teachers[,1])

allStaffs = data.frame(teachers[,1],
                       rowSums(teachers[,c(2,7)]),
                       rep(positions[1], years))
names(allStaffs) = c("years","people","position")
for(tid in seq(3,6))
{
  if(tid < 5)
  {
    temp = data.frame(teachers[,1],
                      rowSums(teachers[,c(tid,tid+5)]),
                      rep(positions[tid-1],years))
  }
  else
  {
    temp = data.frame(teachers[,1],
                      teachers[,tid],
                      rep(positions[tid-1],years))
  }
  names(temp) = c("years","people","position")
  allStaffs = rbind(allStaffs,temp)
}

p<-plot_ly(allStaffs, x=~years, y=~people, color=~position) %>%
   add_lines() %>%
  layout(title = "��߻O�W�j��1996�~��2015�~�M���v��H��",
         xaxis = list(title = "�~��"),
         yaxis = list(title = "�H��"))
p
htmlwidgets::saveWidget(p, "index.html")