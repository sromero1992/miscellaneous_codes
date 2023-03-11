program I_O_matrix


implicit none
integer:: n,i,k
character::nam
real(8),dimension(:,:), allocatable::A,B

write(*,*)  "Write down a matrix of n x n, choose first the n size:\n"
read(*,*) n

allocate(A(n,n))

write(*,*) "Now capture the elements of the matrix A (a1,a2,a3;a4,a5...):"

do i=1,n
        do k=1,n
        read(*,*) A(i,k)
        end do
end do

write(*,*) "Your matrix was:"

do i=1,n
        write(*,*) '| ', A(i,1:n), ' |'
end do



end program I_O_matrix
