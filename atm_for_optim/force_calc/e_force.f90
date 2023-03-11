program e_force

implicit none
real(8), allocatable :: p(:,:), q(:), e_f(:), r(:), p_vec(:,:), v_ef(:,:), u_vec(:,:)
real(8) ::p_cent(3), f_tot(3)
integer :: i,j,k,n,cent,n_q


call r_info(p,q,p_vec,u_vec,n_q,cent,p_cent)

allocate (r(n_q-1))
allocate (e_f(n_q-1))
 


write(*,*) ' Reminding you, the center is : ',p_cent(1:3)
write(*,*) ' The set of distances, charges and respective vectors are :'
!Vector distance

k=0
do i=1,n_q
        if( norm2(p(i,1:3)-p_cent(1:3)) .NE. 0) then
                k=k+1
                write(*,*) (p(i,1:3))
                r(i) = norm2(p(i,1:3)-p_cent(1:3))
                write(*,*) r(i), ' Distance ', k
                write (*,*) q(i), ' Charge ', i
        else
                write(*,*) p(i,1:3), ' (Central position)'
                write(*,*) q(i), ' (Central charge)'
                cent=i ! central index
        end if
end do 


write(*,*) 'The only force here is the Coulomb force between charged particles '


!magnitude of the forces
j=0
do i=1,n_q
        if (i .NE. cent ) then
                j=j+1
                e_f(j)=q(cent)*q(i)/r(i)**2
        end if
end do

!vector positions
j=0
do i=1,n
        if (i .NE. cent) then
        j=j+1
        p_vec(j,1:3) = p(i,1:3) - p_cent(1:3)
        write(*,*) 'Position vector (',j ,') is : ' ,p_vec(j,1:3) 
        u_vec(j,1:3) = p_vec(j,1:3)/norm2(p_vec(j,1:3))
        write(*,*) ' Unitary vector (',j,') is : ', u_vec(j,1:3)
        end if
end do

write(*,*) 'The magnitude forces are :'
do i=1,n-1
       write(*,*) 'Magnitude ', i, ' is : ',  e_f(i)
       v_ef(i,1:3)=e_f(i)*u_vec(i,1:3)
       write(*,*) 'Vector force ', i , ' is : ', v_ef(i,1:3)
end do


!net force
f_tot(1:3)=0
do i=1,n-1
        f_tot(1:3)=f_tot(1:3) + v_ef(i,1:3)
end do 

write(*,*) 'The net force is : ', f_tot(1:3)

end program


