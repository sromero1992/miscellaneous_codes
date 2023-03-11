real(8) function calc_energy(n,x)
implicit none
integer,intent(in) :: n
real(8),intent(in) :: x(n,3)
integer :: i,j,k
real(8) :: temp,dist_final
real(8) :: dist_ij(3)
temp=0.0d0
do i=1,n
  do j=1,n
    if(i/=j) then
      dist_ij=0
      do k=1,3
        dist_ij(k)=dist_ij(k)+abs(x(i,k)-x(j,k))
      enddo
      dist_final=sqrt(dist_ij(1)**2+dist_ij(2)**2+dist_ij(3)**2)
      if(dist_final/=0.0d0) then
        temp=temp+1.0/dist_final
      endif
    endif
  enddo
enddo
calc_energy=temp
return
end function calc_energy

