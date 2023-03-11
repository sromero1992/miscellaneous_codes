C/ FIGURE 6.2.5
      PARAMETER (M=40,N=(M-1)**3,NZMAX=7*N)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DIMENSION IROW(NZMAX),JCOL(NZMAX),AS(NZMAX),X(N),B(N),D(N)
      INCLUDE 'mpif.h'
C                     INITIALIZE MPI
      CALL MPI_INIT (IERR)
C                     NPES = NUMBER OF PROCESSORS
      CALL MPI_COMM_SIZE (MPI_COMM_WORLD,NPES,IERR)
C                     ITASK = MY PROCESSOR NUMBER
      CALL MPI_COMM_RANK (MPI_COMM_WORLD,ITASK,IERR)
C                     SOLVE 1.9.10 USING CONJUGATE GRADIENT ITERATION
      H = 1.d0/M
      L = 0
      NZ = 0
      DO 10 I=1,M-1
      DO 10 J=1,M-1
      DO 10 K=1,M-1
         L = L+1
         IF (MOD(L-1,NPES).EQ.ITASK) THEN
C                     DISTRIBUTE L-TH COLUMN TO PROCESSOR MOD(L-1,NPES)
            NZ = NZ + 1
            IROW(NZ) = L
            JCOL(NZ) = L
            AS(NZ) = 6
            IF (K.NE.1) THEN
               NZ = NZ + 1
               IROW(NZ) = L-1
               JCOL(NZ) = L
               AS(NZ) = -1
            ENDIF
            IF (K.NE.M-1) THEN
               NZ = NZ + 1
               IROW(NZ) = L+1
               JCOL(NZ) = L
               AS(NZ) = -1
            ENDIF
            IF (J.NE.1) THEN
               NZ = NZ + 1
               IROW(NZ) = L-(M-1)
               JCOL(NZ) = L
               AS(NZ) = -1
            ENDIF
            IF (J.NE.M-1) THEN
               NZ = NZ + 1
               IROW(NZ) = L+(M-1)
               JCOL(NZ) = L
               AS(NZ) = -1
            ENDIF
            IF (I.NE.1) THEN
               NZ = NZ + 1
               IROW(NZ) = L-(M-1)**2
               JCOL(NZ) = L
               AS(NZ) = -1
            ENDIF
            IF (I.NE.M-1) THEN
               NZ = NZ + 1
               IROW(NZ) = L+(M-1)**2
               JCOL(NZ) = L
               AS(NZ) = -1
            ENDIF
         ENDIF
         B(L) = H**2
   10 CONTINUE
      CALL JACOBI(AS,IROW,JCOL,NZ,X,B,N)
C                     SOLUTION AT BOX CENTER SHOULD BE ABOUT 0.056
      IF (ITASK.EQ.0) PRINT *, ' Solution at midpoint = ',X((N+1)/2)
      CALL MPI_FINALIZE(IERR)
      STOP
      END




C/ FIGURE 6.2.4
      SUBROUTINE JACOBI(A,IROW,JCOL,NZ,X,B,N)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
C                                  DECLARATIONS FOR ARGUMENTS
      DOUBLE PRECISION A(NZ),B(N),X(N)
      INTEGER IROW(NZ),JCOL(NZ)
C                                  DECLARATIONS FOR LOCAL VARIABLES
      DOUBLE PRECISION R(N),Ax(N),D(N)
      DOUBLE PRECISION Xi(N),Ri(N),Axi(N),DI(N)

      include 'mpif.h'
C
C  SUBROUTINE JACOBI SOLVES THE SYMMETRIC LINEAR SYSTEM A*X=B, USING THE
C     JACOBI ITERATIVE METHOD.  THE NON-ZEROS OF A ARE
C     STORED
C     IN SPARSE FORMAT.  THE COLUMNS OF A ARE DISTRIBUTED CYCLICALLY
C     OVER
C     THE AVAILABLE PROCESSORS.
C
C  ARGUMENTS
C
C             ON INPUT                          ON OUTPUT
C             --------                          ---------
C
C    A      - A(IZ) IS THE MATRIX ELEMENT IN
C             ROW IROW(IZ), COLUMN JCOL(IZ),
C             FOR IZ=1,...,NZ. ELEMENTS WITH
C             MOD(JCOL(IZ)-1,NPES)=ITASK
C             ARE STORED ON PROCESSOR ITASK.
C
C    IROW   - (SEE A).
C
C    JCOL   - (SEE A).
C
C    NZ     - NUMBER OF NONZEROS STORED ON
C             THE LOCAL PROCESSOR.
C
C    X      -                                   AN N-VECTOR CONTAINING
C                                               THE SOLUTION.
C
C    B      - THE RIGHT HAND SIDE N-VECTOR.
C
C    N      - SIZE OF MATRIX A.
C
C    D      - VECTOR HOLDING A DIAGONAL 
C             PRECONDITIONING MATRIX.
C             D = DIAGONAL(A) IS RECOMMENDED.
C             D(I) = 1 FOR NO PRECONDITIONING
C
C-----------------------------------------------------------------------
C                                  NPES = NUMBER OF PROCESSORS
      CALL MPI_COMM_SIZE (MPI_COMM_WORLD,NPES,IERR)
