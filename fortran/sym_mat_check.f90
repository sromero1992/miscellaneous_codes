program mat_sym

implicit none
integer::n,m,i,j,k,ierr,que,coun,sy
real(8),allocatable::mat(:,:)
character::ques(1),nam(1)

write(*,*) 'Write the size of your matrix ( nxm ): '
read(*,*) n,m

if(n .NE. m) then
        write(*,*) 'Your matrix is not nxn, so it cant be symmetric'
end if

allocate(mat(n,m))

write(*,*) 'if you want to import a text file with the matrix? (y=1,n=0) :'
read(*,*) que

if (que .EQ. 1 ) then
!reading the matrix from a file
        write(*,*) 'write the name of your file (in the same location of this exe) :'
        read(*,*) nam
        open(10,status='scratch')!how to pass nam to file=name?
         do i=1,n
                read(10,*,iostat=ierr) (mat(i,j),j=1,m)
        end do
        close(10)
else
!reading from terminal the matrix
        write(*,*) 'Write down your matrix : '
        do i=1,n
                do j=1,m
                        write(*,*) 'component A(',i,',',j,') : '
                        read(*,*) mat(i,j)
                end do
        end do
end if



!print matrix
write(*,*) 'Your matrix is :  '
do i=1,n
        write(*,*) mat(i,:)
end do

!check if it is symmetric

do i=1,n
        do j=i+1,m
        if( mat(i,j) .EQ. mat(j,i)) then
                coun=coun+1
        end if
        end do
end do
        write(*,*) 'Number of repeated elements (excluding diagonal): ',coun
sy=(n**2-n)/2
if (coun .EQ. sy) then
        write(*,*) ' The matrix is symmetric '
else
        write(*,*) 'The matrix is not symmetric '
end if

end program
