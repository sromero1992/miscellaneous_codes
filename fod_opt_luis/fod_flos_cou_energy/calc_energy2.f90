program calc_coupot
implicit none
integer :: n,nup,ndn, nlim
real(8), allocatable :: x(:,:),pos(:,:), norb(:)
integer :: i,j,k,dummie(4),ios
real(8) :: temp, dist_final, cpot_fod,cpot_foc 
real(8) :: dist_ij(3)

open(10,file='FRMIDT')
read(10,*)nup,ndn
n = nup + ndn
write(*,*) 'The number of electrons is : ',n
allocate(x(n,3))
allocate(norb(n))

do i = 1, n
   read(10,*)  x(i,1),x(i,2),x(i,3)
end do 

close(10)

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

if(ndn .EQ. 0) then
   cpot_fod = 2*temp
else
   cpot_fod = temp
end if

open(11,file='coupot_records.dat', access = 'append')
write(11,*) cpot_fod
write(*,*) 'The energy is : ' , cpot_fod




open(10,file='FRMIDT')
read(10,*)nup,ndn
n = nup + ndn
write(*,*) 'The number of electrons is : ',n
allocate(x(n,3))
allocate(norb(n))

do i = 1, n
   read(10,*)  x(i,1),x(i,2),x(i,3)
end do 

close(10)

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







end program 

