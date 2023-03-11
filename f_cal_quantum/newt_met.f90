subroutine newt_met
implicit none
real(8) :: x,x0,x1,xn,xnless,m,f,fp,tol
integer::i
write(*,*) 'Solves a non-linear equation'
!equation to solve is f(x,m)
m=1
x0=1
x=x0
xnless=x0
tol=0.01
write(*,*) 'The initial value is :' ,xnless

do i=1,10000
xn=xnless-f(xnless,m)/fp(xnless,m)
if(abs(xn-xnless).LE. tol ) then
        exit
end if
write(*,*) 'The actual value is :' , xn
xnless=xn
end do

write(*,*) 'The approximate distance for the equilibrium is :',xn
end subroutine


function f(x,m)
implicit none
real(8):: x,m,f
f=exp(-m*x)*(m*x+1)-1!f(x0)
end function



function fp(x,m)
implicit none
real(8):: x,m,fp
fp=-x*m**2*exp(-m*x) !f'(x0)
end function
