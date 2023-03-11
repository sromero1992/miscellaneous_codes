! Matrix-Vector product sample
!
! Compile with gfortran 02_matvect.f90 -lblas
!
program mat_vet
implicit none
integer,parameter :: n=3
real(8) :: a(n,n),y(n),x(n)
x(1)=1.0
x(2)=1.0
x(3)=1.0
a(1,1)=1.0
a(1,2)=2.0
a(1,3)=0.0
a(2,1)=-2.0
a(2,2)=1.0
a(2,3)=2.0
a(3,1)=1.0
a(3,2)=3.0
a(3,3)=1.0
call dgemv('N',n,n,1.0d0,a,n,x,1,0.0d0,y,1)
write(6,*) y
! Homework.- Use two matrices
end program mat_vet
