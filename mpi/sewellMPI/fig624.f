C/ FIGURE 6.2.4
      SUBROUTINE PCG(A,IROW,JCOL,NZ,X,B,N,D)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
C                                  DECLARATIONS FOR ARGUMENTS
      DOUBLE PRECISION A(NZ),B(N),X(N),D(N)
      INTEGER IROW(NZ),JCOL(NZ)
C                                  DECLARATIONS FOR LOCAL VARIABLES
      DOUBLE PRECISION R(N),P(N),API(N),AP(N),LAMBDA
      include 'mpif.h'
C
C  SUBROUTINE PCG SOLVES THE SYMMETRIC LINEAR SYSTEM A*X=B, USING THE
C     CONJUGATE GRADIENT ITERATIVE METHOD.  THE NON-ZEROS OF A ARE
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
C                                  R0 = D**(-1)*B
C                                  P0 = R0
      R0MAX = 0
      DO 10 I=1,N
         X(I) = 0
         R(I) = B(I)/D(I)
         R0MAX = MAX(R0MAX,ABS(R(I)))
         P(I) = R(I)
   10 CONTINUE
C                                  NITER = MAX NUMBER OF ITERATIONS
      NITER = 3*N 
      DO 90 ITER=1,NITER
C                                  AP = A*P
         DO 20 I=1,N
            API(I) = 0
   20    CONTINUE
         DO 30 IZ=1,NZ
            I = IROW(IZ)
            J = JCOL(IZ)
            API(I) = API(I) + A(IZ)*P(J)
   30    CONTINUE
C                                  MPI_ALLREDUCE COLLECTS THE VECTORS
C                                  API
C                                  (API = LOCAL(A)*P) FROM ALL
C                                  PROCESSORS
C                                  AND ADDS THEM TOGETHER, THEN SENDS
C                                  THE RESULT, AP, BACK TO ALL
C                                  PROCESSORS.
         CALL MPI_ALLREDUCE(API,AP,N,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)
C                                  PAP = (P,AP)
C                                  RP = (R,D*P)
         PAPI = 0.0
         RPI = 0.0
         DO 40 I=ITASK+1,N,NPES
            PAPI = PAPI + P(I)*AP(I)
            RPI = RPI + R(I)*D(I)*P(I)
   40    CONTINUE
         CALL MPI_ALLREDUCE(PAPI,PAP,1,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)
         CALL MPI_ALLREDUCE(RPI,RP,1,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)
C                                  LAMBDA = (R,D*P)/(P,AP)
         LAMBDA = RP/PAP
C                                  X = X + LAMBDA*P
C                                  R = R - LAMBDA*D**(-1)*AP
         DO 50 I=ITASK+1,N,NPES
            X(I) = X(I) + LAMBDA*P(I)
            R(I) = R(I) - LAMBDA*AP(I)/D(I)
   50    CONTINUE
C                                  RAP = (R,AP)
         RAPI = 0.0
         DO 60 I=ITASK+1,N,NPES
            RAPI = RAPI + R(I)*AP(I)
   60    CONTINUE
         CALL MPI_ALLREDUCE(RAPI,RAP,1,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)
C                                  ALPHA = -(R,AP)/(P,AP)
         ALPHA = -RAP/PAP
C                                  P = R + ALPHA*P
         DO 70 I=ITASK+1,N,NPES
            P(I) = R(I) + ALPHA*P(I)
   70    CONTINUE
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
C                                  PCG DOES NOT CONVERGE
      IF (ITASK.EQ.0) PRINT 100
  100 FORMAT('***** PCG DOES NOT CONVERGE *****')
      RETURN
      END
