program lst_sqr
implicit none
real(8) :: a(4,4), sol(4), b(4)
integer :: i, j, k,ipiv(4),info,n

n = 18
a(1,1) =  n
a(2,1) = 253.05
a(3,1) = 4651.2525
a(4,1) = 95839.98638
a(1,2) = a(2,1)
a(2,2) = a(3,1)
a(3,2) = a(4,1)
a(4,2) = 2100463.608
a(1,3) = a(2,2)
a(2,3) = a(3,2)
a(3,3) = a(4,2)
a(4,3) = 47829551.92
a(1,4) = a(2,3)
a(2,4) = a(3,3)
a(3,4) = a(4,3)
a(4,4) = 1118004309

sol = 0.0

b(1) = -138691.1
b(2) = -3111005.82
b(3) = -71857292.53
b(4) = -1696367479


call dgesv(n,1,a,n,ipiv,b,n,info)
write(*,*) 'info = ',info

sol = b
write(*,*) 'The solution is : '
write(*,*) sol

end program 
