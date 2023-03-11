subroutine swap(x1,x2)
 implicit none
 real(8), intent(inout):: x1,x2
 real(8):: a

 a=x1
 x1=x2
 x2=a

 return
end subroutine swap
