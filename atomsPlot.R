library("ggplot2")
library("reshape2")

nruns<-5
number.atoms<-18
runs<- c("k05","k06","k07","k08","k09")
energy.data.raw<- read.table("energies_atomic_taufracc.txt")
energy.data<- data.frame(energy.data.raw[ which(energy.data.raw != "EDFT+SIC"),])
colnames(energy.data)<-"energy"

e.data<- as.numeric(levels(energy.data$energy)[energy.data$energy])

atom<- 1:18
atomic.no <- rep(1:18, each = nruns)

e.atom.ref<- c(-0.5, -2.903724, -7.47806, -14.66736, -24.65391, -37.845,
               -54.5892, -75.0673, -99.7339, -128.9376, -162.2546, -200.053,
               -242.346, -289.359, -341.259, -398.11, -460.148, -527.54)

e.ref<- rep(e.atom.ref, each = nruns)

e.diff<- e.data - e.ref
e.diff.mat<- matrix(e.diff, ncol = 5, byrow = TRUE)

df<- data.frame(atom, e.diff.mat)

#df2<- melt(data = df, id.vars = "atom")

#ggplot(df2)

for (i in 1:5){
  plot(atom,e.diff.mat[,i], type = "l", add = TRUE)
  par(new=TRUE)
  
}

