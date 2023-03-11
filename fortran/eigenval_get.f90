program eigenvalue
implicit none

real(8), allocatable:: A(:,:), vr(:,:), vl(:,:),WI(:),WR(:), work(:)
integer:: n, i, j, lda, ldvr, ldvl, lwork, ierr, info,bol
character:: jobvl,jobvr

jobvl='N'


write(*,*) "Write the size of the matrix (n x n): "
read(*,*) n

write(*,*) "Do you wanna see the eigenvectors (1 for no, 2 for yes)?:"
read(*,*) bol

if ( bol .EQ. 2 ) then
        jobvr='V'
else 
        jobvr='N'
end if

allocate( A(n,n) )
allocate( vl(n,n) )
allocate( vr(n,n) )
allocate( WR(n) )
allocate( WI(n) )
allocate( work(1) )
do i=1, n
       do j=1, n     
       
       write(*,*) "capture the coefficient A (",i,",",j,")"
       read(*,*) A(i,j)
       end do
end do

write(*,*) "your matrix is :"
do i=1, n
        write(*,*) A(i,:)  
end do

LDA=n
LDVL=n
LDVR=n
lwork=-1

call dgeev(JOBVL,JOBVR,N,A,LDA,WR,WI,VL,LDVL,VR,LDVR,WORK,LWORK,INFO)

lwork = int( work(1) )
write(*,*) "workspace query is : ", lwork
deallocate(work)
allocate( work(lwork),stat=ierr )

call dgeev(JOBVL,JOBVR,N,A,LDA,WR,WI,VL,LDVL,VR,LDVR,WORK,LWORK,INFO)

write(*,*) "info=", info
write(*,*) "the eigenvalues of your matrix are: "
write(*,*) wr(:)


if (bol .EQ. 2 ) then
        write(*,*) "the eigen vectors are: "
        do i=1,n
        write(*,*) vr(i,:)
        end do
end if
      end program eigenvalue
