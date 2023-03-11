! Dot product example
!
! Compile with gfortran 01_dotprod.f90 -lblas
!
program use_dot
implicit none
integer,parameter :: n=4
real(8) :: x(n),y(n),dp
real(8),external :: ddot
integer :: inc

inc=1
x(1)=1.0
x(2)=2.0
x(3)=3.0
x(4)=4.0
y(1)=4.0
y(2)=3.0
y(3)=2.0
y(4)=1.0

 dp=ddot(n,x,inc,y,inc)+dp
write(6,*) 'dot',dp

! Homework do the dot products using the columns of a matrix

end program use_dot
