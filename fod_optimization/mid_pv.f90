program mid_pv
implicit none
real(8),allocatable::X(:,:),X_mp(:,:)
real(8)::X_temp(3),dum,X_mpT(3),dz
integer::ios,i,k,j,N,dn,up
N=0
open(5,file='FRMIDT')
do i=1,30
        read(5,*,iostat = ios) dum
        if (ios .GT. 0 ) then
                write(*,*) 'Error reading file, try it again ',ios 
                exit
        else if (ios .EQ. 0 ) then
                N = N + 1
        else   
                exit
        end if
end do
close(5)
N = N - 1
allocate(X(N,3))
allocate(X_mp(N-1,3))!N -1 distances

open(5,file = 'FRMIDT')
read(5,*) up , dn
do i = 1, N
        read(5,*,iostat=ios) (X(i,j),j=1,3)
end do
close(5)
!I will suppose that X(1,3) it's the biggest atom and the center
!I must have the optimum positions for the atoms in SYMBOL file
!in the same line that joint the two atoms
do i=1,N-1
        X_mp(i,:) =( X(i+1,:) + X(1,:))*0.5
end do
!a point normal to all the other FOD plane

X_mpT(:) = 0
do i=1,N-1
        X_mpT(:) = X_mpT(:) + X_mp(i,:) 
end do

write(*,*) 'mid point of the triangle :',X_mpT(:)/3
!mid point position of a triangle by -2
X_mpT = (X_mpT/3 )
dz= X(1,3) - X_mpT(3) 
if ( dz .NE. 0) then !Reflection in Z 
    X_mpT(3) = X(1,3) +dz
end if
open(10,file = 'FRMIDT2')
write(10,*) up,dn

do i=1,2
write(10,*) (X(1,k),k=1,3)
do j=1,N-1
        write(10,*) (X_mp(j,k),k=1,3)
end do
write(10,*) (X_mpT(k),k=1,3)
end do

end program
