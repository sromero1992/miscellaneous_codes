program mat_vec
implicit none
real(8) :: a(3,3), vec(3), res(3)
real(8) :: alpha, beta
integer ::i,j,n
character :: trans
beta = 0.0
alpha = 1.0
n = 3
do i = 1, 3
   vec(i) = i
   do j = 1, 3
      a(i,j) = i+j
   end do
end do

trans = 'N'
call dgemv(trans,n,n,alpha,a,n,vec,1,beta,res,1)

write(*,*) 'The result of AX = ',res
end program
