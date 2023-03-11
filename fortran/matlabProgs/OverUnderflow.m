%This program shows the over flow number m of
% a real number x = +/- q*m^n
clear;clc;
sprintf('This program use x=m^n to calculate the overflow')
m=95;
for n=1:1:500
  x=m^n;
  
       if x == inf % codecimalndition for overflow
          sprintf('The expodecimalnent number is: %d.', n)
          sprintf('for the number : %d.', m)
          sprintf('for one step behind %d. , is: %d.',n-1,m^(n-1)) 

          break;
       end

end

%% This part of the program shows the underflow 
  sprintf('This program use x=m^-n to calculate the underflow')

  for n=1:1:2000
  x=m^-n;
    if    x == 0 %% condition for underflow
          sprintf('The exponent number is: %d.', -n)
          sprintf('for the number : %d.', m)
          sprintf('for one step behind %d. , is: %d.',n-1,m^-(n-1)) 
          break;
    end
  end
