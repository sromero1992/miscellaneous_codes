program fod_modifier
implicit none
real(8),allocatable :: x(:,:)
real(8) :: r,dh
integer :: n, nup, ndn, i , j, k 

call system('cp FRMIDT FRMIDT.bak')
open(15,file='FRMIDT')
read(15,*) nup,ndn

n=nup+ndn
allocate(x(n,3))

do i =1,n
   read(15,*) x(i,1),x(i,2),x(i,3)
end do
close(15)

call srand( time() )
open(15,file='FRMIDT')
read(15,*) nup,ndn
dh = 0.5
do i =1,n
   r = norm2(x)
   x(i,1) =  x(i,1) + dh*2*(rand()-0.5)
   x(i,2) =  x(i,2) + dh*2*(rand()-0.5)
   x(i,3) =  x(i,3) + dh*2*(rand()-0.5)
   write(15,*) x(i,1),x(i,2),x(i,3)
end do

close(15)



end program
   
