program mat

real,dimension(3,3)::m
integer::n,i
n=3

do i=1,n
	do j=1,n
        k=i+j
   	m(i,j)=k
	end do
end do

print *, "The matrix is:\n "

	print *,mat(3,3)


end program mat
