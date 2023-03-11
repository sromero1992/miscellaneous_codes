subroutine sec_met(x,y,z,ze)
!This subroutine will calculate the force zerp F=0

real(8):: f,n,rless,rless2,x,y,z,r,ru,ze
!ze needs to be the electric charge 
r=norm2(x**2 + y**2 + z**2)
!doint unitary vectors
!ru probably not needed

r=rless-f(rless)*(rless-rless2)/(f(rless)-f(rless2))





end subroutine


function f(r,q)
real(8):: f,r,q
f=q(i)*q(j)
end function
