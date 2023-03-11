program geo_opt

implicit none

real(8) :: pi, dh, err, realrad, pot, optp, rad(4)
real(8), dimension(:,:), allocatable :: R, D, Rop, Dop
real(8), dimension(:), allocatable :: X, Y, Z, th, ph, phold,thold
integer, allocatable :: N_elec_atom(:,:)
integer :: i, j, k, m, ios, coun, N, coun2, Nup, Ndn, AN, Nlim, Nshell(3),Nloop

!N -> No. of electrons
!Nup -> No. of spin up electrons
!Ndn -> No. of spin down electrons
!R -> position of electron Ni,3d
!rad -> radius of the shell
!D -> distance

pi = 4.d0 * atan(1.d0)

open(20,file = 'FOD_INPUT.DAT')
read(20,*) AN
read(20,*) Nup, Ndn 
close(20)
<<<<<<< HEAD
AN = 1
N = Nup + Ndn 
!Take out core electrons
N = N -  AN*2
=======

Nshell(1) = 2 !Up to Helium
Nshell(2) = 16 !Up to Argon
Nshell(3) = 38 !Up to rate earths
N = Nup + Ndn

if (N .GT. Nshell(1) ) then 
N = N-2*AN !Taking out the core electrons, at the center
end if

>>>>>>> 35ba2f21dbfe4a8d685dd4eee8304ea0325b5d4c
!Allocation of the arrrays
allocate( N_elec_atom( N ,2 )) ! N(No. elec , atom label)
allocate( R(N,3) )
allocate( Rop(N,3) )
allocate( D( N*(N-1)/2 ,3) )
allocate( Dop( N*(N-1)/2 ,3) )
allocate( X(N) )
allocate( Y(N) )
allocate( Z(N) )
allocate( th(N) )
allocate( ph(N) )
allocate( phold(N) )
allocate( thold(N) )


!Radius of the shells, the center is out of the shells
rad(1) = 0.75
rad(2) = 1.00
rad(3) = 1.75
rad(4) = 2.50
dh = 1 !initial step size
R(:,:) = 0.0d0
Rop(:,:) = 100.0d0 !optimum positions
optp = 10000.0d0 !optimum potential
Dop(:,:) = 0.0d0 !Optimum distance
thold(:) = 0.0d0
phold(:) = 0.0d0
coun = 0
coun2 =  0
!Begin of the monte carlo
call srand( time() )

!Giving random initial positions
<<<<<<< HEAD

!call get_R(R,rad(3),th,thold,ph,phold,pi,N,dh)
! Go from spin 2 to Nup to let the inner core electrons
call get_R( R( 1+AN:Nup ,:), rad(3), th( 1+AN:Nup), &
            thold( 1+AN:Nup), ph( 1+AN:Nup), phold( 1+AN:Nup), pi, Nup-1, dh)
! Go from spin Nup
call get_R( R( Nup+AN+2:N ,:), rad(3), th( Nup+AN+), &
            thold( Nup+AN+2:N ), ph(Nup+AN+2:N ), phold(Nup+AN+2:N ), pi, Ndn-1, dh)
!do i = 1, N
!  write(*,*) R(i,:)
!end do
     


=======
if (Nup .EQ. Ndn) then !Symetric FODs
   Nlim = N/2
   !Just do half and replicate
   if (N .LE. Nshell(2)/2 ) then
      call get_R( R(1:Nlim,:), rad(2),th(1:Nlim),thold(1:Nlim),ph(1:Nlim),phold(1:Nlim),pi,Nlim,dh) 
   else
      ! if it is symetricaly N is even   here call by spin up and dn 
      call get_R( R(1:Nshell(2)/2,:), rad(2),th(1:Nshell(2)/2),thold(1:Nshell(2)/2),&
      ph(1:Nshell(2)/2) ,phold(1:Nshell(2)/2),pi,Nshell(2)/2,dh) 

      call get_R( R( Nshell(2)/2+1:Nlim/2,: ), rad(3),th(Nshell(2)/2+1:Nlim/2),&
      thold(Nshell(2)/2+1:Nlim/2), ph(Nshell(2)/2+1:Nlim/2), &
      phold(Nshell(2)/2+1:Nlim/2), pi,(Nlim-Nshell(2))/2,dh)
   end if
else
   !Initialize all positions 1:Nup are the spin up electrons
   if (N .LE. Nshell(2) ) then
       call get_R( R, rad(2),th,thold,ph,phold,pi,N,dh) 
   else 
       call get_R( R(1:Nshell(2),:), rad(2),th(1:Nshell(2)),thold(1:Nshell(2)),ph(1:Nshell(2)),& 
        phold(1:Nshell(2)),pi,Nshell(2),dh) 

       call get_R( R(Nshell(2)+1:N,:), rad(3),th(Nshell(2)+1:N),thold(Nshell(2)+1:N), &
        ph(Nshell(2)+1:N) ,phold(Nshell(2)+1:N),pi,N-Nshell(2),dh) 
   
   end if
end if
>>>>>>> 35ba2f21dbfe4a8d685dd4eee8304ea0325b5d4c

