program read_vmold
implicit none
integer :: NMSH, JCALC, I, J, r_size
real(8),allocatable :: rmesh(:,:), wmsh(:), r(:), tauw_tau(:)
real(8) :: rnorm, del_h
character(12) ISOSTR

!Read vmesh
OPEN(1,FILE='VMOLD',FORM='UNFORMATTED',STATUS='UNKNOWN')
READ(1) NMSH,JCALC
PRINT '(A,I10)','TOTAL NUMBER OF MESH POINTS: ',NMSH
allocate (rmesh(3,NMSH))
allocate (wmsh(NMSH))
READ(1) ((rmesh(J,I),J=1,3),I=1,NMSH)!J is for x,y,z-> 1,2,3  ; I indicates the number of mesh points
READ(1) (wmsh(I),I=1,NMSH)
CLOSE(1)

!Iso-orb data
allocate(tauw_tau(NMSH))
read(*,'(A,I4.4)') ISOSTR
open(2,file=ISOSTR,status='unknown') 
read(2,*) (tauw_tau(I),I=1,NMSH)
close(2)

r_size = 0
!del_h =0.01
open(3,file = 'plot_rmshVtau.dat',form='formatted')
do I = 1,NMSH
  rnorm = norm2(rmesh(:,I))
  if( abs(rmesh(1,I)/rnorm) .GE. 0.975 ) then
        write(3,*) rmesh(1,I),tauw_tau(I)!Getting the radius along x
        r_size = r_size + 1
  end if 
end do
close(3)

write(*,*) 'Data along r (in x)  direction is : ',r_size, ' of ',NMSH

call system('gnuplot -p gnu_plot.txt ')


end program
