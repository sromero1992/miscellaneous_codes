program eforce

implicit none
real(8), allocatable :: v(:,:), q(:), ef(:), r(:), p_vec(:,:), vf(:,:), u_vec(:,:)
real(8) ::p_netf(3), f_tot(3)
integer :: i,j,k,n,p,cent

write(*,*) 'Enter the number of charged particles : '
read(*,*) n
allocate(q(n))
allocate(v(n,3))
allocate(p_vec(n-1,3))
allocate(u_vec(n-1,3))
! This looks fine for Electric field
!write(*,*) 'Is any of those particles the position to measure the net force? (y=1,n=0) : '
!read(*,*) p

!if (p .EQ. 1) then
!        n=n-1
!end if

allocate (r(n-1))
allocate (ef(n-1))
allocate (vf(n-1,3))

write(*,*) 'Write the position to measure the net force :'
read(*,*) (p_netf(i),i=1,3)

do i=1,n
        write(*,*) 'Write the position of particle ', i , ' particles (in sets of 3): '
        read(*,*) (v(i,j),j=1,3)
        write(*,*) 'Write the charge of particle ', i
        read(*,*) q(i)
end do



write(*,*) ' Reminding you, the center is : ',p_netf(1:3)
write(*,*) ' The set of distances, charges and respective vectors are :'
!Vector distance


k=0
do i=1,n
        if( norm2(v(i,1:3)-p_netf(1:3)) .NE. 0) then
                k=k+1
                write(*,*) (v(i,1:3))
                r(i) = norm2(v(i,1:3)-p_netf(1:3))
                write(*,*) r(i), ' Distance ', k
                write (*,*) q(i), ' Charge ', i
        else
                write(*,*) v(i,1:3), ' (Central position)'
                !The central charge is
                write(*,*) q(i), ' (Central charge)'
                cent=i
        end if
end do 


write(*,*) 'The only force here is the Coulomb force between charged particles '


!magnitude of the forces
j=0
do i=1,n
        if (i .NE. cent ) then
                j=j+1
                ef(j)=q(cent)*q(i)/r(i)**2
        end if
end do

!vector positions
j=0
do i=1,n
        if (i .NE. cent) then
        j=j+1
        p_vec(j,1:3) = v(i,1:3) - p_netf(1:3)
        write(*,*) 'Position vector is : ' ,p_vec(j,1:3) 
        u_vec(j,1:3) = p_vec(j,1:3)/norm2(p_vec(j,1:3))
        write(*,*) ' Unitary vector is : ', u_vec(j,1:3)
        end if
end do

write(*,*) 'The magnitude forces are :'
do i=1,n-1
       write(*,*) 'Magnitude ', i, ' is : ',  ef(i)
       vf(i,1:3)=ef(i)*u_vec(i,1:3)
       write(*,*) 'Vector foce ', i , ' is : ', vf(i,1:3)
end do


!net force
f_tot(1:3)=0
do i=1,n-1
        f_tot(1:3)=f_tot(1:3) + vf(i,1:3)
end do 

write(*,*) 'The net force is : ', f_tot(1:3)

end program