do m = 1,5000
   pot = 0
   k = 0
   D(:,:) = 10000
   if (Nup .EQ. Ndn) then
     Nloop = Nlim
   else
     Nloop = N
   end if 
   do i=1,Nloop-1
        do j = i+1, Nloop
        !try to get the distance for spin ups, 1:Nup-1 (one core elec) and the other Nup:N
                k = k+1 
                D(k,:) = R(j,:) - R(i,:)!D(1,:) is the difference between 2 and 1
                pot = pot + 1/norm2( D(k,:) )
        end do
   end do
   !Testing if the potential improves
   if (pot .LT. optp) then
        optp = pot
        !Dop = D
        Rop = R
        thold = th
        phold = ph
        coun2 = 0
       !write(*,*) 'The potential improved is : ',pot,' at iter ',m 
   else
        coun2 = coun2 + 1
        coun = coun + 1
        if (coun .GE. 10) then
            dh = dh*0.80
            coun = 0
        end if
  end if
! stoping criteria
  if (coun2 .GE. 300) then
      write(*,*) ' No improvement reached, exit at iter ',m
      exit
  end if
  if (Nup .EQ. Ndn) then !Symetric FODs
    Nlim = N/2
     !Just do half and replicate
     if (N .LE. Nshell(2)/2 ) then
       call get_R( R(1:Nlim,:), rad(2),th(1:Nlim),thold(1:Nlim),ph(1:Nlim),phold(1:Nlim),pi,Nlim,dh) 
     else
       ! if it is symetricaly N is even   here call by spin up and dn 
       call get_R( R(1:Nshell(2)/2,:), rad(2),th(1:Nshell(2)/2),thold(1:Nshell(2)/2),&
       ph(1:Nshell(2)/2) ,phold(1:Nshell(2)/2),pi,Nshell(2)/2,dh) 

       call get_R( R( Nshell(2)/2+1:Nlim/2,: ), rad(3),th(Nshell(2)/2+1:Nlim/2),&
       thold(Nshell(2)/2+1:Nlim/2), ph(Nshell(2)/2+1:Nlim/2), &
       phold(Nshell(2)/2+1:Nlim/2), pi,(Nlim-Nshell(2))/2,dh)
     end if
  else
   !Initialize all positions 1:Nup are the spin up electrons
     if (N .LE. Nshell(2) ) then
       call get_R( R, rad(2),th,thold,ph,phold,pi,N,dh) 
     else 
       call get_R( R(1:Nshell(2),:), rad(2),th(1:Nshell(2)),thold(1:Nshell(2)),ph(1:Nshell(2)),& 
        phold(1:Nshell(2)),pi,Nshell(2),dh) 

       call get_R( R(Nshell(2)+1:N,:), rad(3),th(Nshell(2)+1:N),thold(Nshell(2)+1:N), &
        ph(Nshell(2)+1:N) ,phold(Nshell(2)+1:N),pi,N-Nshell(2),dh) 
   
     end if
  end if

end do

!Symmetry applied to FODs
if (Nup .EQ. Ndn) then
   Rop(Nlim+1:N,:) = Rop(1:Nlim,:)
end if




write(*,*) 'The optimal potential is : ',optp
write(*,*) ' Iteration No. : ',m
write(*,*) 'The set of optimal positions (no core electrons)  are : '
do m = 1, N 
        write(*,*) Rop(m,:)
end do 

open(15,file = 'FRMIDT')! ,access = 'append')
write(15,*) Nup, Ndn
open(10,file = 'plot.xyz')
write(10,*,iostat=ios) N+2 !Nup
write(10,*,iostat=ios) 'plot points '

do m = 1, N + 2 !Nup
        !write(*,*) Rop(m,:)
        if (m .EQ. 1) then
           write(10,*,iostat=ios) 'H',0.0000,0.0000,0.0000,0.2
           write(15,*,iostat=ios) 0.000,0.000,0.000
        else if( m .EQ. Nup+1 ) then
           write(10,*,iostat=ios) 'X',0.0000,0.0000,0.0000,0.2
           write(15,*,iostat=ios) 0.000,0.000,0.000
        end if
        if ( ( m .GT. 1) .AND. (m .LE. Nup )) then
          write(10,*,iostat=ios) 'H',Rop(m-1,1),Rop(m-1,2),Rop(m-1,3),0.2
          write(15,*,iostat=ios)  Rop(m-1,1),Rop(m-1,2),Rop(m-1,3)
        else if ( m .GT. (Nup+1) ) then 
          write(10,*,iostat=ios)  'X',Rop(m-2,1),Rop(m-2,2),Rop(m-2,3),0.2
          write(15,*,iostat=ios)  Rop(m-2,1),Rop(m-2,2),Rop(m-2,3)
        end if
end do
close(10)
close(15) 

call system('jmol plot.xyz')
end program


!#############################################################


subroutine get_R( V_pos, radii, th_get, thold_get, ph_get, phold_get, pi, N_get, dh)
real(8) :: radii, pi, dh, thold_get(N_get), phold_get(N_get)
real(8) :: V_pos(N_get,3), th_get(N_get), ph_get(N_get)

do i = 1,N_get
    th_get(i) = thold_get(i) + pi*(rand()-0.5)*2*dh
    ph_get(i) = phold_get(i) + 2*pi*(rand()-0.5)*2*dh
    !These are X,Y and Z positions
    V_pos(i,1) = radii*sin(th_get(i))*cos(ph_get(i))
    V_pos(i,2) = radii*sin(th_get(i))*sin(ph_get(i))
    V_pos(i,3) = radii*cos(th_get(i))
end do

end subroutine
