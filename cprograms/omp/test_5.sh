export OMP_NUM_THREADS=$1
gcc -fopenmp -o run_example omp_ip.c -std=c99
./run_example
