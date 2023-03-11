program fod_position
implicit none
real(8),allocatable::X(:,:),XF(:,:),rad(:),XN(:,:)
real(8)::radii,dum,dx(3)
integer::ierr,ios,AtmN,Sup,Sdn,i,j,k,N
character::dumc
!Initial positions in cluster for the atoms
open(5,file='CLUSTER')
read(5,*,iostat=ios) dumc
read(5,*,iostat=ios) dumc
read(5,*,iostat=ios) AtmN
allocate(X(AtmN,3))
do i=1,AtmN
    read(5,*,iostat=ios) (X(i,j),j=1,3)
!    write(*,*) 'Atom position ',i,' is :',X(i,:)
end do
close(5)
!Those positions are the first position FOD and translate all to
!For this case Fe FOD given in test26 directory with FRMIDT

! X(N,3) represents the vector position of electron n.
N=0
!Reading to count data (No. electron descriptors)
open(10,file='FRMIDT-Fe')
do k=1,30
    read(10,*,iostat=ios) dum
    if(ios .GT. 0) then
      write(*,*) 'Error reading the file',ios
      exit
    else if(ios .EQ. 0) then
      N=N+1
    else
      exit
    end if
end do
close(10)

N=N-1 !Number of FOD's
allocate(XF(N,3))
!Reading fermi descriptors
open(10,file='FRMIDT-Fe')
read(10,*) Sup,Sdn
do i=1,N
   read(10,*) (XF(i,j),j=1,3)
!   write(*,*)'FOD position ',i,' :', XF(i,:)
end do
close(10)
dx=X(1,:)-XF(1,:)
write(*,*) 'Position of Fe : ',X(1,:)
write(*,*) 'Position of first FOD : ',XF(1,:)
write(*,*) 'Distance change in base FOD is : ',dx


allocate(XN(N,3))
do i=1,N
  XN(i,:)=XF(i,:)+dx ! New positions
end do


open(15,file='FRMIDT')
write(15,*) Sup+1,Sdn! 1 for the hydrogen
write(15,*) X(2,:)
do i=1,N
   write(15,*) (XN(i,j),j=1,3)
end do
close(15)



end program
