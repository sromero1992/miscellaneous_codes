CC = gcc
PYCON =/usr/lib/python2.7/config/
POL =/usr/local/include/polarssl
PYT =/usr/include/python2.7/

CFLAGS =-L$(PYCON) -L$(POL) -I$(PYT)
LIBS=-lm
OBJ= solve.c find_root.c
FUN1=my_exp
FUN2=my_sincos
FUN3=my_cubic
FUN4=my_gamma
MYFUNC= $(FUN4) 
RUN=./solve py_flib.py $(MYFUNC)
VAL1=-8 8
VAL2=0 2
VAL=$(VAL2)


log: solve 
	echo "Function $(MYFUNC) and vals $(VAL)" >> log.txt  
	$(RUN) $(VAL) >> log.txt

solve: $(OBJ)

	$(CC) $(OBJ) -o solve -lpython2.7 $(LIBS) $(CFLAGS)



