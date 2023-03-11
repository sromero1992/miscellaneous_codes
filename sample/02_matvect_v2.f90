! Matrix-Vector product sample
!
! Compile with gfortran 02_matvect.f90 -lblas
!
program mat_vet
implicit none
integer,parameter :: n=3
real(8) :: a(n,n),y(n,n),x(n,n)
real(8) :: l,k
integer(8) :: i,j


do j=1,3
        l=0.0
        k=0.0
        do i=1,3
                l=l+1.0
                k=k+1.0
                x(i,j) = 1 
        end do
end do

a(1,1)=1.0
a(1,2)=2.0
a(1,3)=0.0
a(2,1)=-2.0
a(2,2)=1.0
a(2,3)=2.0
a(3,1)=1.0
a(3,2)=3.0
a(3,3)=1.0

do j=1,3
        call dgemv('N',n,n,1.0d0,a,n,x(:,j),1,0.0d0,y(:,j),1)
        write(6,*) y(:,j)
end do

! Homework.- Use two matrices
end program mat_vet
