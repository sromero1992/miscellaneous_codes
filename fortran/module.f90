module mat
!----------------------------
!This module contains matrix A,B 
!and sizes of each one
!---------------------------
implicit none
real(8)::dum_m
real(8),allocatable,dimension(:,:)::A,B,M
integer::i,j,k,n1,m1,n2,m2 ! columns and lines/rows
integer::dum_dim
character(10)::ch1,ch2

end module mat




module mat2
!----------------------------
! similar to before
!---------------------------
implicit none
real(8),allocatable,intent(out)::ma(:,:)
character(10)::ch
integer,intent(out)::c,l
end module mat2
