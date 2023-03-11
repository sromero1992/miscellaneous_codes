mpicc -o run_lsm_mpi lsm_mpi.c -std=c99 -llapack -lblas -lm
mpirun -np 2 ./run_lsm_mpi
