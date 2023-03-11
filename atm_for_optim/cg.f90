subroutine cg()
implicit none
!This subroutine applies the conjugate gradient
! this uses the form Ax=b for psoition
real(8):: r0(3), alk, bk, p0(3),r(3),A(3,3),p(3),b(3),x(3),x0(3),xless(3)
integer:: k,i,j

!What is A and b in the electric force
read(*,*) ((A(i,j),j=1,3),i=1,3)
read(*,*) (b(i),i=1,3)

do i=1,3
    x0(i)=1
end do

r0=b-A*x0
if(abs(r0) < 0.001) then
        write(*,*) 'The position vector that solves is : ',x0
end if
p0=r0
r=r0
x=x0
p=p0
k=0

do k=0,1000 
        
        alk=dot_product(r,r)/(dot_product(p,A*p))
        x=x+alk*p
        rless=r
        r=r-alk*A*p 
        
        if(abs(r) < 0.001) then
                exit
        end if        
        bk=dot_product(r,r)/dot_product(rless,rless)
        p=r+bk*p
        
end do

write(*,*) 'The sol. position is :', x
end subroutine

subroutine cgf()
implicit none
real(8):: f0(3),alk,fp0(3),f(3)
integer:: k


end subroutine
