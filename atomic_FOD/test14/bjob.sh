#/bin/bash
#BSUB -J SICLDA14
#BSUB -n 12
#BSUB -W 24:00
#BSUB -q medium_priority
#BSUB -e error.%J.dat
#BSUB -o output.%J.dat

 /shared/mpi/bin/mpirun -np 12 ./nrlmol_exe > print.log
