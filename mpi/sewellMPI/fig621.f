C/ FIGURE 6.2.1
      SUBROUTINE PLINEQ(A,N,X,B)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
C                                 DECLARATIONS FOR ARGUMENTS
      DOUBLE PRECISION A(N,N),X(N),B(N)
C                                 DECLARATIONS FOR LOCAL VARIABLES
      DOUBLE PRECISION B_(N),LJI,COLUMNI(N)
      INCLUDE 'mpif.h'
C
C  SUBROUTINE PLINEQ SOLVES THE LINEAR SYSTEM A*X=B
C
C  ARGUMENTS
C
C             ON INPUT                          ON OUTPUT
C             --------                          ---------
C
C    A      - THE N BY N COEFFICIENT MATRIX.    DESTROYED
C
C    N      - THE SIZE OF MATRIX A.
C
C    X      -                                   AN N-VECTOR CONTAINING
C                                               THE SOLUTION.
C
C    B      - THE RIGHT HAND SIDE N-VECTOR.     
C
C-----------------------------------------------------------------------
C                              INITIALIZE MPI
      CALL MPI_INIT (IERR)
C                              NPES = NUMBER OF PROCESSORS
      CALL MPI_COMM_SIZE (MPI_COMM_WORLD,NPES,IERR)
C                              ITASK = MY PROCESSOR NUMBER (0,1,...,NPES-1).
C                              I WILL NEVER TOUCH ANY COLUMNS OF A EXCEPT
C                              MY COLUMNS, ITASK+1+ K*NPES, K=0,1,2,...
      CALL MPI_COMM_RANK (MPI_COMM_WORLD,ITASK,IERR)
C                              COPY B TO B_, SO B WILL NOT BE ALTERED
      B_(1:N) = B(1:N) 
C                              BEGIN FORWARD ELIMINATION
      DO 35 I=1,N
C                              JTASK IS PROCESSOR THAT OWNS ACTIVE COLUMN
         JTASK = MOD(I-1,NPES)
         IF (ITASK.EQ.JTASK) THEN
C                              IF JTASK IS ME, SAVE ACTIVE COLUMN IN
C                              VECTOR COLUMNI
            DO 10 J=I,N
               COLUMNI(J) = A(J,I)
   10       CONTINUE
         ENDIF
C                              RECEIVE COLUMNI FROM PROCESSOR JTASK
         CALL MPI_BCAST(COLUMNI(I),N-I+1,MPI_DOUBLE_PRECISION,JTASK,
     &    MPI_COMM_WORLD,IERR)
C                              SEARCH FROM A(I,I) ON DOWN FOR LARGEST
C                              POTENTIAL PIVOT, A(L,I)
         BIG = ABS(COLUMNI(I))
         L = I
         DO 15 J=I+1,N
            IF (ABS(COLUMNI(J)).GT.BIG) THEN
               BIG = ABS(COLUMNI(J))
               L = J
            ENDIF
   15    CONTINUE
C                              IF LARGEST POTENTIAL PIVOT IS ZERO,
C                              MATRIX IS SINGULAR
         IF (BIG.EQ.0.0) GO TO 50
C                              I0 IS FIRST COLUMN >= I THAT BELONGS TO ME
         L0 = (I-1+NPES-(ITASK+1))/NPES
         I0 = ITASK+1+L0*NPES
C                              SWITCH ROW I WITH ROW L, TO BRING UP
C                              LARGEST PIVOT; BUT ONLY IN MY COLUMNS
         DO 20 K=I0,N,NPES
            TEMP = A(L,K)
            A(L,K) = A(I,K)
            A(I,K) = TEMP
   20    CONTINUE
         TEMP = COLUMNI(L)
         COLUMNI(L) = COLUMNI(I)
         COLUMNI(I) = TEMP
C                              SWITCH B_(I) AND B_(L)
         TEMP = B_(L)
         B_(L) = B_(I)
         B_(I) = TEMP
         DO 30 J=I+1,N
C                              CHOOSE MULTIPLIER TO ZERO A(J,I)
            LJI = COLUMNI(J)/COLUMNI(I)
            IF (LJI.NE.0.0) THEN
C                              SUBTRACT LJI TIMES ROW I FROM ROW J;
C                              BUT ONLY IN MY COLUMNS
               DO 25 K=I0,N,NPES
                  A(J,K) = A(J,K) - LJI*A(I,K)
   25          CONTINUE
C                              SUBTRACT LJI TIMES B_(I) FROM B_(J)
               B_(J) = B_(J) - LJI*B_(I)
            ENDIF
   30    CONTINUE
   35 CONTINUE
C                              SOLVE U*X=B_ USING BACK SUBSTITUTION.
      DO 45 I=N,1,-1
C                              I0 IS FIRST COLUMN >= I+1 THAT BELONGS
C                              TO ME
         L0 = (I+NPES-(ITASK+1))/NPES
         I0 = ITASK+1+L0*NPES
         SUMI = 0.0
         DO 40 J=I0,N,NPES
            SUMI = SUMI + A(I,J)*X(J)
   40    CONTINUE 
         CALL MPI_ALLREDUCE(SUMI,SUM,1,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)
C                              JTASK IS PROCESSOR THAT OWNS A(I,I)
         JTASK = MOD(I-1,NPES)
C                              IF JTASK IS ME, CALCULATE X(I)
         IF (ITASK.EQ.JTASK) THEN 
            X(I) = (B_(I)-SUM)/A(I,I)
         ENDIF
C                              RECEIVE X(I) FROM PROCESSOR JTASK
         CALL MPI_BCAST(X(I),1,MPI_DOUBLE_PRECISION,JTASK,
     &   MPI_COMM_WORLD,IERR)
   45 CONTINUE
      GO TO 60
   50 IF (ITASK.EQ.0) PRINT 55
   55 FORMAT ('***** THE MATRIX IS SINGULAR *****')
C                              CLOSE MPI
   60 CONTINUE
      CALL MPI_FINALIZE(IERR)
      RETURN
      END
