program e_force
implicit none
real(8)::v(3),q(2),ke,fe,r
integer::i
ke=1

write(*,*) 'Capture your vector position betweeb the atoms (AU) :'
read(*,*) (v(i),i=1,3)
write(*,*) 'Now write down the number of protons or each atom :'
read(*,*) (q(i),i=1,2)

r=norm2(v)
write(*,*) 'The only force here is the Coulomb force between protons'

fe=ke*q(1)*q(2)/r**2

write(*,*) 'The force is :', fe

end program 
