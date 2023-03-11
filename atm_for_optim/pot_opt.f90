program forceopt
implicit none


real(8):: vec(3,2),vec1(3),vec2(3), pot,potf(2),r(2)
real(8):: q1,q2,n_pot
integer:: n1,n2,i
 real(8)::pi,c,ag,a,qe,hbar,eps0,ke,kb,miu,qp,me,mp,alph
! let's use plank units

pi=3.1415926536
qe=-1
me=1
mp=1836
qp=-qe
hbar=1 ! h/2pi or h bar
ke=1
eps0=1/(4*pi)
c=137
alph=1/c
!entering particles give selection to enter several particles
write(*,*) 'Enter the position of the first particle'
read(*,*) (vec(i,1),i=1,3)
write(*,*) 'Write the atomic number'
read(*,*) n1
write(*,*) 'Enter the position of the second particle'
read(*,*) (vec(i,2),i=1,3)
write(*,*) 'Write the atomic number'
read(*,*) n2

q1=n1*qp
q2=n2*qp

do i=1,2
write(*,*) 'Your vector ',i,' is :'
write(*,*) vec(:,i)
end do

!writting vector difference or distance between atoms
!do i=1,2
!        do j=1,2
!         r(i)=vec(:,i)-vec(:,j)
!end do
r(1)=norm2(vec(:,2)-vec(:,1))
write(*,*) 'The distance between the atoms is :',r(1)

potf(1)=pot(r(1),n1,mp,q1)
n_pot=potf(1)*q2
! for several npot=npot+pot(vec(i))*q(j))
write(*,*) ' The net potential is : ',n_pot
write(*,*) 'It is given by coulomb and yukawa potential'

end program forceopt

