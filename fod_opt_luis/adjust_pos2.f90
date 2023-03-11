subroutine adjust_pos2(n,x,force,rad_max)
implicit none
integer,intent(in) :: n
real(8),intent(in) :: rad_max
real(8),intent(inout) :: x(n,3)
real(8),intent(in) :: force(n,3)
integer :: i
real(8) :: fact,dist

fact=1.00
do i=1,n
  write(18,*)'force',i,force(i,1),force(i,2),force(i,3)
  x(i,1)=x(i,1)+x(i,1)*force(i,1)*fact
  x(i,2)=x(i,2)+x(i,2)*force(i,2)*fact
  x(i,3)=x(i,3)+x(i,3)*force(i,3)*fact
enddo
do i=1,n
  dist=sqrt(x(i,1)**2+x(i,2)**2+x(i,3)**2)
  if(dist>rad_max) then
    fact=dist/rad_max
    x(i,1)=x(i,1)/fact
    x(i,2)=x(i,2)/fact
    x(i,3)=x(i,3)/fact
  endif
enddo
end subroutine adjust_pos2
