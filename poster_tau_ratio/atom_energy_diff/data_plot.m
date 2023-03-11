filename="tau_ratio_lda.txt";
A=importdata(filename);

set title "Energy difference"
set ylabel "Ecomp-Eaccu"
set xlabel "AN"
set grid

for i = 1 : 5
plot(A(i:i+17,i:i+17));

end