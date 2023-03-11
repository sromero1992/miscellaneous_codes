subroutine print_max_f(n,f)
implicit none
integer,intent(in) :: n
real(8),intent(in) :: f(n,3)
real(8) :: max_f,temp
integer :: i

max_f=0.0d0
do i=1,n
  temp=sqrt(f(i,1)**2+f(i,2)**2+f(i,3)**2)
  if(temp>max_f) max_f=temp
enddo
write(19,*)max_f
call flush(19)
return
end subroutine print_max_f
