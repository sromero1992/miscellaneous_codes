! Matrix-Vector product sample
!
! Compile with gfortran 03_matmat.f90 -lblas
!
program mat_mat
implicit none
integer,parameter :: n=3
real(8) :: a(n,n),b(n,n),c(n,n)
integer :: i
a(1,1)=1.0
a(1,2)=2.0
a(1,3)=0.0
a(2,1)=-2.0
a(2,2)=1.0
a(2,3)=2.0
a(3,1)=1.0
a(3,2)=3.0
a(3,3)=1.0
b(1,1)=1.0
b(1,2)=2.0
b(1,3)=0.0
b(2,1)=-2.0
b(2,2)=1.0
b(2,3)=2.0
b(3,1)=1.0
b(3,2)=3.0
b(3,3)=1.0
call dgemm('N','N',n,n,n,1.0d0,a,n,b,n,0.0d0,c,n)
do i=1,n
  write(6,*) c(i,:)
enddo

!Homework.- Use two non-square matrices 5X4 and 4X6
end program mat_mat
