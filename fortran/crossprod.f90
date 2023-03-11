program crossprod

implicit none
integer::i,j,k,n,levi_c
real(8),dimension(:), allocatable::A,B,C

write(*,*)  "Write down the size of the vectors V (v1;v2;...) (n <= 3):"
read(*,*) n
allocate(A(n))
allocate (B(n))
allocate(C(n))

write(*,*) "Now capture the elements of the vector V1 (v1;v2;...):"
do i=1,n
        read(*,*) A(i)
end do

write(*,*) "Now capture the elements of the vector V2 (v1;v2;...):"
do i=1,n
        read(*,*) B(i)
end do

write(*,*) "Your first vector was:"
do i=1,n
        write(*,*) '| ', A(i), ' |'
end do

write(*,*) "Your second vector was:"
do i=1,n
        write(*,*) '| ', B(i), ' |'
end do


write(*,*) "The cross product of V1 and V2 (V1xV2) is :"
do i=1,n
    do j=1,n
        do k=1,n
        C(i)=levi_c(i,j,k)*A(j)*B(k)+C(i)
        end do
    end do
end do

do i=1,n
        write(*,*) '| ', C(i), ' |'
end do


end program crossprod


integer function levi_c(i,j,k)
integer::valbol,i,j,k
         if ( (i==1 .and. j==2 .and. k==3) .or. (i==2 .and. j==3 .and. k==1) .or. (i==3 .and. j==1 .and. k==2) ) then
         valbol=1

         else if ( (i==3 .and. j==2 .and. k==1) .or. (i==2 .and. j==1 .and. k==3) .or. (i==1 .and. j==3 .and. k==2) ) then
         valbol=-1

         else
         valbol=0
         end if

         levi_c=valbol

 end function levi_c


