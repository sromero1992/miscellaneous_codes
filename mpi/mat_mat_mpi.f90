program mat_mat
implicit none
include 'mpif.h'
integer,parameter :: N = 1000
real(8) :: A(N,N), B(N,N), C(N,N)
real(8), allocatable :: A_temp(:,:), B_temp(:,:),Ci(:,:)
integer :: i, j, k, ierr, npes, itask, root, nb, nb2

!initialize mpi
call MPI_INIT(ierr)
!get number of procs npes
call MPI_COMM_SIZE(MPI_COMM_WORLD,npes,ierr)
!get "rank" or label of each proc. itask
call MPI_COMM_RANK(MPI_COMM_WORLD,itask,ierr)

!Declaration of variables 
allocate(A_temp(N,N))
allocate(B_temp(N,N))
allocate(Ci(N,N))
A(:,:) = 0
B(:,:) = 0
C(:,:) = 0
A_temp = A
B_temp = B
Ci = C

! Size of the block nb
nb = N/npes

!Root proc
root = 0
if ( itask .EQ. npes-1) then
   nb2 = nb + (N -  nb*npes)
else
   nb2 = nb
end if


!Storing block of rows of A 
do i = 1 + itask*nb , itask*nb + nb2
    do j = 1, N
      A_temp(i,j ) = i + j       
      B_temp(i,j ) = i + j
    end do
end do

call MPI_ALLREDUCE(A_temp,A,N*N,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,ierr)
call MPI_ALLREDUCE(B_temp,B,N*N,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,ierr)
deallocate(A_temp)
deallocate(B_temp)

do i = 1 + itask*nb , itask*nb + nb2
    do j = 1, N
        do k = 1, N
            Ci(i,j) = Ci(i,j) + A(i,k)*B(k,j) 
        end do
    end do
end do

call MPI_ALLREDUCE(Ci,C,N*N,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD,ierr)
deallocate(Ci)

if (itask .EQ. root) then
!write(*,*) 'The matrix AB = C is :'
do i = 1, N
!    write(*,*) C(i,:)
end do
write(*,*) ' The last component C(N,N) is : ',C(N,N)
end if

call MPI_FINALIZE(ierr)

end program
