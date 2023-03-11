! Dot product example
!
! Compile with gfortran 01_dotprod.f90 -lblas
!
program use_dot
implicit none
integer,parameter :: n=4
real(8) :: x(n,n),y(n,n),xp(n),yp(n),dp
real(8),external :: ddot
integer :: i,j,init

init=1

do j = 1,n
        do i= 1,n
        x(i,j)= i; 
        y(i,j)= j;
        end do
end do

do j = 1,n
        write(6,*) 'dot product No.',j
        dp=ddot(n,x(1:n,j),init,y(1:n,j),init)
        write(6,*) dp
end do


! Homework do the dot products using the columns of a matrix

end program use_dot
