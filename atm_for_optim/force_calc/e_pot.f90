subroutine for_pot(r(3),sig,ze1,ze2)
!this subroutine defines the potentials 
!and forces requiered for atoms-electrons clasically
!pot. Leonnard-jones, approx. the interaction between pair of 
!2 neutral atoms or molecules
implicit none
real(8)::sig,r(3),eps,vlj,vmor
integer::c
eps=1
!Choices of potentials 1=Leonnard Jones; 2=Morse ; 3=Many body pot
write(*,*) ' The potential choices are '
write(*,*) ' 1 = Leonnard Jones '
write(*,*) ' 2 = Morse '
write(*,*) ' 3 = Many body pot (coulomb for prot and e) '

100 write(*,*) 'Choose your potential : '
read(*,*) c
if(c .EQ. 1) then
vlj(r,sig)
else if (c .EQ.2) then
vmor(r)
else if(c .EQ. 3) then
!make subroutine for this in a script
call ep_pot(r(3),ze1,ze2)
else
write(*,*) 'That is not a choice '
goto 100
end if






end subroutine


function vlj(r(3),sig)
implicit none
real(8)::r(3),vlj,rmag,eps,sig

rmag=norm2(r)
vlj= 4*eps* ((sig/rmag)**12-(sig/rmag)**6)

return
end function

function vmor(r(3))
implicit none
real(8)::r,vmor,de,a,re,rmag,rdif
re= !bond distance
de= !equilibrium bound energy
rmag=norm2(r)
rdif=rmag-rc
vmor=de*(exp(-2*a*rdif)-2*exp(-a*rdiff))

return
end function
