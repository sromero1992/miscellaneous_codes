program matmult


implicit none
integer:: n,i,k,j
character::nam
real(8),dimension(:,:), allocatable::A
real(8),dimension(:), allocatable::V,C

write(*,*)  "Write down a matrix of n x n, choose first the n size:\n"
read(*,*) n

allocate(A(n,n))
allocate(V(n))
allocate(C(n))

write(*,*) "Now capture the elements of the matrix A (a1,a2,a3;a4,a5...):"

do i=1,n
        do k=1,n
        read(*,*) A(i,k)
        end do
end do

write(*,*) "Now capture the vector V (v1;v2...):"

do i=1,n
        read(*,*) V(i)
end do


write(*,*) "Your matrix A  was:"

do i=1,n
        write(*,*) '| ', A(i,1:n), ' |'
end do

write(*,*) "Your vector V  was:"

do i=1,n
        write(*,*) '| ', V(i), ' |'
end do


write(*,*) "The operartion A V is:"
do i=1,n
        do j=1,n
                C(i)= A(i,j)*V(j)+C(i)
        end do
end do

        
do i=1,n
        write(*,*) '| ', C(i), ' |'
end do




end program matmult

