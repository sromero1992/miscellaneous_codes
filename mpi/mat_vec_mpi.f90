program mat_vec
implicit none
include 'mpif.h'
integer,parameter ::  N = 1000 
real(8) :: X(N), Ax(N), Axi(N)
real(8), allocatable :: A(:,:)
integer :: i, j, k, ierr, npes, itask, root, nb, nb2 

!----------------Initializing MPI
call MPI_INIT(ierr)
!----------------Get number of processors npes
call MPI_COMM_SIZE(MPI_COMM_WORLD,npes,ierr)
!----------------Get "rank" or the label of each proc (0,1,..,npes-1)
call MPI_COMM_RANK(MPI_COMM_WORLD,itask,ierr)

!This is going to be my blocking
nb = N/npes

!This allocation works for A stored in columns
allocate( A(N , N/npes+1) )

!This allocation works for A stored in rows
!allocate( A(N/npes+1 , N) )

!Using allocate( A(N,N) ) it's a waste of space
!allocate( A(N,N) )


!Root proc
root = 0
X(:) = 0
A(:,:) = 0
if ( itask .EQ. npes-1) then
   nb2 = nb + (N -  nb*npes)
else 
   nb2 = nb
end if


!storing blocks of columns of matrix A 
do i = 1 , N 
!Storing block of rows of A and the vector X in each proc
!do i = 1 + itask*nb , itask*nb + nb2
  !do j = 1, N
   do j = 1 + itask*nb , itask*nb +nb2
!      A(i,j ) = i + j       
      A(i,j -itask*nb) = i + j    !begin for each processor at A(i,1)   
      if ( X(j) .EQ. 0) then
          X(j) = j      
      end if
   end do
end do




!Mat vec prod
Ax(:) = 0
Axi(:) = 0
do i = 1 , N 
!do i = 1 + itask*nb , ( 1 + itask)*nb
  !do j = 1, N
   do j = 1 + itask*nb , itask*nb + nb2
     Axi(i) = Axi(i) +A(i, j-itask*nb )*X(j)
   end do
end do

!  call MPI_ALLREDUCE(Axi,Ax,N,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,ierr)
   call MPI_REDUCE(Axi,Ax,N,MPI_DOUBLE_PRECISION,MPI_SUM,root,MPI_COMM_WORLD,ierr)
if(itask .EQ. root) then
!   write(*,*) 'The mat-vec product is : ' , Ax(:)
   write(*,*) 'Its magnitude is : ', norm2(Ax(:))
end if
!it also can be MPI_ALLREDUCE and have Ax in all the procs, not just in root

call MPI_FINALIZE(ierr)
end program
