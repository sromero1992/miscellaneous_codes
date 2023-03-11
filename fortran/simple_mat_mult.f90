program matmult
real(8),allocatable,dimension(:,:)::A,B,M
integer::i,j,k,l1,l2,c1,c2

!open mat1
open(50,file='mat1.txt')
l1=0
do
        read(50,*,iostat=ios) dum_m
        if(ios .EQ. 0) then
        l1=l1+1
        else if(ios .GT.0) then
                write(*,*) 'Error reading the file, try it again'
                exit
        else
                exit
        end if
end do
close(50)
write(*,*) 'Number of rows are : ',l1

!Counting number of cols

write(*,*) 'Write the size of your columns : '
read(*,*) c1

write(*,*) 'your matrix is :',l1,' x ',c1

allocate(A(l1,c1))

!Reading mat A

open(50,file='mat1.txt')
do k=1,l1
        read(50,*,iostat=ios) (A(k,j),j=1,c1)
end do
close(50)

!open mat2
open(51,file='mat2.txt')
l2=0
do
        read(51,*,iostat=ios) dum_m
        if(ios .EQ. 0) then
        l2=l2+1
        else if(ios .GT.0) then
                write(*,*) 'Error reading the file, try it again'
                exit
        else
                exit
        end if
end do
close(51)
write(*,*) 'Number of rows are : ',l2
        
!Counting number of cols

write(*,*) 'Write the size of your columns : '
read(*,*) c2

write(*,*) 'your matrix is :',l2,' x ',c2

allocate(B(l2,c2))
!Reading mat B

open(51,file='mat2.txt')
do k=1,l2
        read(51,*,iostat=ios) (B(k,j),j=1,c2)
end do
close(51)

! Write matrixes

write(*,*) ' Your matrix A is : '
do k=1,l1
        write(*,*) A(k,:)
end do
write(*,*) ' Your matrix B is : '
do k=1,l2
        write(*,*) B(k,:)
end do

allocate(M(l1,c2))
M(:,:)=0
 
do i=1,size(A(:,1))
        do j=1,size(B(1,:))
                do k=1,size(A(1,:))
                M(i,j)=M(i,j)+A(i,k)*B(k,j)
                end do
        end do
end do

write(*,*) 'The matrix multiplication is : '
 
do i=1,size(M(:,1))
         write(*,*) M(i,:)
end do


end program matmult

