program example
use mpi
implicit none
integer,parameter::N=7
integer:: sendbuf(N),recbuf(N,10),backbuf(N),i,j,root,npes,idproc,ierr
!initializing mpi
call MPI_INIT(IERR)
!Number of procs =NPES
call MPI_COMM_SIZE(MPI_COMM_WORLD,NPES,IERR)
!Processor number = ITASK for me IDPROC
call MPI_COMM_RANK(MPI_COMM_WORLD,IDPROC,IERR)
		!On proc #0 SENDBUF =  1  2  3  4  5  6  7 
		!        #1 SENDBUF = 11 12 13 14 15 16 17
		!        #2 SENDBUF = 21 22 23 24 25 26 27
		!        #3 SENDBUF = 31 32 33 34 35 36 37

do i=1,N
	SENDBUF(i) = 10*idproc+i
end do

! Now let's gather the information of sendbuf on all procs
! to recbuf on proc root
root=0
call MPI_GATHER(SENDBUF,N,MPI_INTEGER,RECBUF,N,MPI_INTEGER,ROOT,MPI_COMM_WORLD,IERR)
!               sender #data  type  reciever #data type  proc/recieve   statik quantities
if(idproc .eq. root) then
	write(*,*) "MPI_GATHER",idproc, "PROC","       CONTENT     "
	do i=1,npes
		write(*,*) (recbuf(j,i),j=1,N)
	end do
end if

call MPI_BARRIER(MPI_COMM_WORLD,IERR)
!sCATTER DATA FROM RECBUF ON PROC ROOT BACK TO BACKBUF ON ALL PROCS
call MPI_SCATTER(RECBUF,N,MPI_INTEGER,BACKBUF,N,MPI_INTEGER,ROOT,MPI_COMM_WORLD,IERR)
write(*,*) "MPI_SCATTER", idproc,"PROC ","     CONTENT",backbuf

call MPI_BARRIER(MPI_COMM_WORLD,IERR)
!Now add data from each proc's sendbuf(I) together and save backbuf on root
call MPI_REDUCE(SENDBUF,BACKBUF,N,MPI_INTEGER,MPI_SUM,ROOT,MPI_COMM_WORLD,IERR)
if(idproc .eq. root) then
	write(*,*) "MPI_REDUCE", IDPROC,"PROC ","    CONTENT",BACKBUF
end if

call MPI_BARRIER(MPI_COMM_WORLD,IERR)
!Send data from sendbuf on proc root to sendbuf on all procs
call MPI_ALLREDUCE(SENDBUF,BACKBUF,N,MPI_INTEGER,MPI_SUM,MPI_COMM_WORLD,IERR)
write(*,*) "MPI_ALLREDUCE",IDPROC,"PROC ","    CONTENT",BACKBUF
call MPI_BARRIER(MPI_COMM_WORLD,IERR)

call MPI_BCAST(SENDBUF,N,MPI_INTEGER,ROOT,MPI_COMM_WORLD,IERR)
call MPI_BARRIER(MPI_COMM_WORLD,IERR)

write(*,*) "MPI_BCAST", idproc,"PROC ","    CONTENT",sendbuf
call MPI_FINALIZE(IERR)
end program

