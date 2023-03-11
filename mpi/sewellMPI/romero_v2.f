C/ FIGURE 6.2.5
      PARAMETER (M=16,N=(M-1)**3,NZMAX=7*N)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DIMENSION IROW(NZMAX),JCOL(NZMAX),AS(NZMAX),X(N),B(N),D(N),A(N,N)
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
         D(L) = 1.0
   10 CONTINUE

      DO IZ=1,NZ
          IR=IROW(IZ)
          JC=JCOL(IZ)
          A(IR,JC)=AS(IZ)
      END DO

      CALL DLLSQR(A,N,N,X,B)
C                     SOLUTION AT BOX CENTER SHOULD BE ABOUT 0.056
      IF (ITASK.EQ.0) PRINT *, ' Solution at midpoint = ',X((N+1)/2)
      CALL MPI_FINALIZE(IERR)
      STOP
      END





C/ FIGURE 2.2.2
      SUBROUTINE DLLSQR(A,M,N,X,B)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
C                              DECLARATIONS FOR ARGUMENTS
      DOUBLE PRECISION A(M,N),X(N),B(M)
      INTEGER M,N
C                              DECLARATIONS FOR LOCAL VARIABLES
      DOUBLE PRECISION B_(M)
      INTEGER PIVOT(M)
      INCLUDE 'mpif.h'
      CALL MPI_COMM_SIZE (MPI_COMM_WORLD,NPES,IERR)
C                     ITASK = MY PROCESSOR NUMBER
      CALL MPI_COMM_RANK (MPI_COMM_WORLD,ITASK,IERR)

C
C  SUBROUTINE DLLSQR SOLVES THE LINEAR LEAST SQUARES PROBLEM
C
C          MINIMIZE  2-NORM OF (A*X-B)
C
C
C  ARGUMENTS
C
C             ON INPUT                          ON OUTPUT
C             --------                          ---------
C
C    A      - THE M BY N MATRIX.                DESTROYED.
C
C    M      - THE NUMBER OF ROWS IN A.
C
C    N      - THE NUMBER OF COLUMNS IN A.
C
C    X      -                                   AN N-VECTOR CONTAINING
C                                               THE LEAST SQUARES
C                                               SOLUTION.
C
C    B      - THE RIGHT HAND SIDE M-VECTOR.     
C
C-----------------------------------------------------------------------
C                              EPS = MACHINE FLOATING POINT RELATIVE
C                                    PRECISION
C *****************************
      DATA EPS/2.D-16/
C *****************************
C                              AMAX = MAXIMUM ELEMENT OF A
      AMAX = 0.0
      DO 10 I=1,M
C                              COPY B TO B_, SO B WILL NOT BE ALTERED
         B_(I) = B(I)
         DO 5 J=1,N
            AMAX = MAX(AMAX,ABS(A(I,J)))
    5    CONTINUE
   10 CONTINUE
      ERRLIM = 1000*EPS*AMAX
C                              REDUCTION TO ROW ECHELON FORM
      CALL REDQ(A,M,N,B_,PIVOT,NPIVOT,ERRLIM)
C                              CAUTION USER IF SOLUTION NOT UNIQUE.
      IF (NPIVOT.NE.N) THEN
         PRINT 15
   15    FORMAT (' NOTE: SOLUTION IS NOT UNIQUE ')
      ENDIF
C                              ASSIGN VALUE OF ZERO TO NON-PIVOT
C                              VARIABLES.
      DO 20 K=1,N
         X(K) = 0.0
   20 CONTINUE
C                              SOLVE FOR PIVOT VARIABLES USING BACK
C                              SUBSTITUTION.
      DO 30 I=NPIVOT,1,-1
         L = PIVOT(I)
         I0 = (L+NPES-(ITASK+1))/NPES
         L0 = ITASK+1+I0*NPES
         SUMI = 0.0
         DO 25 K=L0,N,NPES
            SUMI = SUMI + A(I,K)*X(K)
   25    CONTINUE
         CALL MPI_ALLREDUCE(SUMI,SUM,1,MPI_DOUBLE_PRECISION,
     &    MPI_SUM,MPI_COMM_WORLD,IERR)
