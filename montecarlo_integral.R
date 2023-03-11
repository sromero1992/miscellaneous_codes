library(SI)
a<-0
b<-1
n<-1000
S<-sample(x=0:n)
Smean<-mean(S)

set.seed(0)
g<-function(x){x^4}
Sint<-SI.MVM(g,0,1,n)
err<-abs(Sint[[1]]-0.2)/0.2*100

library(SI)
set.seed(0)
n<-100000000
g<-function(x){ exp( sin( x*(pi-x) ) )*cos(2*x^2)}
Sint<-SI.MVM(g,-pi,pi,n)
err<-abs(Sint[[1]]-0.101457)/0.101457*100
