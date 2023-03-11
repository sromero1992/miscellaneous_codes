run_lsm_mpi : lsm_mpi.c
	mpicc lsm_mpi.c -o run_lsm_mpi -std=c99 -fopenmp -llapack -lblas -lm
	mpirun -np 2 ./run_lsm_mpi
