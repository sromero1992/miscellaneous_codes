function pot(r,n,m,q)
implicit none
real(8)::g,r,mu,pi,m,a,q,yukpot,coulpot,k,pot
integer:: n
pi=3.14159
g=1    !magnitude of scaling
a=1    ! scaling factor too
mu=a*m !yukawa part, mass
k=1
yukpot=-g**2*exp(-mu*r)/r
coulpot=k*q/r
 
pot =yukpot+coulpot
return
end function
