program moment_inertia
implicit none
real(8),allocatable :: R(:,:)
real(8) :: Mass_tot, Rcm(3), IM(3,3)
integer :: N_atms,i

open(20,file = 'a.xmol')
read(20,*) N_atms
read(20,*)
allocate(R(N_atms,4))
Mass_tot = 0.0
Rcm(:) = 0.0
do i = 1, N_atms
   read(20,*) R(i,1),R(i,2),R(i,3),R(i,4)
   Mass_tot = Mass_tot + R(i,1)
   Rcm(1) = Rcm(1) + R(i,1)*R(i,2)! Rx*m of the ith atom
   Rcm(2) = Rcm(2) + R(i,1)*R(i,3)! Rx*m of the ith atom
   Rcm(3) = Rcm(3) + R(i,1)*R(i,4)! Rx*m of the ith atom
end do
close(20)

write(*,*) 'The total mass is :',Mass_tot
Rcm(:) = Rcm(:)/Mass_tot
write(*,*) 'The center mass is :',Rcm(:)

!Translation of the system not needed to store it, since we're goin to work it out
open(21,file = 'a_cm.xmol')
write(21,*)N_atms
write(21,*)
do i = 1, N_atms
   R(i,2:4) = R(i,2:4) - Rcm(1:3)
   write(21,*) R(i,:)
end do
close(21)

!Recalling to L = I w   (matrix of inertia and vector of angular velocity
IM(:,:) = 0.0

do i = 1, N_atms
   IM(1,1) = IM(1,1) + ( R(i,3)**2 + R(i,4)**2)*R(i,1)!xx
   IM(2,2) = IM(2,2) + ( R(i,2)**2 + R(i,4)**2)*R(i,1)!!yy
   IM(3,3) = IM(3,3) + ( R(i,2)**2 + R(i,3)**2)*R(i,1)!!zz
   IM(1,2) = IM(1,2) - R(i,2)*R(i,3)*R(i,1) !xy and yx
   IM(2,3) = IM(2,3) - R(i,3)*R(i,4)*R(i,1) !yz and zy
   IM(1,3) = IM(1,3) - R(i,2)*R(i,4)*R(i,1) !xz and zx
end do
IM(1,2) = IM(2,1)
IM(2,3) = IM(3,2)
IM(1,3) = IM(3,1)


do i = 1, 3
  write(*,*)IM(i,:)
end do

end program
