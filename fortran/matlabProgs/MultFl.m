% This program helps to find non associative multiplication of floating 
%point numbers.



while true
%  sprintf('Multiplication is associative now')
%x=rand;
%y=rand;
%z=rand;
x=0.00001;
y=0.33333;
z=0.13579;
fl1=x*y;

flfin1=z*fl1;

fl2=y*z;
flfin2=fl2*x; 
  
if flfin1 ~=flfin2
    format long

    sprintf('Multiplication is not associative')
    x
    y
    z
    flfin1
    flfin2
    flfin2-flfin1 % difference!
    break;
  end
end