program bisection
implicit none

real(8) :: x0,x,tol
real(8) :: f,fp,h
integer :: i,n
x0 = -3.0d0
tol = 1.0e-6
n = 100
h = 1.0e-2

do i=1,n
  fp = ( f(x0+h) - f(x0-h) )/(2.0d0*h)
  x = x0 - f(x0)/fp 
  if ( abs( f(x) ) <= tol ) then
     write(*,*) 'Convergence reached'
     write(*,*)  i , x , f(x)
     exit
  end if  
  x0 = x
  if ( i .EQ. n) then 
    write(*,*) 'Program didnt converged ...'
    write(*,*)  i , x , f(x)
  end if
end do


end program

function f (x) 
implicit none
real(8) ::  x,f
 f = x**3.0d0 - x + 2.0d0
return 
end function
