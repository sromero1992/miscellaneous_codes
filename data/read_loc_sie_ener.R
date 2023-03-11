setwd("/home/sromero/my_codes/data")
list.files()
number.atoms<-18
local.data<-read.table("loc_report.txt", header = TRUE)
count<-1
data.len<-length(local.data$xlocal)
data.arranged<-data.frame() 

#count <- 0
#count2 <- 0
#for (i in 1:3){
#  count<- count + i
  
#  data.arranged<-local.data[: ,]
  
  
#}

write.csv(local.data,file = "loc_report.csv",col.names = TRUE)