program hello_mpi

use mpi
        integer::id,nproc,err,bol
        real(8):: wtime
        !initialize mpi
        call MPI_Init( err )
        !get num. proc.
        call MPI_Comm_size( MPI_COMM_WORLD, nproc,err )
        call MPI_Comm_rank(MPI_COMM_WORLD, id, err )
        
        bol=-1
        if ( id .eq. 0) then
               
                write(*,'(a)') ''
                write(*,*) 'Proc Id:', id, 'Hello_mpi - master process: '
                write(*,*) 'fortran90/mpi version'
                write(*,'(a,i1,2x,a,i8)') 'Proc.' , id, '  The number of MPI processors is :' , nproc
        end if
        !every processor will write this message 
        if(id .eq. 0) then        
                write(*, '(a,i1,2x,a)') 'Master Proc.', id, "Says Hello world"  
        else 
                write(*, '(a,i1,2x,a)') 'Slave Proc.', id, "Says Hello world"  
        end if
       
        call MPI_BARRIER(MPI_COMM_WORLD,err)
        
        if(id .eq. 0) then
                write(*,*) 'End of the process by the master processor:', id
                write(*,*) ' Good-bye world'
                wtime = MPI_Wtime() -wtime
                write(*,*) 'The time elapsed from proc.',id, ' is ',&
                wtime,'seconds'
        end if
        !shut down MPI
        call MPI_Finalize( err )
end program


