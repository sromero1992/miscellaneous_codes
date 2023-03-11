subroutine subst(e,r,t)
implicit none
real(8),intent(in) :: e
real(8),intent(in) :: r
real(8),intent(out) :: t

t=e-r
return
end subroutine subst
