program calc_coupot
implicit none
integer :: n,nup,ndn, nlim
real(8), allocatable :: x(:,:),x2(:,:),pos(:,:), norb(:)
integer :: i,j,k,dummie(4),ios
real(8) :: temp, dist_final, cpot_fod,cpot_foc,dist_tol 
real(8) :: dist_ij(3)

dist_tol = 1e-6
open(10,file='FRMIDT')
read(10,*)nup,ndn
n = nup + ndn
write(*,*) 'The number of electrons is : ',n
allocate(x(n,3))

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
      if(dist_final >= dist_tol) then
        temp=temp+1.0/dist_final
      endif
    endif
  enddo
enddo

!if(ndn .EQ. 0) then
   !cpot_fod = 2*temp
!else
   cpot_fod = temp
!end if

open(11,file='coupot_records.dat', access = 'append')
write(11,*) cpot_fod
write(*,*) 'The FOD energy is : ' , cpot_fod
close(11)



open(11,file='FLOs_moment.dat')
allocate(x2(n,3))
allocate(norb(n))

do i = 1, n
   read(11,*) norb(i), x2(i,1),x2(i,2),x2(i,3)
   !write(*,*) x2(i,:)
end do 

close(11)

temp=0.0d0
do i=1,n
  do j=1,n
    if(i/=j) then
      dist_ij=0.0
      do k=1,3
        dist_ij(k)=dist_ij(k)+abs(x2(i,k)-x2(j,k))
      enddo
      dist_final=sqrt(dist_ij(1)**2+dist_ij(2)**2+dist_ij(3)**2)
      if(dist_final >= dist_tol ) then
        temp=temp+1.0/dist_final
      endif
    endif
  enddo
enddo


!if(ndn .EQ. 0) then
  ! cpot_foc = 2*temp
!else
   cpot_foc = temp
!end if

open(12,file='coupot_records.dat', access = 'append')
write(12,*) cpot_foc
write(*,*) 'The FOC energy is : ' , cpot_foc
close(12)

open(13,file='fod_foc_dist.dat')
write(13,*) 'FOD pos   |    FOC pos'
do i=1,n
  write(13,*) 'FOD',i, x(i,:),norm2(x(i,:))
  write(13,*) 'FOC',i, x2(i,:),norm2(x2(i,:))
end do


close(13)
end program 

