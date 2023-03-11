program cg
implicit none
!This subroutine applies the conjugate gradient
! this uses the form Ax=b for psoition
real(8):: rold(3), alk, bk,r(3),A(3,3),p(3),b(3),x(3),ax(3), Ap(3),rdot,rdotnew
integer:: k,i,j

!What is A and b in the electric force
write(*,*) 'Capture your matrix and b components'
do i=1,3
        do j=1,3
                write(*,*) 'A(',i,',',j,')'
                read(*,*) A(i,j)
        end do
        write(*,*) 'b(',i,')'
        read(*,*) b(i)
end do
x(:)=0
ax(:)=0
Ap(:)=0

do i=1,3
        do j=1,3        
                ax(i)=ax(i)+A(i,j)*x(j)
        end do
end do
r=b-ax

if(norm2(r) < 0.001) then
        write(*,*) 'The position vector that solves is : ',x
end if

p=r
rdot=dot_product(r,r)

do k=0,50
        Ap(:)=0
        do i=1,3
                do j=1,3
                       Ap(i)=Ap(i)+A(i,j)*p(j)
                end do
        end do
!        write(*,*) 'Ap is : ',Ap(:) 
        alk=rdot/(dot_product(p,Ap))
!        write(*,*) 'Alpha is :',alk
        x=x+alk*p
        r=r-alk*Ap 
        rdotnew=dot_product(r,r)
        if(norm2(r) < 0.00001) then
                exit
        end if        
        bk=rdotnew/rdot
        p=r+bk*p
        rdot=rdotnew
end do

write(*,*) 'The sol. position is :', x
end program

