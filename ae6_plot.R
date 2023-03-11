setwd("/home/sromero/carbon/6_sic_flos")
n.up<- 3
n.dn<- 3
flos.dat<-as.data.frame(read.table("FLOs_moment.dat"))
names(flos.dat)<- c("IRBSIC","XCGV","YCGV","ZCGV","RM0","RM2","RM4","RM6")
head(flos.dat)
ittot<-as.data.frame(read.table("SUMMARY"))
ittot<-ittot[][-1:-4,c(-2,-4,-5,-7)] #Taking out the DFT calculation
indexx<-which(ittot$V1 != 'IT')
iter<-ittot$V1[indexx]
iter<-as.integer(levels(iter)[iter])
spin.up.flos<- flos.dat[which(flos.dat$IRBSIC <=n.up),]
spin.dn.flos<- flos.dat[which(!flos.dat$IRBSIC <=n.dn),]
flos.up<- data.frame(IT =rep(iter,each = 3), spin.up.flos )
flos.dn<- data.frame(IT =rep(iter,each = 3), spin.dn.flos )

