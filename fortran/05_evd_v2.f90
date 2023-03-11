! Diagonalization sample
!
! Compile with gfortran 05_evd.f90 -lblas -llapack
!
program evd
implicit none
real(8),allocatable :: dh,work(:),a(:,:),eig(:),eig2(:), eigt(:),dat(:),dat2(:),m_dat(:,:),m_dat2(:,:), vl(:), vr(:)
character :: jobvl,jobvr,uplo
integer :: info,lwork
integer :: lda,ldb,ldvl,ldvr,n,ierr,i,j,k
integer :: ndh, ndh_tot, ndh_tot2, ispn
jobvl='N'
jobvr='N'

!Reading OVLBABY file

open(91, file='OVLBABY', form='unformatted')
read(91) ndh_tot
allocate( dat(ndh_tot) )
read(91) ( dat(k), k=1, ndh_tot)
close(91)

!Reading an HAMOLD file

open(92, file='HAMOLD', form='unformatted')
read(92) ndh_tot2,ispn
allocate( dat2(ndh_tot2))
read(92) (dat2(k),k=1, ndh_tot2)
close(92)

if ( ndh_tot .NE. ndh_tot2) then
       write(*,*) "The size is not equal! check the files I/O"
       end if

!Defining the matrix

ndh =  int(-1 +  sqrt( real( 1 + 8* ndh_tot ) ) )

allocate( m_dat(ndh,ndh) )
allocate( eig(ndh) )
allocate( WORK(1) )
allocate( m_dat2(ndh,ndh))
allocate( eig2(ndh) )
allocate( vl(ndh) )
allocate( vr(ndh) )
allocate( eigt(ndh) )
k=1

do i=1,ndh
        do j=i,ndh
        m_dat(i,j)=dat(k)
        m_dat2(i,j)=dat2(k)
        end do
        k=k+1
end do

!Solving with lapack
n=ndh
lda=ndh
ldb=ndh
ldvl=ndh
ldvr=ndh
LWORk=-1

CALL DGGEV( JOBVL, JOBVR, N, M_DAT2, LDA, M_DAT, LDB,&
              EIG, EIG2, EIGT, VL, LDVL,&
              VR, LDVR, WORK, LWORK, INFO)


LWORK= INT(WORK(1))
write(6,*)'from work query',LWORK
deallocate(work)
allocate(WORK(LWORK),STAT=ierr)

CALL DGGEV( JOBVL, JOBVR, N, M_DAT, LDA, M_DAT2, LDB,&
              EIG, EIG2, EIGT, VL, LDVL,&
              VR, LDVR, WORK, LWORK, INFO)

write(6,*)'info=',info
write(6,*)'eig=',eigt

!write(6,*)'vect=',a
! Homework.- get an overlap matrix from NRLMOL

end program evd