C                              JTASK IS PROCESSOR THAT OWNS A(I,I)
         JTASK = MOD(I-1,NPES)
C                              IF JTASK IS ME, CALCULATE X(I)
         IF (ITASK.EQ.JTASK) THEN
             X(L) = (B_(I)-SUM)/A(I,L)
         END IF
         CALL MPI_BCAST(X(I),1,MPI_DOUBLE_PRECISION,JTASK,
     &    MPI_COMM_WORLD,IERR)

   30 CONTINUE
      RETURN
      END
 





      SUBROUTINE REDQ(A,M,N,B,PIVOT,NPIVOT,ERRLIM)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
C                              DECLARATIONS FOR ARGUMENTS
      DOUBLE PRECISION A(M,N),B(M),ERRLIM,COL(M)
      INTEGER PIVOT(M),M,N,NPIVOT
      INCLUDE 'mpif.h'
      CALL MPI_COMM_SIZE (MPI_COMM_WORLD,NPES,IERR)
C                     ITASK = MY PROCESSOR NUMBER
      CALL MPI_COMM_RANK (MPI_COMM_WORLD,ITASK,IERR)

C                              USE GIVENS ROTATIONS TO REDUCE A
C                              TO ROW ECHELON FORM
      I = 1
      DO 15 L=1,N
C                              USE PIVOT A(I,L) TO KNOCK OUT ELEMENTS
C                              I+1 TO M IN COLUMN L.
C                              JTASK IS PROCESSOR THAT OWNS ACTIVE COLUMN
          JTASK = MOD(L-1,NPES)
          IF (ITASK .EQ. JTASK) THEN
C                              IF JTASK IS ME, SAVE ACTIVE COLUMN IN
C                              VECTOR COLUMNI
           DO 7 K=I,N !instead of L, use I because is the pivot
              COL(K) = A(K,L)
   7       CONTINUE
         ENDIF
C                              RECEIVE COLUMNI FROM PROCESSOR JTASK
         CALL MPI_BCAST(COL(I),N-I+1,MPI_DOUBLE_PRECISION,JTASK,
     &    MPI_COMM_WORLD,IERR)


         DO 10 J=I+1,M
            IF (COL(J).EQ.0.0) GO TO 10
C                              I0 IS FIRST COLUMN >= I THAT BELONGS TO ME
            I0 = (L-1+NPES-(ITASK+1))/NPES
            L0 = ITASK+1+I0*NPES

            DEN = SQRT(COL(I)**2+COL(J)**2)
            C = COL(I)/DEN
            S = COL(J)/DEN
C                              PREMULTIPLY A BY Qij**T
            DO 5 K=L0,N,NPES
               BIK = C*A(I,K) + S*A(J,K)
               BJK =-S*A(I,K) + C*A(J,K)
               A(I,K) = BIK
               A(J,K) = BJK
    5       CONTINUE
C                              PREMULTIPLY B BY Qij**T
            COLI = C*COL(I) + S*COL(J) 
            COLJ =-S*COL(I) + C*COL(J)
            COL(I) = COLI
            COL(J) = COLJ

            BI = C*B(I) + S*B(J)
            BJ =-S*B(I) + C*B(J)
            B(I) = BI
            B(J) = BJ
   10    CONTINUE
C                              PIVOT A(I,L) IS NONZERO AFTER PROCESSING
C                              COLUMN L--MOVE DOWN TO NEXT ROW, I+1
         IF (ABS(COL(I)).LE.ERRLIM) COL(I) = 0.0
         IF (COL(I).NE.0.0) THEN
            NPIVOT = I
            PIVOT(NPIVOT) = L
            I = I+1
            IF (I.GT.M) RETURN
         ENDIF
   15 CONTINUE
      RETURN
      END
