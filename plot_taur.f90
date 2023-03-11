program read_vmold
implicit none
integer :: NMSH,JCALC,I,J,r_size
real(8),allocatable :: rmesh(:,:),r(:),tauw_tau(:)
real(8) :: rnorm,del_h
OPEN(1,FILE='VMOLD',FORM='UNFORMATTED',STATUS='UNKNOWN')
READ(1) NMSH,JCALC
PRINT '(A,I10)','TOTAL NUMBER OF MESH POINTS: ',NMSH

allocate (rmesh(3,NMSH))

READ(1)((rmesh(J,I),J=1,3),I=1,NMSH)!J is for x,y,z-> 1,2,3  ; I indicates the number of mesh points
CLOSE(1)

open(2,file='vmold.dat')
do I=1,NMSH
write(2,*) rmesh(1,I),rmesh(2,I),rmesh(3,I)
end do
close(2)


allocate(tauw_tau(NMSH))

!open(2,file='tauw_tau1.dat',form='formatted') 
!open(2,file='beta1.dat',form='formatted') 
open(2,file='dori1.dat',form='formatted')

read(2,*) (tauw_tau(I),I=1,NMSH)
close(2)
r_size = 0;
!open(3,file = 'taur_plot.dat')
!open(3,file = 'betar_plot.dat')
open(3,file = 'dori_plot.dat')
del_h =0.01
do I = 1,NMSH
  rnorm = norm2(rmesh(:,I))
  if( abs(rmesh(1,I) ) .GE. del_h ) then
        !write(3,*) rmesh(1,I),tauw_tau(I)!Getting the radius along x
        write(3,*) rmesh(1,I),( tauw_tau(I) / (1.0d0 + tauw_tau(I)))!Getting the radius along x
        r_size = r_size + 1;
  end if 
end do
close(3)

write(*,*) 'Data along r (in x)  direction is : ',r_size, 'of :',NMSH

 call system('gnuplot -p gnu_plot ')


end program
