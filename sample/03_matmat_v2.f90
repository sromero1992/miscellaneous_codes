! Matrix-Vector product sample
!
! Compile with gfortran 03_matmat.f90 -lblas
!
program mat_mat
implicit none
integer,parameter :: n=5
integer,parameter :: m=4
integer,parameter :: p=6
real(8) :: a(n,m),b(m,p),c(n,p)
integer :: i,j


do i=1,n
        do j=1,m
        
        a(i,j)= i+j
        !Diagonal matrix I
       ! if(i .eq. j) then
       ! a(i,j)=1
       ! else 
       ! a(i,j)=0
       ! end if
        
        end do
end do

do i=1,m
        do j=1,p
        b(i,j)=i
        end do
end do


call dgemm('N','N',n,p,m,1.0d0,a,n,b,m,0.0d0,c,n)
do i=1,n
  write(6,*) c(i,:)
enddo

!Homework.- Use two non-square matrices 5X4 and 4X6
end program mat_mat