C                                  ITASK = MY PROCESSOR NUMBER
      CALL MPI_COMM_RANK (MPI_COMM_WORLD,ITASK,IERR)
C                                  X0 = 0
C                                  R0 = B
C                                  P0 = R0
         R0MAX = 0
C        Initialization of vectors
         DO 10 I=1,N
         X(I) = 0
         D(I)=0
         DI(I)=0
         R0MAX = max(R0MAX,abs(B(I)))
   10    CONTINUE
          DO 15 IZ=1,NZ
             I=IROW(IZ)
             J=JCOL(IZ)
             IF (MOD(I-1,NPES).EQ.ITASK) THEN
                if (I .EQ. J) THEN
                 DI(I)=A(IZ) ! This diagonal needs good care
                end if
             END IF
   15    CONTINUE
         CALL MPI_ALLREDUCE(DI,D,N,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)

C        write(*,*) "D(:) : ", D(:) !,D(1),D((N+1)/2),D(N) 
C                    NITER = MAX NUMBER OF ITERATIONS
      NITER = 3*N 
      DO 90 ITER=1,NITER
C                                  Ax = A*x
         DO 20 I=1,N
             Axi(I)=0
   20    CONTINUE

         DO 30 IZ=1+ITASK,NZ,NPES
            I = IROW(IZ)
            J = JCOL(IZ)
            Axi(I) = Axi(I) + A(IZ)*X(J)
   30    CONTINUE
C                                  MPI_ALLREDUCE COLLECTS THE VECTORS
C                                  Axi
C                                  (Axi = LOCAL(A)*x) FROM ALL
C                                  PROCESSORS
C                                  AND ADDS THEM TOGETHER, THEN SENDS
C                                  THE RESULT, Ax, BACK TO ALL
C                                  PR OCESSORS.
         CALL MPI_ALLREDUCE(Axi,Ax,N,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)
C         write(*,*) "Ax(:) : ",Ax(1),Ax((N+1)/2),Ax(N) 
C                       X=Xless - R / D          
C                       R=b-Ax
C        J=A(i,i) which must be Diag(A)
C       Jacobi iteration
         DO 40 I=1+ITASK,N,NPES
            Ri(I)=B(I)-Ax(I)
            Xi(I)=Xi(I)+Ri(I)/D(I)
   40    CONTINUE
         CALL MPI_ALLREDUCE(Ri,R,N,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)
         CALL MPI_ALLREDUCE(Xi,X,N,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)

         write(*,*) "R(:) : ",R(1),R((N+1)/2),R(N)
C         write(*,*) "X(:) : ",X(1),X((N+1)/2),X(N) 
C                                  RMAX = MAX OF RESIDUAL (R)
         RMAXI = 0
         DO 80 I=ITASK+1,N,NPES
            RMAXI = MAX(RMAXI,ABS(R(I)))
   80    CONTINUE
         CALL MPI_ALLREDUCE(RMAXI,RMAX,1,MPI_DOUBLE_PRECISION,
     &    MPI_MAX,MPI_COMM_WORLD,IERR)
C                                  IF CONVERGED, MERGE PORTIONS OF X
C                                  STORED ON DIFFERENT PROCESSORS
         IF (RMAX.LE.1.D-10*R0MAX) THEN
            IF (ITASK.EQ.0) PRINT *, ' Number of iterations = ',ITER
            CALL MPI_ALLREDUCE(X,R,N,MPI_DOUBLE_PRECISION,
     &       MPI_SUM,MPI_COMM_WORLD,IERR)
            X(1:N) = R(1:N)
            RETURN
         ENDIF
   90 CONTINUE
C                                  JACOBI DOES NOT CONVERGE
      IF (ITASK.EQ.0) PRINT 100
  100 FORMAT('***** JACOBI DOES NOT CONVERGE *****')
      RETURN
      END
