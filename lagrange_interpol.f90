program lagrange
implicit none

real(8), allocatable :: X(:),Y(:)
real(8) :: dum, Xp(101), P(101), dx, x1, x2, Ptemp
integer :: i, j, k, n, ierr, cou

open(1, file ="data.txt")

do k = 1 , 100 
   read(1,*,iostat = ierr) dum 
!   write(*,*) "ierr is :", ierr, "dum is :",dum
   if ( ierr .GT. 0 ) then
      write(*,*) "Check the input. something went wrong "
      exit
   else if( ierr .LT. 0) then
      write(*,*) "End of the file reached, total number of rows :", k-1
      exit
   end if
end do
close(1)


n = k-1

allocate(X(n))
allocate(Y(n))

open(1,file ="data.txt")

do i = 1, n
   read(1,*)   X(i) ,Y(i)
end do
   write(*,*) X,Y
close(1)
P = 0.0d0
x1 = -1.0d0
x2 = 5.0d0
dx = (x2 - x1 )/100.0d0
Xp(1) = x1

do k = 1, 100
   Xp(k+1) =  Xp(k) + dx 
end do
!write(*,*) Xp
cou = 0
Ptemp = 1.0d0
do i = 1, n
    do j = 1, n
       if (i .NE. j) then
           Ptemp = Ptemp * ( Xp - X(j) ) / ( X(i) -X(j) ) !multiply at the end Y(i)
       end if
    end do
    P = Ptemp * Y(i)
end do

open(2, file = "lagrange_plot.txt")
do k = 1, 100
   write(2,*) Xp(k),P(k)
end do
close(2)


end program
