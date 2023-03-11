export OMP_NUM_THREADS=$1
gcc -fopenmp -o run_example omp_prime.c -std=c99
time ./run_example
