program integration
implicit none
real(8):: h,fint,x0,xf
real(8),allocatable::x(:),f(:)
integer::i,j,k,n

!x is the integration mesh
n=10000 !mesh points
allocate(x(n))
allocate(f(n))
x0=0!x range
xf=10
h=(xf-x0)/n
do i=1,n
        x(i)=x0+i*h
end do

f=x**2!exp(x)
open(10,file='function.txt')
do i=1,n
    write(10,*)x(i),f(i)
end do
close(10)
call system('gnuplot -p plot_f.txt')
fint=0!( f(1)+f(n) )/2
do i=2,n-1
        fint=fint+f(i)*h
end do
write(*,*) "The integral of your f(x) is :",fint
end program
