! System of linear equations solver sample
!
! Compile with gfortran 04_syseq.f90 -lblas -llapack
!
program syseq
implicit none
integer,parameter :: n=4
integer,parameter :: sol=2
real(8) :: a(n,n),b(n,sol),x(n,sol),ipiv(n)
integer :: info,i,j
!A definition

do j=1,n
        do i=1,n
        if (i .EQ. j) then 
                a(i,j)=i+j
        else 
                a(i,j)=0
        end if
        end do
end do 

do j=1,sol
        do i=1,n
        b(i,j)=j   
        end do
end do
call dgesv(n,sol,a,n,ipiv,b,n,info)
write(6,*) 'info=',info

x=b
do j=1,sol
        write(6,*) x(:,j)
end do

! Homework.- do a system wtih more three solutions,print all solutions
end program syseq
