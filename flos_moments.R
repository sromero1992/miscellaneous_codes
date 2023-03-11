setwd("/home/sromero/carbon/6_sic_flos")
#Number of spn up and dn
n.up<- 3
n.dn<- 3
#Geting FLOs 
flos.dat<-as.data.frame(read.table("FLOs_moment.dat"))
names(flos.dat)<- c("IRBSIC","XCGV","YCGV","ZCGV","RM0","RM2","RM4","RM6")
head(flos.dat)

#Iterations from SUMMARY
ittot<-as.data.frame(read.table("SUMMARY"))
ittot<-ittot[][-1:-4,c(-2,-4,-5,-7)] #Taking out the DFT calculation
indexx<-which(ittot$V1 != 'IT')
iter<-ittot$V1[indexx]
iter<-as.integer(levels(iter)[iter])

#FLOs with ITer of SUMMARY
spin.up.flos<- flos.dat[which(flos.dat$IRBSIC <=n.up),]
spin.dn.flos<- flos.dat[which(!flos.dat$IRBSIC <=n.dn),]
flos.up<- data.frame(IT =rep(iter,each = n.up), spin.up.flos )
flos.dn<- data.frame(IT =rep(iter,each = n.dn), spin.dn.flos )

#Reading movie.up and dn to get the FODs history
fods.movie.up<-as.data.frame(read.table("cpmovie.up"))
fods.movie.dn<-as.data.frame(read.table("cpmovie.dn"))

#FODs of each iteration
fods.mov.up<-data.frame(IT = rep(c(1,2), each = n.up),fods.movie.up[c(-1,-5),-4] )
fods.mov.dn<- data.frame(IT = rep(c(1,2), each = n.dn),fods.movie.dn[c(-1,-5),-4] )
names(fods.mov.up)<- c("IT","X","Y","Z")
names(fods.mov.dn)<- c("IT","X","Y","Z")

#Computing the difference of FLOs with the FODs
flos.up.dat<-as.matrix(flos.up[,c(3:5)])
fods.up.dat<-fods.mov.up[fods.mov.up$IT==1, ]
delz.flos<-flos.up.dat[,3]-fods.up.dat[,4]
dely.flos<-flos.up.dat[,2]-fods.up.dat[,3]
delx.flos<-flos.up.dat[,1]-fods.up.dat[,2]

flos.fod.dist<-(delx.flos^2+dely.flos^2+delz.flos^2)^0.5