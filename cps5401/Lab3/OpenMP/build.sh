gcc lsm_mp.c -o run_lsm_mp -std=c99 -fopenmp -llapack -lblas -lm
./run_lsm_mp
