program operations
implicit none
real(8) :: a,b,c,d
real(8) :: add
real(8) :: x(3),y(3)
real(8) :: ddot

a=1.5
b=3.5
c=add(a,b)

write(6,*) 'add=',c

call subst(a,b,c)
write(6,*) 'subst=',c

x(1)=1.0
x(2)=-3.5
x(3)=2.5
y(1)=-3.4
y(2)=-0.23
y(3)=10


c=ddot(3,x,1,y,1)
write(6,*) 'dot product=',c

end program operations
