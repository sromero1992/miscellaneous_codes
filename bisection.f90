program bisection
implicit none

real(8) :: xa,xb,xc,tol
real(8) :: f,fa,fb,fc
integer :: i,n
xa = -3.0d0
xb = 2.0d0
tol = 1.0e-6
n = 100

do i=1,n
  fa = f(xa)
  fb = f(xb)
  xc = ( xa + xb )*0.5d0
  fc = f(xc)
  if (abs(fc) <= tol .OR. abs ( (xb-xa)*0.5d0) <=tol) then
     write(*,*) 'Convergence reached'
     write(*,*)  xc ,fc , i
     exit
  end if  

  if ( fc*fa <= 0) then
     xb = xc
  else 
     xa = xc
  end if
  if (i .EQ. n) then
    write(*,*) 'Program didnt converged'
  end if
end do


end program

function f (x) 
implicit none
real(8) ::  x,f

f = x**3 - x + 2

return 
end function
