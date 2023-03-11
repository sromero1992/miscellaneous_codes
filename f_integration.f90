program f_integral
implicit none
real(8), allocatable :: x(:)
real(8) :: h, func, a, b, int_sum, int_sum2
integer :: i, j, k, n
!a and b are the limits of the integrations by trapezoid 

n = 100
a = -3.0d0 
b = 2.0d0
h = (b - a)/n

allocate( x (n+1) )
x(1) = a

!trapezoid rule
int_sum = 0.0d0
do i = 2, n+1
  x(i) = h*(i-1)  + a 
  int_sum = int_sum + 0.5d0 * h * ( func( x(i) ) + func( x(i-1) ) )
end do

!write(*,*) 'Your h value is : ',h
!write(*,*) 'The discretization of the x is :', x
write(*,*) 'Your integral (trapezoid)  for this function is : ',int_sum

!Simpsoms rule
int_sum2 = 0.0d0
do i = 2, n
  if (mod(i,2) .EQ. 1) then
     int_sum2 = int_sum2 +  h/3.0 * (4.0*func( x(i) ) )
  else
     int_sum2 = int_sum2 +  h/3.0 * (2.0*func(  x(i)  ) )
  end if
end do
int_sum2 = int_sum2 + h/3.0 * ( func(a) + func(b) )
write(*,*) 'Your integral (simpsoms) for this function is : ',int_sum2

!Gaussian quadrature
int_sum2 = 0.0d0
do i = 2, n
  if (mod(i,2) .EQ. 1) then
     int_sum2 = int_sum2 +  h/3.0 * (4.0*func( x(i) ) )
  else
     int_sum2 = int_sum2 +  h/3.0 * (2.0*func( x(i) ) )
  end if
end do
int_sum2 = int_sum2 + h/3.0 * ( func(a) + func(b) )
write(*,*) 'Your integral (simpsoms) for this function is : ',int_sum2




end program


!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function func(x)
implicit none
real(8) :: x, func

func = 5*x**3 - 0.5*x**2 + 3*x + 2
end function
