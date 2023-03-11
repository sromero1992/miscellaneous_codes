program radii
implicit none
real(8),allocatable::X(:,:),R(:),Shell(:)
real(8)::dum,rerr
integer::i,j,k,l,ios,N,Sup,Sdn
character(3)::sh
! X(N,3) represents the vector position of electron n.
N=0
!Reading to count data (No. electron descriptors)
open(5,file='FRMIDT')
 do k=1,30
   read(5,*,iostat=ios) dum
   if(ios .GT. 0) then
     write(*,*) 'Error reading the file',ios
     exit
   else if(ios .EQ. 0) then 
     N=N+1 
   else
     exit
   end if
 end do
close(5)

N=N-1
write(*,*) 'Number of Fermi descriptors are :',N
allocate(X(N,3))
allocate(R(N))
allocate(Shell(N))

!Reading data for the subroutine (spins and positions)
open(5,file='FRMIDT')
read(5,*) Sup,Sdn
do i=1,N
  read(5,*) (X(i,j),j=1,3)
end do
close(5)
!To check if we are reading the whole info
write(*,*) '***********Checking input************ '
write(*,*) Sup,Sdn
do i=1,N
   write(*,*) X(i,:)
end do

!Calculate the shell radiusi
write(*,*)'*******Radius for the above IDF****** '
do i=1,N
  R(i)=NORM2(X(i,:))
  write(*,*) R(i)
end do

!display the owned shells for each position/"electron"
write(*,*)'***Shells for the Fermi descriotors*** '
Shell(1)=1
do i=1,N
   do j=i+1,N
      rerr=R(i)*0.1

        if(j .EQ. Sup+1) then
            Shell(j)=1
        else if( R(j) .GE. R(i)+rerr) then
            Shell(j)=Shell(i)+1
        else 
            Shell(j)=Shell(i)
        end if
   end do
end do

do i=1,N
   if(Shell(i) .EQ. 1) then
      sh=' s '
   else if (Shell(i) .EQ. 2) then
      sh=' p '
   else if (Shell(i) .EQ. 3) then
      sh=' d '
   else if (Shell(i) .EQ. 4) then
      sh=' f '
   end if
   write(*,*) 'Fermi descriptor ',i,' with radius ',R(i),' has Shell ',sh
end do

end program radii
