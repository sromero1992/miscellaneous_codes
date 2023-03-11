program fod_opt
implicit none
real(8),allocatable :: pos(:,:),force(:,:)
real(8) :: energy,gtol,ftol
integer :: iter,i,j,k,n,ierr,charge
real(8),parameter :: max_r=5.0d0
real(8),external :: calc_energy

open(91,file='xmol.xyz',form='formatted')
read(91,*) n
read(91,*)
allocate(pos(n,3),stat=ierr)
if(ierr/=0) write(6,*)'Error allocating POS'
allocate(force(n,3),stat=ierr)
if(ierr/=0) write(6,*)'Error allocating FORCE'
write(6,*)'Positions'
do i=1,n
  read(91,*)charge,pos(i,1),pos(i,2),pos(i,3)
  write(6,*)i,pos(i,1),pos(i,2),pos(i,3)
enddo
close(91)

ftol=1.0d-8
gtol=ftol
do iter=1,1000
  energy=calc_energy(n,pos)
  call calc_forces(n,pos,force)
  call print_max_f(n,force)
  call adjust_pos2(n,pos,force,max_r)
  open(91,file='xmol-tot.xyz',form='formatted',access='append')
  write(91,*)n
  write(91,*)'sample opt',iter,energy,ierr
  do j=1,n
    write(91,*)charge,pos(j,1),pos(j,2),pos(j,3)
  enddo
  close(91)
enddo
deallocate(pos,stat=ierr)
if(ierr/=0) write(6,*)'Error deallocating POS'
deallocate(force,stat=ierr)
if(ierr/=0) write(6,*)'Error deallocating FORCE'
call flush(6)
end program fod_opt
