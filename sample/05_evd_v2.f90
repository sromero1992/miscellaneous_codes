! Diagonalization sample
!
! Compile with gfortran 05_evd.f90 -lblas -llapack
!
program evd
implicit none
real(8),allocatable :: work(:),a(:,:),eig(:)
character :: jobz,uplo
integer :: info,lwork
integer :: lda,n,ierr
jobz='N'
uplo='U'

allocate(a(3,3))
allocate(eig(3))
allocate(WORK(1));
a(1,1)=1.0
a(1,2)=2.0
a(1,3)=0.0
a(2,1)=-2.0
a(2,2)=1.0
a(2,3)=2.0
a(3,1)=1.0
a(3,2)=3.0
a(3,3)=1.0
n=3
lda=3
LWORk=-1
CALL DSYEV( JOBZ, UPLO, N, a, LDA, Eig,&
              WORK, LWORK, INFO )
LWORK= INT(WORK(1))
write(6,*)'from work query',LWORK
deallocate(work)
allocate(WORK(LWORK),STAT=ierr)
CALL DSYEV( JOBZ, UPLO, N, a, LDA, Eig,&
              WORK, LWORK, INFO )
write(6,*)'info=',info
write(6,*)'eig=',eig
!write(6,*)'vect=',a
! Homework.- get an overlap matrix from NRLMOL
end program evd
