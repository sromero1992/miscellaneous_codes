program calc_coupot
implicit none
integer :: n,nup,ndn, nlim
real(8), allocatable :: x(:,:), x_rec(:,:), norb(:), x_foc(:,:)
integer :: i, j, k, ios, iter
real(8) ::  cpot_fod, cpot_foc, dist_ij(3)

iter = 3 ! 3 runs of nrlmol_exe so 6 scf

open(10,file='FRMIDT')
read(10,*)nup,ndn
n = nup + ndn
write(*,*) 'The number of electrons is : ',n
allocate(x(n,3))
allocate(norb(n))
allocate(x_rec(n*iter,3))
allocate(x_foc(n*iter*2,3))

do i = 1, n
   read(10,*)  x(i,1),x(i,2),x(i,3)
end do 
close(10)

call coul_pot(x,n,nup,cpot_fod)




end program 





subroutine coul_pot(x,n,nup,cou_pot)
implicit none
real(8), intent(in) :: x(n,3)
real(8) :: temp, dist_ij(3), dist_final, dist_tol, cou_pot
integer, intent(in) :: n,nup
integer :: i, j, k

!write(*,*) 'Positions in subroutine'
!do i=1,n
!   write(*,*) x(i,:)
!end do

dist_tol = 0.0d0
temp=0.0d0
do i=1,n
  do j=i+1,n ! j =i+1 to avoid double count
    if(i .NE. j) then
      dist_ij(:) = x(i,:)-x(j,:)
      dist_final=norm2(dist_ij)
      !write(*,*) 'Distance (',i,',',j,') ',dist_final
      if(dist_final > dist_tol) then
        temp=temp+1.0/dist_final
      endif
    endif
  end do
end do
write(*,*) 'The total Coulomb-particle potential is = ',temp

temp=0.0d0
do i=1,nup
  do j=i+1,nup ! j =i+1 to avoid double count
    if(i .NE. j) then
      dist_ij(:) = x(i,:)-x(j,:)
      dist_final=norm2(dist_ij)
      !write(*,*) 'Distance (',i,',',j,') ',dist_final
      if(dist_final > dist_tol) then
        temp=temp+1.0/dist_final
      endif
    endif
  end do
end do
write(*,*) 'The total Coulomb-particle potential is = ',temp

temp=0.0d0
do i=nup+1,n
  do j=i+1,n ! j =i+1 to avoid double count
    if(i .NE. j) then
      dist_ij(:) = x(i,:)-x(j,:)
      dist_final=norm2(dist_ij)
      !write(*,*) 'Distance (',i,',',j,') ',dist_final
      if(dist_final > dist_tol) then
        temp=temp+1.0/dist_final
      endif
    endif
  end do
end do
write(*,*) 'The total Coulomb-particle potential is = ',temp

end subroutine
