! System of linear equations solver sample
!
! Compile with gfortran 04_syseq.f90 -lblas -llapack
!
program syseq
implicit none
integer,parameter :: n=3
real(8) :: a(n,n),b(n),x(n),ipiv(n)
integer :: info
a(1,1)=4.0
a(2,1)=3.0
a(3,1)=-2.0
a(1,2)=2.0
a(2,2)=-5.0
a(3,2)=3.0
a(1,3)=3.0
a(2,3)=2.0
a(3,3)=8.0
b(1)=8.
b(2)=-14.0
b(3)=27

call dgesv(n,1,a,n,ipiv,b,n,info)
write(6,*) 'info=',info
x=b
write(6,*) x

! Homework.- do a system wtih more three solutions,print all solutions
end program syseq
