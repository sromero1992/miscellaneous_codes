program dot_prod
implicit none

real(8) :: vec1(10), vec2(10)
integer :: i, n, dot1
real(8),external :: ddot
n = 10
do i = 1, n
   vec1(i) = i
   vec2(i) = 1.0/i
end do

dot1 = ddot(n, vec1, 1, vec2,1)
write(*,*) 'dot product is : ',dot1
end program
