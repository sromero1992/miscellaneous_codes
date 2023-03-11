subroutine calc_forces(n,x,f)
implicit none
integer,intent(in) :: n
real(8),intent(in) :: x(n,3)
real(8),intent(inout) :: f(n,3)
integer :: i,j,k
real(8) :: temp

f=0.0d0
do i=1,n
  do j=1,n
    if(i/=j) then
      do k=1,3
        temp=(x(i,k)-x(j,k))**2
        if(temp==0.0d0) then
          f(i,k)=f(i,k)+0.0d0
        else
          f(i,k)=f(i,k)+1.0/temp
        endif
      enddo
    endif
  enddo
enddo
end subroutine calc_forces

