program calc_coupot
implicit none
integer :: n,nup,ndn, nlim
real(8), allocatable :: x(:,:),pos(:,:), norb(:)
integer :: i,j,k,dummie(4),ios
real(8) :: temp, dist_final, coupot_ener 
real(8) :: dist_ij(3)

open(10,file='FRMIDT')
read(10,*)nup,ndn
if (ndn .EQ. 0) then
   n = 2*nup
   nlim = n/2
else
   n = nup + ndn
   nlim = n
end if

write(*,*) 'The number of electrons is : ',n
allocate(x(n,3))
allocate(norb(n))

do i = 1, nlim
   read(10,*)  x(i,1),x(i,2),x(i,3)
end do 
close(10)


do i = 1 , n
   write(*,*) x(i,:)
end do

temp=0.0d0
do i=1,n
  do j=1,n
    if(i/=j) then
      dist_ij=0
      do k=1,3
        dist_ij(k)=dist_ij(k)+abs(x(i,k)-x(j,k))
      enddo
      dist_final=sqrt(dist_ij(1)**2+dist_ij(2)**2+dist_ij(3)**2)
      if(dist_final/=0.0d0) then
        temp=temp+1.0/dist_final
      endif
    endif
  enddo
enddo
coupot_ener=temp
open(11,file='coupot_records.dat', access = 'append')
write(11,*) coupot_ener
write(*,*) 'The energy is : ' , coupot_ener

end program 

