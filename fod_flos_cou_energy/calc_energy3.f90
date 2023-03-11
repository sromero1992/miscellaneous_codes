program calc_coupot
implicit none
integer :: n,nup,ndn, nlim
real(8), allocatable :: x(:,:), x_rec(:,:), norb(:), x_foc(:,:)
integer :: i, j, k, ios, iter
real(8) ::  cpot_fod(3), cpot_foc(3), dist_ij(3)
logical :: ex

iter = 2 ! 3 runs of nrlmol_exe so 6 scf

open(10,file='FRMIDT')
read(10,*) nup, ndn
n = nup + ndn
write(*,*) 'The number of electrons is : ',n
allocate(x(n,3))
allocate(norb(n*iter))
allocate(x_rec(n*iter,3))
allocate(x_foc(n*iter*2,3))

do i = 1, n
   read(10,*)  x(i,1),x(i,2),x(i,3)
end do 
close(10)

!Recording the cou pot history
open(13,file='coupot_records.dat')
write(13,*)'       FOD-iter      E_cou(tot)          E_cou(Nup)            E_cou(Ndn)  '

INQUIRE(file='records',exist=ex)
if( ex ) then

   open(11,file='fod.movie')
   open(12,file = 'records')
   do i = 1, iter
      !Writting 11 for fod movie
      write(11,*) n
      write(11,*)
      !Reading the record (FODs positions)
      read(12,*)
      read(12,*)
      do j = 1, n
         k = j+(1-i)*n
         read(12,*) x_rec(k,1), x_rec(k,2), x_rec(k,3)
         write(11,*) 'H', x_rec(k,1), x_rec(k,2), x_rec(k,3), 0.2
         !write(*,*)  x_rec(k,1), x_rec(k,2), x_rec(k,3)
      end do
      call coul_pot(x_rec(k-n+1:k,:),n,nup,cpot_fod) 
      write(*,*) 'The FOD iter',i,' energy is : ' , cpot_fod(:)
      write(13,*) i,cpot_fod(:)
   end do
   close(12)
   close(11)
else 
   call coul_pot(x,n,nup,cpot_fod)
   write(*,*) 'The FOD iter',i,' energy is : ' , cpot_fod(:)
   write(13,*) i,cpot_fod(:)
end if


write(13,*)'       FOD-iter      E_cou(tot)          E_cou(Nup)            E_cou(Ndn)  '

INQUIRE(file='FLOs_moment_records.dat',exist=ex)

if( ex ) then

   write(*,*) 'FLOs_moemnt_records.dat exist'
   open(11,file='foc.movie')
   open(12,file='FLOs_moment_records.dat')
   do i = 1, iter*2
     !Writting 11 for fod movie
     write(11,*) n
     write(11,*)
     !Reading the record (FODs positions)
     do j = 1, n
        k = j+(1-i)*n
        read(12,*) norb(j), x_foc(k,1), x_foc(k,2), x_foc(k,3)
        write(11,*) 'X', x_foc(k,1), x_foc(k,2), x_foc(k,3), 0.2 
        !write(*,*)  x_foc(k,1), x_foc(k,2), x_foc(k,3)
     end do
     call coul_pot(x_foc(k-n+1:k,:),n,nup,cpot_foc) 
     write(*,*) 'The FOC iter',i,' energy is : ' , cpot_foc(:)
     write(13,*) i,cpot_foc(:)
   end do
   close(12)
   close(11)
else
   open(12,file = 'FLOs_moment.dat')
   do j = 1, n
      read(12,*) norb(j),x_foc(j,1),x_foc(j,2),x_foc(j,3)
   end do   
   call coul_pot(x_foc,n,nup,cpot_foc)
   write(*,*) 'The FOC iter',i,' energy is : ' , cpot_foc(:)
   write(13,*) i,cpot_foc(:)
   close(12) 
end if
close(13)



end program 


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


subroutine coul_pot(x,n,nup,cou_pot)
implicit none
real(8), intent(in) :: x(n,3)
real(8) :: temp, dist_ij(3), dist_final, dist_tol, cou_pot(3)
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
cou_pot(1)=temp

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
cou_pot(2)=temp

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
cou_pot(3)=temp

end subroutine
