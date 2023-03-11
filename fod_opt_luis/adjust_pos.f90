subroutine adjust_pos(n,x,rad_max)
implicit none
integer,intent(in) :: n
real(8),intent(in) :: rad_max
real(8),intent(inout) :: x(n,3)
integer :: i
real(8) :: fact,dist

x(1,1)=0.0d0
x(1,2)=0.0d0
x(1,3)=0.0d0
do i=2,n
  dist=sqrt(x(i,1)**2+x(i,2)**2+x(i,3)**2)
  if(dist>rad_max) then
    fact=dist/rad_max
    x(i,1)=x(i,1)/fact
    x(i,2)=x(i,2)/fact
    x(i,3)=x(i,3)/fact
  endif
enddo
end subroutine adjust_pos
