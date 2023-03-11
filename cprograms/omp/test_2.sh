export OMP_NUM_THREADS=$1
gcc -fopenmp -o run_example omp_iv.c -std=c99
for i in `seq 1 10`;
do
  ./run_example
done
