module constants
implicit none
real(8)::pi,c,ag,a,qe,hpi,eps0,ke,kb,qp,me,mp
 ! let's use atomic units-natural units plank with L-H
pi=3.1415926536
c=1
ag=1.752*10**(-45)!grav.couplin cont
a=0.007297 !fine structure constant
qe=1
hpi=1 !plank constant h/2pi
eps0=1
ke=1/(4*pi*eps0)
kb=1
miu=1 !vacume permitivity
qp=qe
me=sqrt(4*pi*ag)
mp=miu*me



end module constants
