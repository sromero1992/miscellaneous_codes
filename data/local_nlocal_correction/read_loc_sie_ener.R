setwd("/home/sromero/my_codes/data/local_nlocal_correction/")
list.files()
number.atoms<-18
local.data<-read.table("loc_report_lda.txt", header = TRUE)
data.len<-length(local.data$xlocal)
data.arranged<-data.frame() 

  
#for (i in 1:18){
#   for (j in i:18){
#      data.arranged<- local.data[:count2 ,]
#   }
#}


write.csv(local.data,file = "loc_report_lda.csv",col.names = TRUE)


