PYCON =/usr/lib/python2.7/config/
POL =/usr/local/include/polarssl
PYT =/usr/include/python2.7/

CFLAGS =-L$(PYCON) -L$(POL) -I$(PYT)
OBJ= solve.c find_root.c
MYE= my_exp
MYS= my_sincos
MYC= my_cubic
MYG=my_gamma
RUN=./solve py_flib.py 
VAL1=-8 8
VAL2= 0 2
LABEL=" with Interval [-8,8]"
LABEL2=" with Interval [0,2]"

log.txt: solve   
	echo " $(MYE) $(LABEL) " > log.txt
	$(RUN) $(MYE) $(VAL1) >> log.txt
	echo "$(MYS) $(LABEL)" >> log.txt
	$(RUN) $(MYS) $(VAL1) >> log.txt
	echo " $(MYC) $(LABEL)" >> log.txt
	$(RUN) $(MYC) $(VAL1) >> log.txt
	echo " Initial interval [0,2]" >> log.txt
	echo " $(MYE)" >> log.txt
	$(RUN) $(MYE) $(VAL2) >> log.txt
	echo " $(MYS)" >> log.txt
	$(RUN) $(MYS) $(VAL2) >> log.txt
	echo " $(MYC)" >> log.txt
	$(RUN) $(MYC) $(VAL2) >> log.txt
	echo " $(MYG)" >> log.txt
	$(RUN) $(MYG) $(VAL2) >> log.txt
solve: $(OBJ)
	gcc $(OBJ) -o solve -lpython2.7 -lm $(CFLAGS)
