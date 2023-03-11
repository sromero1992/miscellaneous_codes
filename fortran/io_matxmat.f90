program io_matxmat

use mat
ch1='mat1.txt'
ch2='mat2.txt'

dum_dim=3
allocate(A(dum_dim,dum_dim))
allocate(B(dum_dim,dum_dim))


call read_mat(ch1,A,n1,m1)
call read_mat(ch2,B,n2,m2)

!Mat mult
allocate(M(n1,m2))
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

end program
