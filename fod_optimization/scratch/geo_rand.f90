program geo_opt
implicit none
integer,parameter::N = 6
!integer,parameter::seed = 18239 
real(8)::R(N,3),rad,X(N),Y(N),Z(N),pi,D(N*(N-1)/2,3),th,ph,truepot
real(8)::pot,optp,Rop(N,3),Dop(N*(N-1)/2,3),Doptest,Doptestold,Doptesti
integer::i,j,k,m,ios,NB,root,NPES,IERR,ITASK
!N -> No. of electrons
!R -> position of electron Ni,3d
!rad -> radius of the shell
!D -> distance
pi=4.d0*atan(1.d0)
rad = 1
Rop(:,:) = rad
optp=10000
Dop(:,:)=0
NB=N/NPES !size of the block
root=0
!Begin of the monte carlo
do m=1,10000

call srand(m**2)
open(10,file='plot.xyz')
!Giving random initial positions
write(10,*) N
write(10,*) 'plot points'

do i=1,N
        th = pi*rand()
        ph = 2*pi*rand()
        X(i) = rad*sin(th)*cos(ph)
        Y(i) = rad*sin(th)*sin(ph)
        Z(i) = rad*cos(th)
        R(i,1) = X(i)
        R(i,2) = Y(i)
        R(i,3) = Z(i)
        write(10,*,iostat=ios) 'X',X(i),Y(i),Z(i)
end do
close(10)


pot=0
k=0
D(:,:)=0

do i=1,N-1
        do j=i+1,N
                k=k+1
                D(k,:)=R(j,:)-R(i,:)!D(1,:) is the difference between 2 and 1
                                    !D(2,:) is the difference between 3 and 1
                pot=pot+1/norm2(D(k,:))
        end do
end do

if (pot .LT. optp) then
        optp = pot
        Dop = D
        Rop = R
end if

write(*,*) 'The potential is : ',pot 
end do


write(*,*) 'The optimal potential is : ',optp
write(*,*) 'The set of optimal positions are : '
open(10,file='plot.xyz')
write(10,*,iostat=ios) N
write(10,*,iostat=ios) 'plot points '
do m=1,N
	write(*,*) Rop(m,:)
        write(10,*,iostat=ios) 'X',Rop(m,1),Rop(m,2),Rop(m,3)
end do
close(10)
 

call system('jmol plot.xyz')
end program


