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
   10 CONTINUE

      DO IZ=1,NZ
          IR=IROW(IZ)
          JC=JCOL(IZ)
          A(IR,JC)=AS(IZ)
      END DO

      CALL PLLSQR(A,N,N,X,B)
C                     SOLUTION AT BOX CENTER SHOULD BE ABOUT 0.056
      IF (ITASK.EQ.0) PRINT *, ' Solution at midpoint = ',X((N+1)/2)
      CALL MPI_FINALIZE(IERR)
      STOP
      END

CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      SUBROUTINE PLLSQR(A,M,N,X,B)
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
      AMAX = 6.0
      DO 10 I=1,M
C                              COPY B TO B_, SO B WILL NOT BE ALTERED
         B_(I) = B(I)
   10 CONTINUE
      ERRLIM = 1000*EPS*AMAX
C                              REDUCTION TO ROW ECHELON FORM
      CALL PREDH(A,M,N,B_,PIVOT,NPIVOT,ERRLIM)
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
 
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
     
      SUBROUTINE PREDH(A,M,N,B,PIVOT,NPIVOT,ERRLIM)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
C                              DECLARATIONS FOR ARGUMENTS
      DOUBLE PRECISION A(M,N),B(M),ERRLIM,COL(M)
      INTEGER PIVOT(M),M,N,NPIVOT
C                              DECLARATIONS FOR LOCAL VARIABLES
      DOUBLE PRECISION W(M)
      INCLUDE 'mpif.h'
      CALL MPI_COMM_SIZE (MPI_COMM_WORLD,NPES,IERR)
C                     ITASK = MY PROCESSOR NUMBER
      CALL MPI_COMM_RANK (MPI_COMM_WORLD,ITASK,IERR)


C                              USE HOUSEHOLDER TRANSFORMATIONS TO
C                              REDUCE A TO ROW ECHELON FORM
      I = 1
      DO 30 L=1,N
C                              USE PIVOT A(I,L) TO KNOCK OUT ELEMENTS
C                              I+1 TO M IN COLUMN L.
         IF (I+1.LE.M) THEN
C                              CHOOSE UNIT M-VECTOR W (WHOSE FIRST
C                              I-1 COMPONENTS ARE ZERO) SUCH THAT WHEN
C                              COLUMN L IS PREMULTIPLIED BY
C                              H = I - 2W*W**T, COMPONENTS I+1 THROUGH
C                              M ARE ZEROED.
            
            JTASK = MOD(L-1,NPES)
            IF (JTASK .EQ. ITASK) THEN 
C                                This section is our column
               DO 7 K=I,M
                 COL(K) = A(K,L)
    7          CONTINUE
               CALL CALW(A(1,L),M,W,I)
            END IF
C                              RECEIVE COLUMNI FROM PROCESSOR JTASK
            CALL MPI_BCAST(COL(I),M-I+1,MPI_DOUBLE_PRECISION,JTASK,
     &        MPI_COMM_WORLD,IERR)
            CALL MPI_BCAST(W(I),M-I+1,MPI_DOUBLE_PRECISION,JTASK,
     &        MPI_COMM_WORLD,IERR)

C                              PREMULTIPLY A BY H = I - 2W*W**T
            I0 = (L-1+NPES-(ITASK+1))/NPES
            L0 = ITASK+1+I0*NPES

            DO 15 K=L0,N,NPES
               write(*,*) "K , A(I,K), ITASK ",K,A(I,K),ITASK !This tests the continuity
               WTA = 0.0
               DO 5 J=I,M
                  WTA = WTA + W(J)*A(J,K)
    5          CONTINUE
               TWOWTA = 2*WTA
               DO 10 J=I,M
                  A(J,K) = A(J,K) - TWOWTA*W(J)
C                  CALL MPI_BCAST(A(J,K),1,MPI_DOUBLE_PRECISION,ITASK,
C     &              MPI_COMM_WORLD,IERR)
   10          CONTINUE

   15       CONTINUE
            COL(I) = A(I,L)
            
            CALL MPI_BCAST(COL(I),M-I+1,MPI_DOUBLE_PRECISION,ITASK,
     &       MPI_COMM_WORLD,IERR)
C            CALL MPI_BCAST(A(I,L),M-I+1,MPI_DOUBLE_PRECISION,ITASK,
C     &       MPI_COMM_WORLD,IERR)
C            CALL MPI_BCAST(A,M*N,MPI_DOUBLE_PRECISION,ITASK,
C     &       MPI_COMM_WORLD,IERR)
          
C                              PREMULTIPLY B BY H = I - 2W*W**T
            WTA = 0.0
            DO 20 J=I,M
               WTA = WTA + W(J)*B(J)
   20       CONTINUE
            TWOWTA = 2*WTA
            DO 25 J=I,M
               B(J) = B(J) - TWOWTA*W(J)
   25       CONTINUE
         ENDIF
C                              PIVOT A(I,L) IS NONZERO AFTER PROCESSING
C                              COLUMN L--MOVE DOWN TO NEXT ROW, I+1
C         IF (ABS(A(I,L)).LE.ERRLIM) A(I,L) = 0.0
         IF (ABS(COL(I)).LE.ERRLIM) COL(I) = 0.0
         IF (COL(I).NE.0.0) THEN
C         IF (A(I,L).NE.0.0) THEN
            NPIVOT = I
            PIVOT(NPIVOT) = L
            I = I+1
            IF (I.GT.M) RETURN
         ENDIF
   30 CONTINUE
      RETURN
      END
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC 

      SUBROUTINE CALW(A,M,W,I)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DOUBLE PRECISION A(M),W(M)
      INCLUDE 'mpif.h'
C                              SUBROUTINE CALW CALCULATES A UNIT
C                              M-VECTOR W (WHOSE FIRST I-1 COMPONENTS
C                              ARE ZERO) SUCH THAT PREMULTIPLYING THE
C                              VECTOR A BY H = I - 2W*W**T ZEROES
C                              COMPONENTS I+1 THROUGH M.
      CALL MPI_COMM_SIZE (MPI_COMM_WORLD,NPES,IERR)
C                     ITASK = MY PROCESSOR NUMBER
      CALL MPI_COMM_RANK (MPI_COMM_WORLD,ITASK,IERR)

      S = 0.0
      DO 5 J=I,M
         S = S + A(J)**2
         W(J) = A(J)
    5 CONTINUE
      IF (A(I) .GE. 0.0) THEN
         BETA = SQRT(S)
      ELSE
         BETA = -SQRT(S)
      ENDIF
      W(I) = A(I) + BETA
      TWOALP = SQRT(2*BETA*W(I))
C                              TWOALP=0 ONLY IF A(I),...,A(M) ARE ALL
C                              ZERO.  IN THIS CASE, RETURN WITH W=0
      IF (TWOALP.EQ.0.0) RETURN
C                              NORMALIZE W
      DO 10 J=I,M
         W(J) = W(J)/TWOALP
   10 CONTINUE

      RETURN
      END
