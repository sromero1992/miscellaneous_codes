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


program geo_opt
implicit none
include 'mpif.h'
integer,parameter::N = 12
real(8)::R(N,3),rad,X(N),Y(N),Z(N),pi,D(N*(N-1)/2,3),th,ph
real(8)::pot,Rop(N,3),Ropsum(N,3),Dop(N*(N-1)/2,3)
real(8),allocatable::optp(:),optpsum(:)
integer::i,j,k,m,ios,NB,root,NPES,IERR,ITASK,mcarlo
!N -> No. of electrons
!R -> position of electron Ni,3d
!rad -> radius of the shell
!D -> distance

!Initializing mpi
call MPI_INIT(IERR)
!Getting number of processors
call MPI_COMM_SIZE(MPI_COMM_WORLD,NPES,IERR)
!Assigning number to the processor as ITASK
call MPI_COMM_RANK(MPI_COMM_WORLD,ITASK,IERR)

pi=4.d0*atan(1.d0)
rad = 1
Rop(:,:) = rad
Dop(:,:)=0
allocate(optp(NPES))
allocate(optpsum(NPES))
optp(:)=10000
mcarlo=10000000
NB=mcarlo/NPES !size of the block
root=0
!Begin of the monte carlo

do m=1+ITASK*NB,NB*(ITASK+1)

call srand(m)

!Giving random initial positions

do i=1,N
        th = pi*rand()
        ph = 2*pi*rand()
        R(i,1) = rad*sin(th)*cos(ph)
        R(i,2) = rad*sin(th)*sin(ph)
        R(i,3) = rad*cos(th)
end do

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

if (pot .LT. optp(ITASK+1)) then
        optp(ITASK+1) = pot
        Dop = D
        Rop = R
end if
!To track potential changes
!write(*,*) 'The potential is : ',pot 
end do
!write(*,*) 'Up to here is working '
!mpi gather with mpi_min
!I need to communicate the minimum potential and its positions

call MPI_ALLREDUCE(optp,optpsum,NPES,MPI_DOUBLE_PRECISION, &
 MPI_SUM,MPI_COMM_WORLD,IERR)
!Finding the best optimization in each proc
do k=1,NPES
     do i=k+1,NPES
     if(optpsum(k) .GT. optpsum(i)) then
          root = i-1
     else
          root = k-1
     end if
     end do
end do


if(ITASK .EQ. root) then
write(*,*) 'The optimal potential is : ',optp(root+1)
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
end if
call MPI_FINALIZE(IERR)

end program


