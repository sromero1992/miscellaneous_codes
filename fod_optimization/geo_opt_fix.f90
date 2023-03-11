program geo_opt
implicit none
integer,parameter::N = 7,AN = 1 
real(8)::R(N,3),rad,X(N),Y(N),Z(N),pi,D(N*(N-1)/2,3),th(N),ph(N),dh,Rfix(AN-1,3),Rinit(AN,3)
real(8)::pot,optp,Rop(N,3),Dop(N*(N-1)/2,3),phold(N),thold(N),err,realrad,Dfix(N*AN,3),R_0(3)
real(8) :: R_elec_ref(3),d_fix
integer::i,j,k,m,ios,coun, coun2, dum
pi=4.d0*atan(1.d0)
R_0(1) = 0.000030 
R_0(2) = 0.000035
R_0(3) = -0.533754
R_elec_ref(1) = -0.000032  
R_elec_ref(2) = -0.000032
R_elec_ref(2) = 2.333701

!N -> No. of electrons
!R -> position of electron Ni,3d
!rad -> radius of the shell
!D -> distance

dh = 1!Step size
realrad = 1
!r1=0   r2=0.5   r3=1.0   r4=4.66
rad = 1
Rop(:,:) = rad!optimum positions
optp = 10000!optimum potential
Dop(:,:) = 0!Optimum distance
thold(:) = 0
phold(:) = 0
coun = 0
coun = 0
coun2 =  0
!Begin of the monte carlo
call srand( time() )

!Giving random initial positions
call get_R(R,rad,th,thold,ph,phold,pi,N,dh)


!Placing statik valence electros
!open(10,file = 'FRMIDT3')
!read(10,*,iostat=ios) dum !dummy for spins
!do i=1,AN
!     read(10,*,iostat=ios) (Rinit(i,j),j=1,3)
!end do
!close(10)

!Calculating atomic positions
!do j = 2, AN
!Rfix(j-1,:)= Rinit(j,:) - Rinit(1,:) 
!end do

do m=1,5000
pot = 0
k = 0
D(:,:) = 0

!Potential for all the not repeated interaction
do i=1,n-1
        do j=i+1,n
                k=k+1
                d(k,:)=r(j,:)-r(i,:)!d(1,:) is the difference between 2 and 1
                                    !d(2,:) is the difference between 3 and 1
                pot=pot+1/norm2(d(k,:))
        end do
end do
do i=1,n
                d_fix = r(i,:)-R_elec_ref(:)
                pot=pot+1/norm2(d_fix)
        end do
end do


!Potential addition to a fixed charge
!k=0
!do j=1,AN-1
!    do i=1,N
!         k=k+1
!         Dfix(k,:) = R(i,:) -Rfix(j,:)
!         pot=pot+1/norm2(Dfix(k,:)) 
!    end do
!end do

!Testing if the potential improves
if (pot .LT. optp) then
        optp = pot
        Dop = D
        Rop = R
        thold = th
        phold = ph
        coun2 = 0
!        write(*,*) 'The potential improved is : ',pot,' at iter ',m 
else
        coun2 = coun2 + 1
        coun = coun + 1
        if (coun .GE. 10) then
            dh = dh*0.80
            coun = 0
        end if
end if
! stoping criteria

if (coun2 .GE. 350) then
      write(*,*) ' No improvement reached, exit at iter ',m
      exit
end if


call get_R(R,rad,th,thold,ph,phold,pi,N,dh)
end do

do i=1,N
    Rop(i,:) = Rop(i,:) + R_0(:)!+Rinit(1,:)
end do

write(*,*) 'The optimal potential is : ',optp
write(*,*) ' Iteration No. : ',m
write(*,*) 'The set of optimal positions are : '
open(10,file = 'plot.xyz')
open(15,file = 'FRMIDT2')!,access ='append')
write(10,*,iostat=ios) N+AN-1
write(10,*,iostat=ios) 'plot points '
do m=1,N
        write(*,*) Rop(m,:)
        write(10,*,iostat=ios) 'X',Rop(m,1),Rop(m,2),Rop(m,3),0.2
        write(15,*,iostat=ios) Rop(m,1)*realrad,Rop(m,2)*realrad,Rop(m,3)*realrad
end do
!Translating again the position
do j=2, AN
        write(10,*,iostat=ios) 'X',Rinit(j,1),Rinit(j,2),Rinit(j,3),0.2
end do
!       write(15,*,iostat=ios) Rfix(1),Rfix(2),Rfix(3)
close(10)
close(15)
 

call system('jmol plot.xyz')
end program

!#############################################################


subroutine get_R(X,rad,th,thold,ph,phold,pi,N,dh)
real(8)::rad,pi,dh,thold(N),phold(N)
real(8)::X(N,3),th(N),ph(N)

do i=1,N
    th(i) = thold(i) + pi*(rand()-0.5)*2*dh
    ph(i) = phold(i) + 2*pi*(rand()-0.5)*2*dh
    !These are X,Y and Z positions
    X(i,1) = rad*sin(th(i))*cos(ph(i))
    X(i,2) = rad*sin(th(i))*sin(ph(i))
    X(i,3) = rad*cos(th(i))
end do

end subroutine

