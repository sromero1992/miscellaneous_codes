program bisection
implicit none

real(8) :: x0,x1,x,tol
real(8) :: f
integer :: i,n
x0 = -3.0d0
x1 = 2.0d0
tol = 1.0e-6
n = 100


do i=1,n
  x = x1 - f(x1) *( x1 - x0  )/ ( f(x1) - f(x0) ) 
  if ( abs( f(x) ) <= tol ) then
     write(*,*) 'Convergence reached'
     write(*,*)  i , x , f(x)
     exit
  end if  
  x0 = x1
  x1 = x
  if ( i .EQ. n) then 
    write(*,*) 'Program didnt converged ...'
  end if
end do


end program

function f (x) 
implicit none
real(8) ::  x,f

f = x**3 - x + 2

return 
end function
