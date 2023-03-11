program plotForce

 implicit none
 integer :: i,j !number of data
 real(8),  allocatable :: force(:)
 real(8),  allocatable :: pos(:)

 print *," capture the data number:"
 read (*,*) i

 allocate(force(i))
 allocate(pos(i))

 print *, "capture the data colection of forces:"

 do j=1,i
        read(*,*)  force(j)   
 end do

 print *, "capture the data colection of positions:"

 do j=1,i
        read (*,*) pos(j)
 end do

 open(1,FILE='fvpdata.txt')

 write (1,'(12X,A3,21X,A5)')"pos", "force"

 do j=1,i
        print *, force(j)
        write(1,*) pos(j),force(j)
 end do

 print *, "you captured values for positions are:"
 do j=1,i
        print *, pos(j)
 end do


 end program


