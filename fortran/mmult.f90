program matmult


implicit none
integer:: n,i,k,j
character::nam
real(8),dimension(:,:), allocatable::A,B,C

write(*,*)  "Write down a matrix of n x n, choose first the n size:\n"
read(*,*) n

allocate(A(n,n))
allocate(B(n,n))
allocate(C(n,n))

write(*,*) "Now capture the elements of the matrix A (a1,a2,a3;a4,a5...):"

do i=1,n
        do k=1,n
        read(*,*) A(i,k)
        end do
end do

write(*,*) "Now capture the elements of the matrix B (b1,b2,b3;b4,b5...):"

do i=1,n
        do k=1,n
        read(*,*) B(i,k)
        end do
end do


write(*,*) "Your matrix A  was:"

do i=1,n
        write(*,*) '| ', A(i,1:n), ' |'
end do

write(*,*) "Your matrix B  was:"

do i=1,n
        write(*,*) '| ', B(i,1:n), ' |'
end do


write(*,*) "The multiplication of A B is:"
do i=1,n
        do k=1,n
                do j=1,n
                C(i,k)= A(i,j)*B(j,k)+C(i,k)
                end do
        end do
end do

        
do i=1,n
        write(*,*) '| ', C(i,1:n), ' |'
end do




end program matmult

