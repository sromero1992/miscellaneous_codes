.SUFFIXES: .f90 .o

FC = gfortran

OBJ = operations.o add.o subst.o

BIN = xops

FLAGS = -O3

LIBS = -lblas

.f90.o:
	$(FC) $(FLAGS) -c $*.f90

all:$(OBJ)
	$(FC) $(FLAGS) $(OBJ) -o$(BIN) $(LIBS)

clean:
	rm $(OBJ) $(BIN)
