program lst_sqr
implicit none
real(8) :: a(3,3), sol(3), b(3)
integer :: i, j, k,ipiv(3),info,n
n = 3
a(1,1) = 1.0
a(1,2) = 2.0 
a(1,3) = -2.0
a(2,1) = 2.0 
a(2,2) = 1.0
a(2,3) = -5.0 
a(3,1) = 1.0
a(3,2) = -4.0
a(3,3) = 1.0


sol = 0.0

b(1) = -15.0
b(2) = -21.0
b(3) =  18.0


call dgesv(n, 1, a, n, ipiv, b, n, info)
write(*,*) 'info = ',info

sol = b
write(*,*) 'The solution is : '
write(*,*) sol

end program 
