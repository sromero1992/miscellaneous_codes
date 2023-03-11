.SUFFIXES: .f90 .f .o

FC=gfortran

FLAGS=-O0 -Wall -fbacktrace -fcheck=all

OBJ=fod_opt2.o calc_forces.o calc_energy.o adjust_pos2.o print_max_f.o cgrad.o swap.o logcgr.o

.f90.o:
	$(FC) $(FLAGS) -c $*.f90

BIN=xtest

all:$(OBJ)
	$(FC) $(FLAGS) $(OBJ) -o$(BIN)

clean:
	rm $(OBJ) $(BIN)
