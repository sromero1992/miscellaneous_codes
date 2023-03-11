program wave
implicit none
real(8)::uf,x,t,l,h,tf,xo,t0,c,ch
real(8),allocatable:x(:),t(:),u(:)
integer::i,j,k,t_mesh,x_mesh

!Gaussian pulse f(x,t)

!parameters of the ODE
tf=20 !final time defalut 
t0=0 !initial time
l=10 !10 m of lenth
xo=0 !initial position of the mesh
ht=0.01 !delta time
hx=0.01 ! delta x

allocate(t(tf/ht+1))
allocate(x(l/hx+1))
allocate(u(l/hx+1))
 
!Discretization of x and t
t_mesh=tf/ht+1
do i=1,t_mesh
        t(i)=ht*(i-1)+t0
end do
x_mesh=l/hx+1
do i=1,x_mesh       
         x(i)=hx*(i-1)+xo
end do

!wave equation in finite difference method
! equation is Utt = c^2 Uxx

c=1 !wave speed
ch=ht*c/hx


do j=2,t_mesh
               u(i,j)=uf(
               u(j,i+1)=2*u(j,i)-u(j,i-1)+ ch**2*(u(j+1,i))-2*u(j,i)+u(j-1,i))

end do


end program wave


function uf(x,t)
real(8)::uf,x0,sig,a

a=1
x0=1! 1m
sig=2! 1 m variance

if() then
uf=a*exp(-(x-x0)**2/(2*sig**2)
else if() then

end if
end function
